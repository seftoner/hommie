import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_connection_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [authRepository])
Future<HAConnection> serverConnection(Ref ref) async {
  final authRepository = ref.watch(authRepositoryProvider);

  final credOrError = await authRepository.getCredentials();
  final credentials = credOrError.fold(
    (error) {
      //TODO: Handle propperly errors
      logger.e("Failed to fetch credentials: $error");
    },
    (credentials) => credentials,
  );

  final haConnectionOption = HAConnectionOption(credentials!);

  final HASocket socket;
  late HAConnection connection;

  try {
    socket = await haConnectionOption.createSocket();
    connection = HAConnection(socket, haConnectionOption);
  } catch (e) {
    logger.e('Connection failed: $e');
    rethrow;
  }

  ref.onDispose(() {
    logger.i("Disposing HAConnection");
    connection.close();
  });

  return connection;
}
