import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';

class ServerContext {
  final Server config;
  final IHAConnection connection;

  const ServerContext({
    required this.config,
    required this.connection,
  });
}
