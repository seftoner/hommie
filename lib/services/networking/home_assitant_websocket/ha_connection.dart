import 'dart:async';

import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/hass_subscription.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/web_socket_response.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assitant_websocket/backoff.dart';
import 'package:hommie/services/networking/home_assitant_websocket/message_handler.dart';

/// Interface for Home Assistant websocket connection.
abstract class IHAConnection {
  /// Sends a message to Home Assistant and returns the response.
  Future<dynamic> sendMessage(HABaseMessgae message);

  /// Subscribes to Home Assistant events.
  /// Returns a [HassSubscription] that can be used to receive events and unsubscribe.
  HassSubscription subscribeMessage(HABaseMessgae subscribeMessage);

  /// Closes the connection.
  void close();
}

/// Implementation of Home Assistant websocket connection.
/// Handles connection management, message sending, and event subscriptions.
class HAConnection implements IHAConnection {
  HASocket? _socket;
  StreamSubscription<dynamic>? _socketSubscription;

  final HAConnectionOption _haConnectionOption;
  final Backoff _backoff;
  bool _closeRequested = false;
  bool _reconnectScheduled = false;
  final HAMessageHandler _messageHandler;
  final HAConnectionState _connectionState;

  HAConnection(this._haConnectionOption, [Backoff? backoff])
      : _backoff = backoff ?? const ConstantBackoff(Duration(seconds: 5)),
        _messageHandler = HAMessageHandler(),
        _connectionState = HAConnectionState();

  /// Stream of connection state changes.
  Stream<HASocketState> get state => _connectionState.stateStream;

  /// Current connection state.
  HASocketState get currentState =>
      _socket?.state ?? HASocketState.disconnected;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  final Map<int, Completer> _commands = {};
  final Map<int, HassSubscription> _subscriptions = {};
  int get _getCommndID => _commndID++;

  /// Establishes connection to Home Assistant.
  /// Throws an exception if connection fails.
  Future<void> connect() async {
    if (_socket != null) {
      logger.w("Connection already exists");
      return;
    }

    _closeRequested = false;
    try {
      final socket = await _haConnectionOption.createSocket();
      _setSocket(socket);
    } catch (e) {
      logger.e("Connection failed: $e");
      if (!_closeRequested) {
        _reconnect();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> sendMessage(HABaseMessgae message) async {
    assert(!_socket!.isClosed(), "Connections is closed");

    var completer = Completer<dynamic>();
    var id = _getCommndID;
    _commands[id] = completer;
    message.id = id;
    _socket!.sendMessage(message);

    return completer.future;
  }

  @override
  void close() {
    _closeRequested = true;
    _reconnectScheduled = false;
    _backoff.reset();
    _socketSubscription?.cancel();
    _socket?.close();
    _socket = null;
    _connectionState.dispose();
  }

  @override
  HassSubscription subscribeMessage(HABaseMessgae subscribeMessage) {
    assert(!_socket!.isClosed(), "Connections is closed");

    var id = _getCommndID;

    var hassSubscribtion = HassSubscription(unsubscribe: () async {
      if (!_socket!.isClosed()) {
        await sendMessage(UnsubscribeEventsMessage(subsctibtionID: id));
      }
      final removedSubscribtion = _subscriptions.remove(id);
      removedSubscribtion?.dispose();
    });

    _subscriptions[id] = hassSubscribtion;

    subscribeMessage.id = id;
    _socket!.sendMessage(subscribeMessage);
    return hassSubscribtion;
  }

  void _messageListener(dynamic incomingMessage) {
    logger.t("Server response: $incomingMessage");

    try {
      final messages = _messageHandler.parseMessages(incomingMessage);
      for (final response in messages) {
        _handleResponse(response);
      }
    } catch (e) {
      logger.e("Failed to handle message", error: e);
      _handleError(e);
    }
  }

  void _handleResponse(WebSocketResponse response) {
    _messageHandler.handleResponse(
      response,
      onPong: () => _handlePongResponse(response.id),
      onEvent: (event) => _handleEventResponse(response.id, event),
      onSuccess: (result) => _handleSuccessResponse(response.id, result),
      onError: (error) => _handleErrorResponse(response.id, error),
    );
  }

  void _handlePongResponse(int id) {
    logger.d("Receive pong");
    final completer = _commands.remove(id);
    completer?.complete();
  }

  void _handleEventResponse(int id, dynamic event) {
    final subscription = _subscriptions[id];
    if (subscription != null) {
      subscription.emit(event);
    } else {
      logger.e("Unknown subscription $id, unsubscribing");
      sendMessage(UnsubscribeEventsMessage(subsctibtionID: id))
          .catchError((e) => logger.e("Error unsubscribing: $e"));
    }
  }

  void _handleSuccessResponse(int id, dynamic result) {
    final completer = _commands.remove(id);
    completer?.complete(result);
  }

  void _handleErrorResponse(int id, dynamic error) {
    final completer = _commands.remove(id);
    completer?.completeError(error);
  }

  void _handleClose() {
    _commndID = 1;
    _commands.forEach((key, value) {
      value.completeError("Connection lost 📡");
    });
    _commands.clear();
    _socketSubscription?.cancel();

    _socket = null;

    if (!_closeRequested) {
      _reconnect();
    }

    _connectionState.setState(HASocketState.disconnected);
    logger.d("Connection closed");
  }

  void _reconnect() {
    if (_reconnectScheduled) return;
    _reconnectScheduled = true;

    final delay = _backoff.next;
    logger.i("Scheduling reconnection in ${delay.inSeconds} seconds");

    Future.delayed(delay, () {
      _reconnectScheduled = false;
      if (!_closeRequested) {
        _connectionState.setState(HASocketState.reconnecting);
        connect().catchError((e) {
          logger.e("Reconnection failed", error: e);
          _reconnect(); // Try again if failed
        });
      }
    });
  }

  void _handleError(dynamic error) {
    logger.e(error);
  }

  void _setSocket(HASocket socket) {
    _socket = socket;

    _socketSubscription?.cancel();
    _socketSubscription = socket.stream
        .listen(_messageListener, onDone: _handleClose, onError: _handleError);

    _connectionState.connectToSocket(socket);
    logger.i("Connection established 🤝");
  }
}

class HAConnectionState {
  final StreamController<HASocketState> _controller;
  HASocketState _currentState;
  StreamSubscription<HASocketState>? _socketSubscription;

  Stream<HASocketState> get stateStream => _controller.stream;
  HASocketState get currentState => _currentState;

  HAConnectionState()
      : _controller = StreamController<HASocketState>.broadcast(),
        _currentState = HASocketState.disconnected;

  void connectToSocket(HASocket socket) {
    _socketSubscription?.cancel();
    _socketSubscription = socket.stateStream.listen(
      (newState) {
        setState(newState);
      },
      onError: (error) {
        logger.e("Socket state error: $error");
      },
    );

    setState(socket.state);
  }

  void setState(HASocketState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      _controller.add(newState);
      logger.d('Connection state changed to: $newState');
    }
  }

  void dispose() {
    _socketSubscription?.cancel();
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}
