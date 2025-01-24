import 'package:hommie/features/server_manager/domain/models/server_config.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_connection.dart';

class ServerContext {
  final ServerConfig config;
  final IHAConnection connection;

  const ServerContext({
    required this.config,
    required this.connection,
  });
}
