import 'package:hommie/features/server_manager/domain/models/server_config.dart';
import 'package:hommie/services/database/models/ha_server.dart';

extension ServerMapper on HaServer {
  ServerConfig toDomain() {
    return ServerConfig(
      id: id,
      uri: uri,
      name: name,
    );
  }
}

extension ServerConfigMapper on ServerConfig {
  HaServer toDb() {
    return HaServer(
      uri: uri,
      name: name,
    );
  }
}
