import 'dart:async';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/services/networking/home_assitant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/ha_oauth2_token.dart';
import 'package:hommie/core/utils/logger.dart';

part 'server_connection_manager.g.dart';

@Riverpod(keepAlive: true, dependencies: [ConnectionState])
class ServerConnectionManager extends _$ServerConnectionManager {
  final _connections = <int, HAConnection>{};
  final _completers = <int, Completer<HAConnection>>{};
  final _heartbeatTimers = <int, Timer>{};
  bool _isDisposed = false;

  @override
  void build() async {
    ref.onDispose(() {
      _isDisposed = true;
      _disconnectAll();
    });

    _isDisposed = false;
  }

  Future<void> reconnect(int serverId) async {
    disconnect(serverId);
    await _createNewConnection(serverId);
  }

  Future<HAConnection> getConnection(int serverId) async {
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
      _completers[serverId]!.completeError(e);
      logger.e('Connection failed: $e');
      rethrow;
    } finally {
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
    _stopHeartbeat(serverId);
    _heartbeatTimers[serverId] =
        Timer.periodic(const Duration(seconds: 30), (_) {
      logger.d('Ping server');
      final connection = _connections[serverId];
      if (connection != null) {
        HACommands.pingServer(connection).catchError((e) {
          logger.e('Ping failed: $e');
        });
      }
    });
  }

  void _stopHeartbeat(int serverId) {
    _heartbeatTimers[serverId]?.cancel();
    _heartbeatTimers.remove(serverId);
  }
}
