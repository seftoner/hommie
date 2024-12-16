import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/services/networking/home_assitant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/ha_oauth2_token.dart';
import 'package:hommie/core/utils/logger.dart';

part 'server_connection_manager.g.dart';

@Riverpod(keepAlive: true)
class ServerConnectionManager extends _$ServerConnectionManager {
  HAConnection? _connection;
  bool _isDisposed = false;
  Timer? _heartbeatTimer;

  @override
  Future<void> build() async {
    ref.onDispose(() {
      _isDisposed = true;
      disconnectAndCleanup();
    });

    return;
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

    final credOrError = await authRepository.getCredentials();

    final authToken = credOrError.fold(
      (error) {
        logger.e('Failed to fetch credentials: $error');
        throw Exception('Failed to fetch credentials: $error');
      },
      (credentials) => HAOAuth2Token(credentials),
    );

    final connOption = HAConnectionOption(
      authToken,
      onTokenRefresh: () async {
        final refreshResult = await authRepository.getCredentials();
        return refreshResult.fold(
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
        // This might execute at a time which could lead to a crash.
        // Assume that signOut() might be called from two places:
        // First, here when the connection is broken,
        // and second, on the Server settings page.
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
    ref.read(connectionStateProvider.notifier).reset();
    _stopHeartbeat();
    _connection?.close();
    _connection = null;
  }
}
