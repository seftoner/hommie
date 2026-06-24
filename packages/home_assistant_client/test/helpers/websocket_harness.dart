import 'package:home_assistant_client/src/connection/ha_connection.dart';
import 'package:home_assistant_client/src/connection/ha_connection_option.dart';
import 'package:home_assistant_client/src/connection/ha_socket.dart';
import 'package:home_assistant_client/src/connection/ha_socket_state.dart';
import 'package:home_assistant_client/src/logging/logger_interface.dart';

import '../fakes/fake_ha_socket.dart';

final class WebSocketHarness {
  WebSocketHarness({required this.connection, required this.socket});

  final HAConnection connection;
  final FakeHASocket socket;

  Future<void> close() => connection.close();
}

final class TestHAConnectionOption implements HAConnectionOption {
  TestHAConnectionOption(this.socket, {this.logger = const NoOpLogger()});

  final FakeHASocket socket;

  @override
  final HaLogger logger;

  @override
  Future<HASocket> createSocket() async => socket;
}

Future<WebSocketHarness> createWebSocketHarness({
  HASocketState initialState = const Authenticated(),
}) async {
  final socket = FakeHASocket();
  socket.setState(initialState);

  final connection = HAConnection(TestHAConnectionOption(socket));
  await connection.connect();

  return WebSocketHarness(connection: connection, socket: socket);
}
