import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hommie/services/networking/home_assitant_websocket/ha_auth_token.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket_state.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_auth_handler.dart';

class HASocketConfig {
  final Uri wsUri;
  final Duration pingInterval;
  final Duration connectionTimeout;

  const HASocketConfig({
    required this.wsUri,
    required this.pingInterval,
    required this.connectionTimeout,
  });
}

class HASocket {
  final HASocketConfig _config;
  final HAAuthHandler? _authHandler;

  late final String haVersion;
  late WebSocketChannel _innerChanel;
  bool _invalidAuth = false;
  late final StreamController<dynamic> _outerStreamController;

  final _stateController = StreamController<HASocketState>.broadcast();
  HASocketState _state = HASocketState.disconnected();

  /// A stream of [HASocketState] changes for the Home Assistant WebSocket connection.
  ///
  /// Listen to this stream to be notified of connection state changes.
  ///
  /// Returns a [Stream<HASocketState>] that emits the current state whenever it changes.
  ///
  /// See also:
  /// * [state] for getting the current state synchronously
  /// * [HASocketState] for possible connection states
  Stream<HASocketState> get stateStream => _stateController.stream;

  /// The current [HASocketState] of the Home Assistant WebSocket connection.
  ///
  /// This getter provides synchronous access to the current connection state.
  ///
  /// See [stateStream] for receiving state updates asynchronously.
  HASocketState get state => _state;

  /// Returns a [Stream] of dynamic data from the WebSocket connection.
  ///
  /// This stream provides real-time updates and messages from the Home Assistant
  /// WebSocket API. Subscribers to this stream will receive all incoming messages
  /// from the Home Assistant server.
  Stream<dynamic> get stream => _outerStreamController.stream;

  /// Returns `true` if the underlying WebSocket connection is closed.
  ///
  /// This getter checks the state of the outer stream controller to determine
  /// if the connection has been terminated.
  bool get isClosed => _outerStreamController.isClosed;

  int? get closeCode => _innerChanel.closeCode;
  String? get closeReason => _innerChanel.closeReason;
  bool get isAuthInvalid => _invalidAuth;

  HASocket.connect({
    required Uri wsUri,
    required HAAuthToken authToken,
  })  : _config = HASocketConfig(
          wsUri: wsUri,
          pingInterval: const Duration(seconds: 5),
          connectionTimeout: const Duration(seconds: 10),
        ),
        _authHandler = HAAuthHandler(
          authToken: authToken,
          onAuthResult: null,
          sendMessage: null,
        ) {
    _outerStreamController = StreamController.broadcast();

    _initializeAuthHandler();

    _startConnection();
  }

  void _initializeAuthHandler() {
    _authHandler!
      ..onAuthResult = (result) {
        switch (result) {
          case AuthResultSuccess(haVersion: final version):
            haVersion = version;
            _setState(HASocketState.authenticated());
            break;
          case AuthResultError(message: final message):
            _setState(HASocketState.disconnected(
              reason: 'Authentication error: $message',
              type: DisconnectionType.error,
            ));
            logger.e('Authentication error: $message');
            break;
          case AuthResultPending():
            _setState(HASocketState.connecting());
            break;
          case AuthResultInvalid(message: final message):
            _invalidAuth = true;
            _setState(HASocketState.disconnected(
              reason: 'Invalid authentication: $message',
              type: DisconnectionType.authFailure,
            ));
            logger.e('Invalid authentication: $message');
            break;
        }
      }
      ..sendMessage = sendMessage;
  }

  void _setState(HASocketState newState) {
    _state = newState;
    _stateController.add(newState);
    logger.d('Socket state changed to: ${newState.runtimeType}');
  }

  void _startConnection() async {
    try {
      _setState(HASocketState.connecting());
      _innerChanel = _createWebSocketChannel();
      await _innerChanel.ready;
      _configureSocketStream();
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  void _handleConnectionError(dynamic error) {
    final String reason;
    if (error is SocketException) {
      reason = 'Socket connection failed';
    } else if (error is TimeoutException) {
      reason = 'Connection timed out';
    } else if (error is WebSocketChannelException) {
      reason = 'WebSocket error';
    } else {
      reason = 'Failed to start connection';
    }

    _setState(HASocketState.disconnected(
      reason: '$reason: $error',
      type: DisconnectionType.error,
    ));
    logger.e('$reason: $error');
  }

  WebSocketChannel _createWebSocketChannel() {
    return IOWebSocketChannel.connect(
      _config.wsUri,
      pingInterval: _config.pingInterval,
      connectTimeout: _config.connectionTimeout,
    );
  }

  void _configureSocketStream() {
    _innerChanel.stream.listen(
      (event) {
        if (_state is! Authenticated) {
          final messageJson = jsonDecode(event);
          _authHandler!.handleAuthMessage(messageJson);
        }
        _outerStreamController.add(event);
      },
      onDone: _handleSocketClosure,
      cancelOnError: true,
    );
  }

  void _handleSocketClosure() {
    final reason =
        "Inner socket is closed. Code ${_innerChanel.closeCode} Reason: ${_innerChanel.closeReason}";
    logger.t(reason);

    if (_invalidAuth) {
      logger.e("Authentication is invalid - token might be revoked");
      _setState(HASocketState.disconnected(
        reason: reason,
        type: DisconnectionType.authFailure,
      ));
    } else {
      _setState(HASocketState.disconnected(
        reason: reason,
        type: _innerChanel.closeCode == 1000
            ? DisconnectionType.normal
            : DisconnectionType.error,
      ));
    }

    if (!_outerStreamController.isClosed) {
      if (_invalidAuth) {
        _outerStreamController.addError("Authentication failed");
      }
      _outerStreamController.close();
    }
  }

  void sendMessage(HABaseMessgae message) {
    final encodedData = message.toJson();
    logger.t("Sending message: $encodedData");

    _innerChanel.sink.add(encodedData);
  }

  void close() {
    _setState(HASocketState.disconnected());
    logger.t("Closing socket");
    _innerChanel.sink.close();
    if (!_outerStreamController.isClosed) {
      _outerStreamController.close();
    }
    _stateController.close();
  }
}
