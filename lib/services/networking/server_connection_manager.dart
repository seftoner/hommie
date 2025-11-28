import 'dart:async';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/services/networking/i_server_connection_manager.dart';
import 'package:hommie/services/networking/providers/server_config_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/services/networking/home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/connection_orchestrator.dart';
import 'package:hommie/features/auth/infrastructure/providers/server_auth_token_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/core/utils/logger.dart';

part 'server_connection_manager.g.dart';

@Riverpod(keepAlive: true, dependencies: [ServerConnectionState, serverConfig])
IServerConnectionManager serverConnectionManager(Ref ref) {
  final manager = _ServerConnectionManager(ref);

  ref.onDispose(() {
    manager._disconnectAll();
  });

  return manager;
}

@Dependencies([ServerConnectionState, serverConfig])
class _ServerConnectionManager implements IServerConnectionManager {
  final _orchestrators = <int, ConnectionOrchestrator>{};
  int? _activeServerId;
  bool _isDisposed = false;
  final Ref _ref;

  _ServerConnectionManager(this._ref);

  @override
  void setActiveServer(int? newActiveServerId) {
    if (_activeServerId == newActiveServerId) {
      return; // No change
    }

    final previousActiveServerId = _activeServerId;
    _activeServerId = newActiveServerId;

    logger.i(
      'Active server changed from $previousActiveServerId to $newActiveServerId',
    );

    // If no active server, reset connection state
    if (newActiveServerId == null && !_isDisposed) {
      logger.i('No active server - resetting connection state');
      _ref.read(serverConnectionStateProvider.notifier).reset();
    }

    // Disconnect all inactive servers
    for (final serverId in _orchestrators.keys.toList()) {
      if (serverId != newActiveServerId) {
        logger.i('Disconnecting inactive server: $serverId');
        disconnect(serverId);
      }
    }
  }

  @override
  Future<void> reconnect(int serverId) async {
    logger.i('Starting reconnection for server $serverId');

    // Disconnect existing connection
    disconnect(serverId);

    try {
      // Create new orchestrator and connect
      await _createNewOrchestrator(serverId);
      logger.i('Successfully reconnected to server $serverId');
    } catch (e) {
      logger.e('Reconnection failed for server $serverId: $e');
    }
  }

  /// Gets a persistent connection for the specified server.
  /// Each connection is managed by its own ConnectionOrchestrator which handles:
  /// - Connection lifecycle (connect/disconnect/reconnect)
  /// - Heartbeat monitoring and health checks
  /// - Automatic reconnection with exponential backoff
  /// - State management and event handling
  @override
  Future<HAConnection> getConnection(int serverId) async {
    if (_orchestrators.containsKey(serverId)) {
      final connection = _orchestrators[serverId]!.connection;
      if (connection != null) {
        return connection;
      }
    }
    return _createNewOrchestrator(serverId);
  }

  @override
  void disconnect(int serverId) {
    logger.i('Disconnecting server $serverId');

    // Close orchestrator (this will handle heartbeat cleanup internally)
    _orchestrators[serverId]?.close();
    _orchestrators.remove(serverId);

    // Update global state only if this was the active server
    if (_activeServerId == serverId && !_isDisposed) {
      _ref.read(serverConnectionStateProvider.notifier).reset();
    }
  }

  void dispose() {
    _isDisposed = true;
    _disconnectAll();
  }

  void _disconnectAll() {
    for (final serverId in _orchestrators.keys.toList()) {
      disconnect(serverId);
    }
  }

  Future<HAConnection> _createNewOrchestrator(int serverId) async {
    if (_isDisposed) {
      throw Exception('ServerConnectionManager is disposed');
    }

    final server = await _ref.read(serverConfigProvider(serverId).future);
    final serverUrl = Uri.parse(server.url);

    // ignore: provider_dependencies
    Future<HAAuthToken> fetchToken() async {
      try {
        return await _ref.read(serverAuthTokenProvider(serverId).future);
      } on AuthFailure catch (failure) {
        throw ConnectionError('Failed to resolve token: $failure');
      }
    }

    final connOption = HAConnectionOption(
      serverUrl: serverUrl,
      fetchAuthToken: fetchToken,
    );

    // Create orchestrator to manage the connection
    final orchestrator = ConnectionOrchestrator(connOption);
    _orchestrators[serverId] = orchestrator;

    // Listen to connection state changes BEFORE starting connection
    orchestrator.state.listen((state) {
      _handleConnectionState(serverId, state);
    });

    try {
      // Start the connection through orchestrator
      await orchestrator.connect();

      // Return the connection instance
      final connection = orchestrator.connection;
      if (connection == null) {
        throw Exception('Connection failed to establish');
      }

      logger.i('Successfully created connection for server $serverId');
      return connection;
    } catch (e) {
      logger.e('Connection failed for server $serverId: $e');

      // Clean up orchestrator on failure
      _orchestrators.remove(serverId);

      // Update state only for active server
      if (_activeServerId == serverId && !_isDisposed) {
        // Determine the appropriate state based on error type
        if (e.toString().contains('auth') || e.toString().contains('token')) {
          _ref.read(serverConnectionStateProvider.notifier).setAuthFailure();
        } else {
          _ref.read(serverConnectionStateProvider.notifier).setDisconnected();
        }
      }

      rethrow;
    }
  }

  void _handleConnectionState(int serverId, HASocketState state) {
    if (_isDisposed) {
      return;
    }

    logger.d(
      'ServerConnectionManager received state for server $serverId: $state',
    );

    // Only update global connection state for the active server
    final shouldUpdateGlobalState = _activeServerId == serverId;

    if (shouldUpdateGlobalState) {
      logger.i(
        'Updating global connection state to: $state (active server: $serverId)',
      );
    }

    switch (state) {
      case Disconnected(type: DisconnectionType.authFailure):
        if (shouldUpdateGlobalState) {
          _ref.read(serverConnectionStateProvider.notifier).setAuthFailure();
        }
        disconnect(serverId);
        break;
      case Connecting():
        if (shouldUpdateGlobalState) {
          _ref.read(serverConnectionStateProvider.notifier).setConnecting();
        }
        break;
      case Authenticated():
        if (shouldUpdateGlobalState) {
          _ref.read(serverConnectionStateProvider.notifier).setConnected();
        }
        break;
      case Reconnecting():
        if (shouldUpdateGlobalState) {
          _ref.read(serverConnectionStateProvider.notifier).setReconnecting();
        }
        break;
      case Disconnected():
        if (shouldUpdateGlobalState) {
          _ref.read(serverConnectionStateProvider.notifier).setDisconnected();
        }
        break;
    }
  }
}
