import 'dart:async';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/services/networking/home_assitant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/ha_oauth2_token.dart';
import 'package:hommie/core/utils/logger.dart';

part 'server_connection_manager.g.dart';

@Riverpod(keepAlive: true, dependencies: [ConnectionState])
class ServerConnectionManager extends _$ServerConnectionManager {
  HAConnection? _connection;
  bool _isDisposed = false;
  Timer? _heartbeatTimer;

  @override
  void build() async {
    ref.onDispose(() {
      _isDisposed = true;
      disconnectAndCleanup();
    });
  }

  Future<void> reconnect() async {
    disconnectAndCleanup();
    await _createNewConnection();
  }

  Future<HAConnection> getConnection() async {
    if (_connection != null) {
      return _connection!;
    }
    return await _createNewConnection();
  }

  Future<HAConnection> _createNewConnection() async {
    if (_isDisposed) {
      throw Exception('ServerConnectionManager is disposed');
    }

    final authRepository = ref.read(authRepositoryProvider);

    final serverUrl = await ref.read(serverSettingsProvider).getServerUrl();
    if (serverUrl == null) {
      throw Exception('Server URL is not configured');
    }

    final connOption = HAConnectionOption(
      serverUrl: serverUrl,
      fetchAuthToken: () async {
        final fetchedCredentials = await authRepository.getCredentials();
        return fetchedCredentials.fold(
          (error) => throw Exception('Failed to refresh token: $error'),
          (credentials) => HAOAuth2Token(credentials),
        );
      },
    );

    final connection = HAConnection(connOption);

    connection.state.listen((state) {
      _handleConnectionState(state);
    });

    try {
      await connection.connect();
      _connection = connection;
      return connection;
    } catch (e) {
      logger.e('Connection failed: $e');
      rethrow;
    }
  }

  void _handleConnectionState(HASocketState state) {
    switch (state) {
      case Connecting():
        ref.read(connectionStateProvider.notifier).setConnecting();
        _stopHeartbeat();
        break;
      case Authenticated():
        ref.read(connectionStateProvider.notifier).setConnected();
        _startHeartbeat();
        break;
      case Reconnecting():
        ref.read(connectionStateProvider.notifier).setReconnecting();
        _stopHeartbeat();
        break;
      case Disconnected(type: DisconnectionType.authFailure):
        disconnectAndCleanup();
        ref.read(authControllerProvider.notifier).signOut();
        break;
      case Disconnected():
        ref.read(connectionStateProvider.notifier).setDisconnected();
        _stopHeartbeat();
        break;
    }
  }

  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      logger.d('Ping server');
      if (_connection != null) {
        HACommands.pingServer(_connection!).catchError((e) {
          logger.e('Ping failed: $e');
        });
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  void disconnectAndCleanup() {
    if (_isDisposed != true) {
      ref.read(connectionStateProvider.notifier).reset();
    }
    _stopHeartbeat();
    _connection?.close();
    _connection = null;
  }
}
