import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_commands.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part 'server_connection_provider.g.dart';

@Riverpod(keepAlive: true)
class ServerConnection extends _$ServerConnection {
  StreamSubscription<HASocketState>? _connectionStateSubscription;
  Timer? _heartbeatTimer;

  @override
  FutureOr<HAConnection> build() async {
    ref.onDispose(() {
      _connectionStateSubscription?.cancel();
      _stopHeartbeat();
      //Close connection.
      state.value?.close();
    });

    return _createConnection();
  }

  Future<HAConnection> _createConnection() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final connectionStateNotifier = ref.watch(connectionStateProvider.notifier);

    final credOrError = await authRepository.getCredentials();

    final credentials = credOrError.fold(
      (error) {
        logger.e("Failed to fetch credentials: $error");
        throw Exception("Failed to fetch credentials: $error");
      },
      (credentials) => credentials,
    );

    final connOption = HAConnectionOption(
      credentials,
      onTokenRefresh: () async {
        final refreshResult = await authRepository.getCredentials();
        return refreshResult.fold(
          (error) => throw Exception("Failed to refresh token: $error"),
          (newCredentials) => newCredentials,
        );
      },
    );

    final connection = HAConnection(connOption);

    // Listen to connection state changes
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = connection.state.listen((state) {
      _handleStateChange(state, connection, connectionStateNotifier);
    });

    try {
      await connection.connect();
      return connection;
    } catch (e) {
      logger.e('Connection failed: $e');
      rethrow;
    }
  }

  void _handleStateChange(
    HASocketState state,
    HAConnection connection,
    ConnectionState connectionStateNotifier,
  ) {
    switch (state) {
      case HASocketState.connecting:
        connectionStateNotifier.setConnecting();
        _stopHeartbeat();
        break;
      case HASocketState.authenticated:
        connectionStateNotifier.setConnected();
        _startHeartbeat(connection);
        break;
      case HASocketState.disconnected:
        connectionStateNotifier.setDisconnected();
        _stopHeartbeat();
        break;
      case HASocketState.reconnecting:
        connectionStateNotifier.setReconnecting();
        _stopHeartbeat();
        break;
      default:
        break;
    }
  }

  void _startHeartbeat(HAConnection connection) {
    _stopHeartbeat(); // Cancel any existing timer
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      logger.d("Ping server");
      HACommands.pingServer(connection).catchError((e) {
        logger.e("Ping failed: $e");
      });
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }
}
