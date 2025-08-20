import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_connection.dart';

class ServerContext {
  final Server config;
  final IHAConnection connection;

  const ServerContext({
    required this.config,
    required this.connection,
  });
}
