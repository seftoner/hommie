import 'dart:async';

import 'package:hommie/services/networking/home_assistant_websocket/ha_connection_option.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/ha_connection_state.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/ha_messages.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/ha_socket.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_socket_state.dart';
import 'package:hommie/services/networking/home_assistant_websocket/hass_subscription.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/types/web_socket_response.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/message_handler.dart';

/// Interface for Home Assistant websocket connection.
abstract class IHAConnection {
  /// Sends a message to Home Assistant and returns the response.
  Future<dynamic> sendMessage(HABaseMessage message);

  /// Subscribes to Home Assistant events.
  /// Returns a [HassSubscription] that can be used to receive events and unsubscribe.
  HassSubscription subscribeMessage(HABaseMessage subscribeMessage);

  /// Closes the connection.
  Future<void> close();
}

/// Implementation of Home Assistant websocket connection.
/// Handles connection management, message sending, and event subscriptions.
/// Note: This class no longer handles reconnection logic - use ConnectionOrchestrator for that.
class HAConnection implements IHAConnection {
  HASocket? _socket;
  StreamSubscription<dynamic>? _socketSubscription;

  final HAConnectionOption _haConnectionOption;
  final HAMessageHandler _messageHandler;
  final HAConnectionState _connectionState;

  HAConnection(this._haConnectionOption)
      : _messageHandler = HAMessageHandler(),
        _connectionState = HAConnectionState();

  /// Stream of connection state changes.
  Stream<HASocketState> get state => _connectionState.stateStream;

  /// Current connection state.
  HASocketState get currentState => _connectionState.currentState;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commandID = 2;
  final Map<int, Completer> _commands = {};
  final Map<int, HassSubscription> _subscriptions = {};
  int get _getCommandID => _commandID++;

  /// Establishes connection to Home Assistant.
  Future<void> connect() async {
    if (_socket != null) {
      logger.w('Connection already exists');
      return;
    }

    try {
      final socket = await _haConnectionOption.createSocket();
      _setSocket(socket);
    } on AuthenticationError catch (e) {
      logger.e('Connection failed: $e');
      _connectionState.setState(HASocketState.disconnected(
        type: DisconnectionType.authFailure,
        reason: e.toString(),
      ));
      rethrow; // Let the orchestrator handle this
    } on ConnectionError catch (e) {
      logger.e('Connection failed: $e');
      _connectionState.setState(HASocketState.disconnected(
        type: DisconnectionType.error,
        reason: e.toString(),
      ));
      rethrow; // Let the orchestrator handle this
    }
  }

  @override
  Future<dynamic> sendMessage(HABaseMessage message,
      {Duration timeout = const Duration(seconds: 15)}) async {
    // Replace assertion with runtime check for better error handling
    if (_socket == null || _socket!.isClosed) {
      return Future.error(ConnectionClosedError('Connection is closed'));
    }

    final completer = Completer<dynamic>();
    final id = _getCommandID;
    _commands[id] = completer;
    message.id = id;

    // Set up timeout to prevent memory leaks from hanging commands
    Timer(timeout, () {
      final pendingCompleter = _commands.remove(id);
      if (pendingCompleter != null && !pendingCompleter.isCompleted) {
        pendingCompleter.completeError(TimeoutException(
            'Command $id timed out after ${timeout.inSeconds}s', timeout));
      }
    });

    _socket!.sendMessage(message);

    return completer.future;
  }

  @override
  Future<void> close() async {
    _socketSubscription?.cancel();
    await _socket?.close();

    // Clear all subscriptions to prevent memory leaks
    for (final subscription in _subscriptions.values) {
      subscription.dispose();
    }
    _subscriptions.clear();

    _connectionState.dispose();
    _socket = null;
  }

  @override
  HassSubscription subscribeMessage(HABaseMessage subscribeMessage) {
    if (_socket == null || _socket!.isClosed) {
      throw ConnectionClosedError('Connection is closed');
    }

    final id = _getCommandID;

    final hassSubscription = HassSubscription(unsubscribe: () async {
      if (!_socket!.isClosed) {
        await sendMessage(UnsubscribeEventsMessage(subscriptionID: id));
      }
      final removedSubscription = _subscriptions.remove(id);
      removedSubscription?.dispose();
    });

    _subscriptions[id] = hassSubscription;

    subscribeMessage.id = id;
    _socket!.sendMessage(subscribeMessage);
    return hassSubscription;
  }

  void _setSocket(HASocket socket) {
    _socket = socket;

    _socketSubscription?.cancel();
    _socketSubscription = socket.stream
        .listen(_messageListener, onDone: _handleClose, onError: _handleError);

    _connectionState.monitorSocket(socket);
    logger.i('Connection established 🤝');
  }

  void _messageListener(dynamic incomingMessage) {
    logger.t('Server response: $incomingMessage');

    try {
      final messages = _messageHandler.parseMessages(incomingMessage);
      for (final response in messages) {
        _handleResponse(response);
      }
    } catch (e) {
      logger.e('Failed to handle message: $e, message: $incomingMessage');
      // Don't tear down connection for single message parse failures
      // Only escalate if we see a pattern of failures
      // TODO: Add metrics tracking for parse failures
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
    logger.d('Receive pong');
    final completer = _commands.remove(id);
    completer?.complete();
  }

  void _handleEventResponse(int id, dynamic event) {
    final subscription = _subscriptions[id];
    if (subscription != null) {
      subscription.emit(event);
    } else {
      logger.e('Unknown subscription $id, unsubscribing');
      sendMessage(UnsubscribeEventsMessage(subscriptionID: id))
          .catchError((e) => logger.e('Error unsubscribing: $e'));
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
    logger.i('Connection closed 👋');
    _commandID = 2;
    _socketSubscription?.cancel();

    _handlePendingCommands();

    final lastState = _socket?.state;
    logger.d('_handleClose: socket last state: $lastState');
    _socket = null;

    // Just set the state - let the orchestrator handle reconnection
    if (lastState case Disconnected(type: DisconnectionType.authFailure)) {
      logger.d('Preserving auth failure state');
      _connectionState.setState(lastState);
    } else {
      logger.d('Setting generic disconnected state');
      _connectionState.setState(HASocketState.disconnected());
    }
  }

  void _handleError(dynamic error) {
    logger.e(error);

    if (_socket?.state case Disconnected(type: DisconnectionType.authFailure)) {
      _connectionState.setState(_socket!.state);
      close();
    }
  }

  void _handlePendingCommands() {
    _commands.forEach((_, completer) {
      completer.completeError('Connection lost 📡');
    });
    _commands.clear();
  }
}
