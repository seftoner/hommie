import 'package:hommie/features/auth/auth_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_websockets_connection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<HAWebsocketsConnection> HAConnection(HAConnectionRef ref) async {
  final credentials = await ref.watch(authRepositoryProvider).getCredentials();

  final socket = await HAConnectionOption(credentials!).createSocket();

  final connection = HAWebsocketsConnection(socket);

  ref.onDispose(() {
    connection.close();
  });

  return connection;
}
