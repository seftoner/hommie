import 'dart:async';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/services/networking/home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/connection_orchestrator.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/ha_oauth2_token.dart';
import 'package:hommie/core/utils/logger.dart';

part 'server_connection_manager.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [
    ActiveServer,
    ServerConnectionState,
    serverManager,
    authRepository,
  ],
)
class ServerConnectionManager extends _$ServerConnectionManager {
  final _orchestrators = <int, ConnectionOrchestrator>{};
  int? _activeServerId;
  bool _isDisposed = false;

  @override
  void build() async {
    ref.onDispose(() {
      _isDisposed = true;
      _disconnectAll();
    });

    // Initialize active server
    final activeServer = await ref.read(activeServerProvider.future);
    _activeServerId = activeServer?.id;
    logger.i(
      'ServerConnectionManager initialized with active server: $_activeServerId',
    );

    // Listen to active server changes
    ref.listen(activeServerProvider, (previous, next) {
      _handleActiveServerChange(next.value?.id);
    });

    _isDisposed = false;
  }

  void _handleActiveServerChange(int? newActiveServerId) {
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
      ref.read(serverConnectionStateProvider.notifier).reset();
    }

    // Disconnect all inactive servers
    for (final serverId in _orchestrators.keys.toList()) {
      if (serverId != newActiveServerId) {
        logger.i('Disconnecting inactive server: $serverId');
        disconnect(serverId);
      }
    }
  }

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
  Future<HAConnection> getConnection(int serverId) async {
    if (_orchestrators.containsKey(serverId)) {
      final connection = _orchestrators[serverId]!.connection;
      if (connection != null) {
        return connection;
      }
    }
    return _createNewOrchestrator(serverId);
  }

  void disconnect(int serverId) {
    logger.i('Disconnecting server $serverId');

    // Close orchestrator (this will handle heartbeat cleanup internally)
    _orchestrators[serverId]?.close();
    _orchestrators.remove(serverId);

    // Update global state only if this was the active server
    if (_activeServerId == serverId && !_isDisposed) {
      ref.read(serverConnectionStateProvider.notifier).reset();
    }
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

    final serverManager = ref.read(serverManagerProvider);
    final servers = await serverManager.getAvailableServers();
    final server = servers.firstWhere((s) => s.id == serverId);

    final serverUrl = Uri.parse(server.url);

    final connOption = HAConnectionOption(
      serverUrl: serverUrl,
      fetchAuthToken: () async {
        final authRepository = ref.read(authRepositoryProvider(serverId));
        final fetchedCredentials = await authRepository.getCredentials();
        return fetchedCredentials.fold(
          (error) => throw ConnectionError('Failed to refresh token: $error'),
          (credentials) => HAOAuth2Token(credentials),
        );
      },
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
          ref.read(serverConnectionStateProvider.notifier).setAuthFailure();
        } else {
          ref.read(serverConnectionStateProvider.notifier).setDisconnected();
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
          ref.read(serverConnectionStateProvider.notifier).setAuthFailure();
        }
        disconnect(serverId);
        break;
      case Connecting():
        if (shouldUpdateGlobalState) {
          ref.read(serverConnectionStateProvider.notifier).setConnecting();
        }
        break;
      case Authenticated():
        if (shouldUpdateGlobalState) {
          ref.read(serverConnectionStateProvider.notifier).setConnected();
        }
        break;
      case Reconnecting():
        if (shouldUpdateGlobalState) {
          ref.read(serverConnectionStateProvider.notifier).setReconnecting();
        }
        break;
      case Disconnected():
        if (shouldUpdateGlobalState) {
          ref.read(serverConnectionStateProvider.notifier).setDisconnected();
        }
        break;
    }
  }
}
