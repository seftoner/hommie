import 'dart:async';
import 'package:hommie/features/server_manager/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/services/networking/home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/ha_oauth2_token.dart';
import 'package:hommie/core/utils/logger.dart';

part 'server_connection_manager.g.dart';

@Riverpod(keepAlive: true, dependencies: [ConnectionState, ActiveServer])
class ServerConnectionManager extends _$ServerConnectionManager {
  final _connections = <int, HAConnection>{};
  final _completers = <int, Completer<HAConnection>>{};
  final _heartbeatTimers = <int, Timer>{};
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
        'ServerConnectionManager initialized with active server: $_activeServerId');

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
        'Active server changed from $previousActiveServerId to $newActiveServerId');

    // If no active server, reset connection state
    if (newActiveServerId == null && !_isDisposed) {
      logger.i('No active server - resetting connection state');
      ref.read(connectionStateProvider.notifier).reset();
    }

    // Disconnect all inactive servers
    for (final serverId in _connections.keys.toList()) {
      if (serverId != newActiveServerId) {
        logger.i('Disconnecting inactive server: $serverId');
        disconnect(serverId);
      }
    }
  }

  Future<void> reconnect(int serverId) async {
    disconnect(serverId);
    await _createNewConnection(serverId);
  }

  Future<HAConnection> getConnection(int serverId) async {
    // Only allow connections to the active server
    if (_activeServerId != null && serverId != _activeServerId) {
      logger.w(
          'Attempted to get connection for inactive server $serverId, active is $_activeServerId');
      throw Exception('Cannot connect to inactive server $serverId');
    }

    if (_connections.containsKey(serverId)) {
      return _connections[serverId]!;
    }
    return _createNewConnection(serverId);
  }

  void disconnect(int serverId) {
    if (!_isDisposed) {
      ref.read(connectionStateProvider.notifier).reset();
    }
    _connections[serverId]?.close();
    _connections.remove(serverId);
    _completers.remove(serverId);
    _stopHeartbeat(serverId);
  }

  void _disconnectAll() {
    for (final serverId in _connections.keys.toList()) {
      disconnect(serverId);
    }
  }

  Future<HAConnection> _createNewConnection(int serverId) async {
    if (_completers.containsKey(serverId)) {
      logger.d('Lock by completer');
      return _completers[serverId]!.future;
    }

    // // If there's already a connection being created, wait for it
    // if (_connectionCompleter != null) {
    //   logger.d('Lock by completer');
    //   return _connectionCompleter!.future;
    // }

    _completers[serverId] = Completer<HAConnection>();

    try {
      if (_isDisposed) {
        throw Exception('ServerConnectionManager is disposed');
      }

      final serverUrl = await ref.read(serverSettingsProvider).getServerUrl();
      if (serverUrl == null) {
        throw Exception('Server URL is not configured');
      }

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

      final connection = HAConnection(connOption);

      connection.state.listen((state) {
        _handleConnectionState(serverId, state);
      });

      await connection.connect();
      _connections[serverId] = connection;
      _completers[serverId]!.complete(connection);
      return connection;
    } catch (e) {
      // Ensure completer is completed even on error
      final completer = _completers[serverId];
      if (completer != null && !completer.isCompleted) {
        completer.completeError(e);
      }
      logger.e('Connection failed: $e');
      rethrow;
    } finally {
      // Always clean up completer reference
      _completers.remove(serverId);
    }
  }

  void _handleConnectionState(int serverId, HASocketState state) {
    if (_isDisposed) {
      return;
    }

    switch (state) {
      case Disconnected(type: DisconnectionType.authFailure):
        disconnect(serverId);
        ref.read(connectionStateProvider.notifier).setAuthFailure();
        break;
      case Connecting():
        ref.read(connectionStateProvider.notifier).setConnecting();
        _stopHeartbeat(serverId);
        break;
      case Authenticated():
        ref.read(connectionStateProvider.notifier).setConnected();
        _startHeartbeat(serverId);
        break;
      case Reconnecting():
        ref.read(connectionStateProvider.notifier).setReconnecting();
        _stopHeartbeat(serverId);
        break;
      case Disconnected():
        ref.read(connectionStateProvider.notifier).setDisconnected();
        _stopHeartbeat(serverId);
        break;
    }
  }

  void _startHeartbeat(int serverId) {
    // Only start heartbeat for the active server
    if (_activeServerId != serverId) {
      logger.w('Skipping heartbeat start for inactive server $serverId');
      return;
    }

    _stopHeartbeat(serverId);
    logger.i('Starting heartbeat for active server $serverId');
    _heartbeatTimers[serverId] =
        Timer.periodic(const Duration(seconds: 30), (_) async {
      // Double-check this is still the active server
      if (_activeServerId != serverId) {
        logger.i('Stopping heartbeat for server $serverId - no longer active');
        _stopHeartbeat(serverId);
        return;
      }

      logger.d('Ping active server $serverId');
      final connection = _connections[serverId];
      if (connection != null) {
        try {
          // Use timeout for ping to detect stale connections
          await HACommands.pingServer(connection)
              .timeout(const Duration(seconds: 10));
          logger.d('Ping successful for active server $serverId');
        } catch (e) {
          logger.e('Ping failed for active server $serverId: $e');
          // Trigger reconnection on ping failure
          logger.i('Triggering reconnection due to ping failure');
          reconnect(serverId).catchError((error) {
            logger.e('Reconnection failed after ping timeout: $error');
          });
        }
      }
    });
  }

  void _stopHeartbeat(int serverId) {
    if (_heartbeatTimers.containsKey(serverId)) {
      logger.i('Stopping heartbeat for server $serverId');
      _heartbeatTimers[serverId]?.cancel();
      _heartbeatTimers.remove(serverId);
    }
  }
}
