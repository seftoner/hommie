import 'dart:async';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_connection.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_connection_option.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_socket_state.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_commands.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/backoff.dart';

/// Orchestrates connection lifecycle and reconnection logic.
/// Operates HAConnection from the outside, managing its lifecycle.
class ConnectionOrchestrator {
  final HAConnectionOption _connectionOption;
  final Backoff _backoff;

  HAConnection? _connection;
  StreamSubscription<HASocketState>? _stateSubscription;
  Timer? _heartbeatTimer;
  bool _isDisposed = false;
  bool _reconnectRequested = false;
  Timer? _reconnectTimer;

  // Create our own state stream controller
  final StreamController<HASocketState> _stateController =
      StreamController<HASocketState>.broadcast();
  ConnectionOrchestrator(this._connectionOption, [Backoff? backoff])
      : _backoff = backoff ??
            BinaryExponentialBackoff(
              initial: const Duration(seconds: 1),
              maximumStep: 7,
            );

  /// Stream of connection state changes.
  Stream<HASocketState> get state => _stateController.stream;

  /// Current connection instance (if any).
  HAConnection? get connection => _connection;

  /// Starts initial connection.
  Future<void> connect() async {
    if (_isDisposed) {
      throw StateError('ConnectionOrchestrator is disposed');
    }

    _reconnectRequested = false;
    _backoff.reset(); // Reset only for user-initiated connections

    await _attemptConnection();
  }

  /// Closes the connection and stops reconnection attempts.
  Future<void> close() async {
    _isDisposed = true;
    _reconnectRequested = false;

    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    _stopHeartbeat();

    await _stateSubscription?.cancel();
    _stateSubscription = null;

    if (_connection != null) {
      await _connection!.close();
      _connection = null;
    }

    await _stateController.close();
  }

  Future<void> _attemptConnection() async {
    if (_isDisposed || _connection != null) {
      return;
    }

    // Reset reconnection request flag since we're now attempting
    _reconnectRequested = false;

    try {
      logger.i('Attempting connection...');

      // Emit connecting state
      if (!_stateController.isClosed) {
        _stateController.add(const Connecting());
      }

      // Create new connection (without ReconnectionManager)
      _connection = HAConnection(_connectionOption);

      // Monitor its state
      _stateSubscription = _connection!.state.listen(_handleStateChange);

      await _connection!.connect();
    } catch (e) {
      logger.e('Unexpected connection attempt failure: $e');

      await _stateSubscription?.cancel();
      _stateSubscription = null;
      _connection = null;

      if (!_stateController.isClosed) {
        _stateController.add(Disconnected(
          type: DisconnectionType.error,
          reason: e.toString(),
        ));
      }

      if (!_isDisposed) {
        _scheduleReconnect();
      }
    }
  }

  void _handleStateChange(HASocketState state) {
    if (_isDisposed) {
      return;
    }

    logger.d(
        'ConnectionOrchestrator received state: $state (type: ${state.runtimeType})');

    // Forward state changes to our controller so external listeners get notified
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }

    switch (state) {
      case Authenticated():
        logger.i(
            'Connection authenticated - resetting backoff and starting heartbeat');
        _backoff.reset(); // Reset backoff on successful connection
        _startHeartbeat(); // Start heartbeat monitoring
        break;

      case Disconnected(type: DisconnectionType.authFailure):
        logger.e('Authentication failed - stopping reconnection attempts');
        _reconnectRequested = false;
        _stopHeartbeat();
        break;

      case Disconnected():
        logger.w('Connection lost - scheduling reconnection');
        _stopHeartbeat();
        _connection = null;
        _scheduleReconnect();
        break;

      case Connecting():
      case Reconnecting():
        _stopHeartbeat(); // Stop heartbeat during connection attempts
        break;
    }
  }

  void _scheduleReconnect() {
    if (_isDisposed || _reconnectRequested || _reconnectTimer != null) {
      logger.d(
          'Skipping reconnection scheduling: disposed=$_isDisposed, requested=$_reconnectRequested, timer=${_reconnectTimer != null}');
      return;
    }

    _reconnectRequested = true;
    final delay = _backoff.next;

    logger.i('Scheduling reconnection in ${delay.inSeconds} seconds');

    // Emit reconnecting state
    if (!_stateController.isClosed) {
      _stateController.add(const Reconnecting());
    }

    _reconnectTimer = Timer(delay, () {
      _reconnectTimer = null;
      if (!_isDisposed && _reconnectRequested) {
        logger.i('Reconnection timer expired - attempting connection');
        _attemptConnection();
      } else {
        logger.w(
            'Reconnection timer expired but conditions not met: disposed=$_isDisposed, requested=$_reconnectRequested');
      }
    });
  }

  void _startHeartbeat() {
    _stopHeartbeat();

    logger.i('Starting heartbeat monitoring');

    _heartbeatTimer =
        Timer.periodic(const Duration(seconds: 30), (timer) async {
      // Check if connection still exists
      if (_connection == null || _isDisposed) {
        logger.w('Heartbeat stopped - connection no longer exists');
        timer.cancel();
        _heartbeatTimer = null;
        return;
      }

      logger.d('Pinging server');

      try {
        // Use timeout for ping to detect stale connections
        await HACommands.pingServer(_connection!)
            .timeout(const Duration(seconds: 10));
        logger.d('Ping successful');
      } catch (e) {
        logger.e('Ping failed: $e');

        // Stop current heartbeat to prevent overlapping reconnection attempts
        _stopHeartbeat();

        // Trigger reconnection by simulating disconnection
        _connection = null;
        _scheduleReconnect();
      }
    });
  }

  void _stopHeartbeat() {
    if (_heartbeatTimer != null) {
      logger.i('Stopping heartbeat monitoring');
      _heartbeatTimer!.cancel();
      _heartbeatTimer = null;
    }
  }
}
