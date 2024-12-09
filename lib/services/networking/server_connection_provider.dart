import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:hommie/services/networking/reconnection_service.dart';
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
    final reconnectionService = ref.watch(reconnectionServiceProvider.notifier);

    final credOrError = await authRepository.getCredentials();

    final credentials = credOrError.fold(
      (error) {
        logger.e("Failed to fetch credentials: $error");
        throw Exception("Failed to fetch credentials: $error");
      },
      (credentials) => credentials,
    );

    final haConnectionOption = HAConnectionOption(credentials);
    return _attemptConnection(
      haConnectionOption,
      connectionStateNotifier,
      reconnectionService,
    );
  }

  Future<HAConnection> _attemptConnection(
    HAConnectionOption options,
    ConnectionState connectionStateNotifier,
    ReconnectionService reconnectionService,
  ) async {
    connectionStateNotifier.setConnecting();
    try {
      final socket = await options.createSocket();
      final connection = HAConnection(socket, options);
      connectionStateNotifier.setConnected();
      reconnectionService.stopReconnection();

      ref.onDispose(() {
        logger.i("Disposing HAConnection");
        connectionStateNotifier.setDisconnected();
        reconnectionService.stopReconnection();
        connection.close();
      });

      return connection;
    } catch (e) {
      connectionStateNotifier.setDisconnected();
      logger.e('Initial connection failed: $e');
      reconnectionService.startPeriodicReconnection(() {
        ref.invalidateSelf();
      });
      rethrow;
    }
  }
}
