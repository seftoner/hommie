import 'dart:async';

import 'package:hommie/services/networking/home_assitant_websocket/ha_connection_option.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/ha_connection_state.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket_state.dart';
import 'package:hommie/services/networking/home_assitant_websocket/hass_subscription.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/reconnection_manager.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/web_socket_response.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/backoff.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/message_handler.dart';

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
class HAConnection implements IHAConnection, ReconnectionManagerDelegate {
  HASocket? _socket;
  StreamSubscription<dynamic>? _socketSubscription;

  final HAConnectionOption _haConnectionOption;
  final HAMessageHandler _messageHandler;
  final HAConnectionState _connectionState;
  late final ReconnectionManager _reconnectionManager;

  HAConnection(this._haConnectionOption, [Backoff? backoff])
      : _messageHandler = HAMessageHandler(),
        _connectionState = HAConnectionState() {
    _reconnectionManager = ReconnectionManager(this, backoff);
  }

  /// Stream of connection state changes.
  Stream<HASocketState> get state => _connectionState.stateStream;

  /// Current connection state.
  HASocketState get currentState => _connectionState.currentState;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  final Map<int, Completer> _commands = {};
  final Map<int, HassSubscription> _subscriptions = {};
  int get _getCommndID => _commndID++;

  /// Establishes connection to Home Assistant.
  /// Throws an exception if connection fails.
  Future<void> connect() async {
    if (_socket != null) {
      logger.w('Connection already exists');
      return;
    }

    _reconnectionManager.didStartInitialConnect();
    try {
      final socket = await _haConnectionOption.createSocket();
      _setSocket(socket);
      _reconnectionManager.didFinishConnect();
    } on AuthenticationError catch (e) {
      logger.e('Connection failed: $e');
      _connectionState.setState(HASocketState.disconnected(
        type: DisconnectionType.authFailure,
        reason: e.toString(),
      ));
      _reconnectionManager.didDisconnectPermanently();
    } catch (e) {
      logger.e('Connection failed: $e');
      _reconnectionManager.didDisconnectTemporarily(e);
      rethrow;
    }
  }

  @override
  Future<dynamic> sendMessage(HABaseMessgae message) async {
    assert(!_socket!.isClosed, 'Connections is closed');

    final completer = Completer<dynamic>();
    final id = _getCommndID;
    _commands[id] = completer;
    message.id = id;
    _socket!.sendMessage(message);

    return completer.future;
  }

  @override
  void close() {
    _reconnectionManager.didDisconnectPermanently();
    _socketSubscription?.cancel();
    _socket?.close();
    _socket = null;
    _connectionState.dispose();
  }

  @override
  HassSubscription subscribeMessage(HABaseMessgae subscribeMessage) {
    assert(!_socket!.isClosed, 'Connections is closed');

    final id = _getCommndID;

    final hassSubscribtion = HassSubscription(unsubscribe: () async {
      if (!_socket!.isClosed) {
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
      logger.e('Failed to handle message', error: e);
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
      sendMessage(UnsubscribeEventsMessage(subsctibtionID: id))
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
    _commndID = 2;
    _socketSubscription?.cancel();

    _handlePendingCommands();

    final lastState = _socket?.state;
    _socket = null;

    if (lastState case Disconnected(type: DisconnectionType.authFailure)) {
      _connectionState.setState(lastState);
      _reconnectionManager.didDisconnectPermanently();
    } else {
      _reconnectionManager.didDisconnectTemporarily(null);
    }
  }

  void _handleError(dynamic error) {
    logger.e(error);

    if (_socket?.state case Disconnected(type: DisconnectionType.authFailure)) {
      _reconnectionManager.didDisconnectPermanently();
      _connectionState.setState(_socket!.state);
      close();
    }
  }

  @override
  void reconnectionManagerWantsReconnect() {
    _connectionState.setState(HASocketState.reconnecting());
    connect().catchError((e) {
      logger.e('Reconnection failed', error: e);
      _reconnectionManager.didDisconnectTemporarily(e);
    });
  }

  @override
  void reconnectionManagerWantsDisconnect(error) {
    _connectionState.setState(HASocketState.disconnected(
      type: DisconnectionType.error,
      reason: error.toString(),
    ));
    close();
  }

  void _handlePendingCommands() {
    _commands.forEach((_, completer) {
      completer.completeError('Connection lost 📡');
    });
    _commands.clear();
  }
}
