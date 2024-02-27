import 'package:hommie/features/auth/auth_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<HAConnection> HAServerConnection(HAServerConnectionRef ref) async {
  final credentials = await ref.watch(authRepositoryProvider).getCredentials();

  final haConnectionOption = HAConnectionOption(credentials!);
  final socket = await haConnectionOption.createSocket();

  final connection = HAConnection(socket, haConnectionOption);

  ref.onDispose(() {
    connection.close();
  });

  return connection;
}
