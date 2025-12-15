import 'dart:async';

import 'package:home_assistant_websocket/src/api/subsctibtions/hass_subscription.dart';
import 'package:home_assistant_websocket/src/logging/logger_interface.dart';
import 'package:home_assistant_websocket/src/protocol/messages/ha_messages.dart';
import 'package:home_assistant_websocket/src/protocol/types/ha_response.dart';

import 'ha_connection_option.dart';
import 'ha_connection_state.dart';
import 'ha_socket.dart';
import 'ha_socket_state.dart';
import 'message_handler.dart';

/// Interface for Home Assistant websocket connection.
abstract class IHAConnection {
  /// Sends a message to Home Assistant and returns the response.
  HAResponse sendMessage(HAMessage message);

  /// Subscribes to Home Assistant events.
  /// Returns a [HassSubscription] that can be used to receive events and unsubscribe.
  HassSubscription subscribeMessage(HAMessage subscribeMessage);

  /// Closes the connection.
  Future<void> close();
}

/// Internal pending entry stored per command/subscription id.
sealed class _HaPending {
  const _HaPending();
}

final class _HaPendingCommand extends _HaPending {
  _HaPendingCommand(this.completer);

  final Completer<dynamic> completer;
  Timer? timeoutTimer;

  void cancelTimeout() {
    timeoutTimer?.cancel();
    timeoutTimer = null;
  }
}

final class _HaPendingSubscription extends _HaPending {
  _HaPendingSubscription(this.subscription);

  bool isActive = false;

  final HassSubscription subscription;
}

/// Implementation of Home Assistant websocket connection.
/// Handles connection management, message sending, and event subscriptions.
/// Note: This class no longer handles reconnection logic - use ConnectionOrchestrator for that.
class HAConnection implements IHAConnection {
  HASocket? _socket;
  StreamSubscription<dynamic>? _socketSubscription;
  Future<void>? _closing;

  final HAConnectionOption _haConnectionOption;
  final HAMessageHandler _messageHandler;
  final HAConnectionState _connectionState;
  final HaLogger _logger;

  HAConnection(this._haConnectionOption)
    : _messageHandler = HAMessageHandler(),
      _logger = _haConnectionOption.logger,
      _connectionState = HAConnectionState(_haConnectionOption.logger);

  /// Stream of connection state changes.
  Stream<HASocketState> get state => _connectionState.stateStream;

  /// Current connection state.
  HASocketState get currentState => _connectionState.currentState;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commandID = 2;
  final Map<int, _HaPending> _pending = {};
  int get _getCommandID => _commandID++;

  /// Establishes connection to Home Assistant.
  Future<void> connect() async {
    if (_socket != null) {
      _logger.warning('Connection already exists');
      return;
    }

    try {
      final socket = await _haConnectionOption.createSocket();
      _setSocket(socket);
    } on AuthenticationError catch (e) {
      _logger.error('Connection failed: $e');
      _connectionState.setState(
        Disconnected(type: DisconnectionType.authFailure, reason: e.toString()),
      );
    } on ConnectionError catch (e) {
      _logger.error('Connection failed: $e');
      _connectionState.setState(
        Disconnected(type: DisconnectionType.error, reason: e.toString()),
      );
    } catch (e) {
      _logger.error('Unexpected connection error: $e');
      _connectionState.setState(
        Disconnected(type: DisconnectionType.error, reason: e.toString()),
      );
    }
  }

  @override
  HAResponse sendMessage(
    HAMessage message, {
    Duration timeout = const Duration(seconds: 15),
  }) async {
    // Replace assertion with runtime check for better error handling
    if (_socket == null || _socket!.isClosed) {
      return Future.error(ConnectionClosedError('Connection is closed'));
    }

    final id = _getCommandID;

    final pending = _HaPendingCommand(Completer<dynamic>());
    _pending[id] = pending;

    // Set up timeout to prevent memory leaks from hanging commands
    pending.timeoutTimer = Timer(timeout, () {
      final entry = _pending.remove(id);
      if (entry is _HaPendingCommand && !entry.completer.isCompleted) {
        entry.completer.completeError(
          TimeoutException(
            'Command $id timed out after ${timeout.inSeconds}s',
            timeout,
          ),
        );
      }
    });

    _socket!.sendMessage(message, id: id);

    return pending.completer.future;
  }

  @override
  Future<void> close() async {
    await _shutdown(initiatedBySocket: false);
  }

  Future<void> _shutdown({required bool initiatedBySocket}) async {
    if (_closing != null) {
      return _closing!;
    }

    _logger.debug(
      'Closing connection (${initiatedBySocket ? 'socket closed' : 'manual'})',
    );

    _closing = () async {
      _socketSubscription?.cancel();
      _socketSubscription = null;

      if (!initiatedBySocket && _socket != null && !_socket!.isClosed) {
        await _socket!.close();
      }

      _handlePendingCommands();
      await _cleanupSubscriptions();

      _commandID = 2;

      final lastState = _socket?.state;
      _socket = null;

      if (initiatedBySocket) {
        if (lastState case Disconnected(type: DisconnectionType.authFailure)) {
          _connectionState.setState(lastState);
        } else {
          _connectionState.setState(const Disconnected());
        }
      } else {
        _connectionState.setState(const Disconnected());
        _connectionState.dispose();
      }
    }();

    try {
      await _closing;
    } finally {
      _closing = null;
    }
  }

