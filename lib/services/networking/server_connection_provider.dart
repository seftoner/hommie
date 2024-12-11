import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_connection_provider.g.dart';

@Riverpod(keepAlive: true)
class ServerConnection extends _$ServerConnection {
  @override
  FutureOr<HAConnection> build() async {
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

    final connection = HAConnection(HAConnectionOption(credentials));

    // Listen to connection state changes
    connection.state.listen((state) {
      switch (state) {
        case HASocketState.connecting:
          connectionStateNotifier.setConnecting();
          break;
        case HASocketState.authenticated:
          connectionStateNotifier.setConnected();
          break;
        case HASocketState.disconnected:
          connectionStateNotifier.setDisconnected();
          break;
        default:
          break;
      }
    });

    ref.onDispose(() {
      logger.i("Disposing HAConnection");
      connection.close();
    });

    try {
      await connection.connect();
      // Wait for authentication to complete before returning the connection
      await connection.state
          .firstWhere(
            (state) => state == HASocketState.authenticated,
            orElse: () => throw Exception('Connection authentication timeout'),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () =>
                throw Exception('Connection authentication timeout'),
          );
      return connection;
    } catch (e) {
      logger.e('Connection failed: $e');
      rethrow;
    }
  }
}
