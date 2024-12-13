import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hommie/services/networking/home_assitant_websocket/ha_auth_token.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_auth_handler.dart';

enum HASocketState {
  connecting,
  connected,
  authenticated,
  disconnected,
  reconnecting,
}

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
  late final StreamController<dynamic> _outerStreamController;

  final _stateController = StreamController<HASocketState>.broadcast();
  HASocketState _state = HASocketState.disconnected;

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

  int? get closeCode => _innerChanel.closeCode;
  String? get closeReason => _innerChanel.closeReason;

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
    _initializeStreamController();

    _initializeAuthHandler();

    _startConnection();
  }

  void _initializeAuthHandler() {
    _authHandler!
      ..onAuthResult = (result) {
        switch (result) {
          case AuthResultSuccess(haVersion: final version):
            haVersion = version;
            _setState(HASocketState.authenticated);
            break;
          case AuthResultError(message: final message):
            _handleConnectionError(message);
            break;
          case AuthResultPending():
            _setState(HASocketState.connecting);
            break;
          case AuthResultInvalid(message: final message):
            _handleConnectionError(message);
            break;
        }
      }
      ..sendMessage = sendMessage;
  }

  void _initializeStreamController() {
    _outerStreamController = StreamController.broadcast();
    _outerStreamController.onListen = () => logger.t('New listener added!');
    _outerStreamController.onCancel = () => logger.t('Listener unsubscribed!');
  }

  void _setState(HASocketState newState) {
    _state = newState;
    _stateController.add(newState);
    logger.d('Socket state changed to: $newState');
  }

  void _startConnection() async {
    try {
      _setState(HASocketState.connecting);
      _innerChanel = _createWebSocketChannel();
      await _waitForConnection();
      _configureSocketStream();
    } catch (e) {
      _handleConnectionError('Failed to start connection: $e');
    }
  }

  WebSocketChannel _createWebSocketChannel() {
    return IOWebSocketChannel.connect(
      _config.wsUri,
      pingInterval: _config.pingInterval,
      connectTimeout: _config.connectionTimeout,
    );
  }

  Future<void> _waitForConnection() async {
    try {
      await _innerChanel.ready;
    } on SocketException catch (e) {
      _handleConnectionError('Socket connection failed: $e');
    } on TimeoutException catch (e) {
      _handleConnectionError('Connection timed out: $e');
    } on WebSocketChannelException catch (e) {
      _handleConnectionError('WebSocket error: $e');
    }
  }

  void _configureSocketStream() {
    _innerChanel.stream.listen(
      (event) {
        if (_state != HASocketState.authenticated) {
          final messageJson = jsonDecode(event);
          _authHandler!.handleAuthMessage(messageJson);
        }

        _outerStreamController.add(event);
      },
      onError: (error) => _handleConnectionError('Socket error: $error'),
      onDone: _handleSocketClosure,
      cancelOnError: true,
    );
  }

  void _handleSocketClosure() {
    _setState(HASocketState.disconnected);
    logger.t(
        "Inner socket is closed. Code ${_innerChanel.closeCode} Reason: ${_innerChanel.closeReason}");
    if (!_outerStreamController.isClosed) {
      _outerStreamController.close();
    }
  }

  void _handleConnectionError(String message) {
    logger.e(message);
    _setState(HASocketState.disconnected);
    if (!_outerStreamController.isClosed) {
      _outerStreamController.addError(message);
      _outerStreamController.close();
    }
  }

  void sendMessage(HABaseMessgae message) {
    final encodedData = message.toJson();
    logger.t("Sending message: $encodedData");

    _innerChanel.sink.add(encodedData);
  }

  bool isClosed() {
    return _outerStreamController.isClosed;
  }

  void close() {
    _setState(HASocketState.disconnected);
    logger.t("Closing socket");
    _innerChanel.sink.close();
    if (!_outerStreamController.isClosed) {
      _outerStreamController.close();
    }
    _stateController.close();
  }
}

typedef TokenRefreshCallback = Future<HAAuthToken> Function();

class HAConnectionOption {
  HAAuthToken _credentials;
  final TokenRefreshCallback? _onTokenRefresh;

  HAConnectionOption(this._credentials, {TokenRefreshCallback? onTokenRefresh})
      : _onTokenRefresh = onTokenRefresh;

  Future<void> refreshTokenIfNeeded() async {
    if (_credentials.isExpired && _onTokenRefresh != null) {
      try {
        _credentials = await _onTokenRefresh();
        logger.i("Token refreshed successfully");
      } catch (e) {
        logger.e("Failed to refresh token", error: e);
        rethrow;
      }
    }
  }

  Future<HASocket> createSocket() async {
    await refreshTokenIfNeeded();

    final serverUri = _credentials.serverUri;
    if (serverUri == null) {
      throw Exception("Token endpoint is null");
    }

    final serverUrl = _buildWebSocketUrl(serverUri);
    logger.i("Trying to establish a new connection to $serverUrl");

    final completer = Completer<HASocket>();
    _connect(Uri.parse(serverUrl), completer);

    return completer.future;
  }

  String _buildWebSocketUrl(Uri baseUrl) {
    final scheme = switch (baseUrl.scheme) {
      "http" => "ws",
      "https" => "wss",
      _ => throw Exception("Unsupported scheme: ${baseUrl.scheme}"),
    };

    final host = baseUrl.host;
    final port = baseUrl.port;

    return "$scheme://$host:$port/api/websocket";
  }

  void _connect(Uri uri, Completer<HASocket> completer) {
    final socket = HASocket.connect(
      wsUri: uri,
      authToken: _credentials,
    );

    StreamSubscription<HASocketState>? stateSubscription;
    StreamSubscription<dynamic>? messageSubscription;

    void cleanup() {
      stateSubscription?.cancel();
      messageSubscription?.cancel();
    }

    stateSubscription = socket.stateStream.listen(
      (state) {
        if (state == HASocketState.authenticated) {
          cleanup();
          completer.complete(socket);
        }
      },
      onError: (error) {
        cleanup();
        _completeWithError(completer, error);
      },
    );

    messageSubscription = socket.stream.listen(
      null, // We don't need to handle messages here as auth is handled by HASocket
      onError: (error) {
        cleanup();
        _completeWithError(completer, error);
      },
      onDone: () {
        if (!completer.isCompleted) {
          cleanup();
          _completeWithError(
            completer,
            Exception("Socket closed before authentication"),
          );
        }
      },
    );
  }

  void _completeWithError(Completer completer, Object error) {
    if (!completer.isCompleted) {
      completer.completeError(error);
    }
  }
}