  @override
  HassSubscription subscribeMessage(HAMessage subscribeMessage) {
    if (_socket == null || _socket!.isClosed) {
      throw ConnectionClosedError('Connection is closed');
    }

    final id = _getCommandID;

    final hassSubscription = HassSubscription(
      unsubscribe: () async {
        final entry = _pending[id];
        final isActive = entry is _HaPendingSubscription && entry.isActive;

        // Always remove locally first.
        _pending.remove(id);

        // Only unsubscribe on the server if the subscription was established.
        if (isActive && _socket != null && _socket!.isClosed != true) {
          await sendMessage(UnsubscribeEventsMessage(subscriptionID: id));
        }
      },
      logger: _logger,
    );

    _pending[id] = _HaPendingSubscription(hassSubscription);

    _socket!.sendMessage(subscribeMessage, id: id);
    return hassSubscription;
  }

  void _setSocket(HASocket socket) {
    _socket = socket;

    _socketSubscription?.cancel();
    _socketSubscription = socket.stream.listen(
      _messageListener,
      onDone: () => _shutdown(initiatedBySocket: true),
      onError: _handleError,
    );

    _connectionState.monitorSocket(socket);
    _logger.info('Connection established 🤝');
  }

  void _messageListener(dynamic incomingMessage) {
    _logger.trace('Server response: $incomingMessage');

    try {
      final messages = _messageHandler.parseMessages(incomingMessage);
      for (final response in messages) {
        _messageHandler.handleResponse(
          response,
          onPong: () => _handlePongResponse(response.id),
          onEvent: (event) => _handleEventResponse(response.id, event),
          onSuccess: (result) => _handleSuccessResponse(response.id, result),
          onError: (error) => _handleErrorResponse(response.id, error),
        );
      }
    } catch (e) {
      _logger.error('Failed to handle message: $e, message: $incomingMessage');
      // Don't tear down connection for single message parse failures
      // Only escalate if we see a pattern of failures
      // TODO: Add metrics tracking for parse failures
    }
  }

  void _handlePongResponse(int id) {
    _logger.debug('Receive pong');
    final entry = _pending.remove(id);
    if (entry is _HaPendingCommand) {
      entry.cancelTimeout();
      entry.completer.complete();
    }
  }

  void _handleEventResponse(int id, dynamic event) {
    final entry = _pending[id];
    if (entry is _HaPendingSubscription) {
      entry.subscription.emit(event);
      return;
    }

    _logger.warning('Unknown subscription $id, unsubscribing');
    sendMessage(
      UnsubscribeEventsMessage(subscriptionID: id),
    ).catchError((e) => _logger.error('Error unsubscribing: $e'));
  }

  void _handleSuccessResponse(int id, dynamic result) {
    final entry = _pending[id];
    if (entry is _HaPendingCommand) {
      _pending.remove(id);
      entry.cancelTimeout();
      entry.completer.complete(result);
    }

    if (entry is _HaPendingSubscription) {
      entry.isActive = true;
      return;
    }
  }

  void _handleErrorResponse(int id, dynamic error) {
    final entry = _pending.remove(id);

    if (entry is _HaPendingCommand) {
      entry.cancelTimeout();
      entry.completer.completeError(error);
      return;
    }

    if (entry is _HaPendingSubscription) {
      // Subscribe failed: remove and dispose locally (no unsubscribe needed).
      entry.subscription.dispose();
      return;
    }

    _logger.warning('Received error for unknown id $id: $error');
  }

  void _handleError(dynamic error) {
    _logger.error(error.toString());

    if (_socket?.state case Disconnected(type: DisconnectionType.authFailure)) {
      _connectionState.setState(_socket!.state);
      _shutdown(initiatedBySocket: true);
    }
  }

  void _handlePendingCommands() {
    // Complete only command completers; leave subscriptions to _cleanupSubscriptions()
    final entries = List<MapEntry<int, _HaPending>>.from(_pending.entries);
    for (final e in entries) {
      final entry = e.value;
      if (entry is _HaPendingCommand) {
        _pending.remove(e.key);
        entry.cancelTimeout();
        entry.completer.completeError('Connection lost 📡');
      }
    }
  }

  Future<void> _cleanupSubscriptions() async {
    if (_pending.isEmpty) {
      return;
    }

    // Copy subscriptions first, then remove them from the map to avoid concurrent modification.
    final subscriptions = <HassSubscription>[];
    final idsToRemove = <int>[];

    for (final entry in _pending.entries) {
      final pending = entry.value;
      if (pending is _HaPendingSubscription) {
        subscriptions.add(pending.subscription);
        idsToRemove.add(entry.key);
      }
    }

    for (final id in idsToRemove) {
      _pending.remove(id);
    }

    for (final subscription in subscriptions) {
      try {
        await subscription.dispose();
      } catch (e) {
        _logger.warning('Failed to dispose subscription: $e');
      }
    }
  }
}
