import 'package:hommie/features/server_manager/domain/models/ha_server_config.dart';
import 'package:hommie/services/database/models/ha_server.dart';

extension ServerMapper on HaServer {
  HaServerConfig toDomain() {
    return HaServerConfig(
      id: id,
      baseUrl: uri,
      name: name,
    );
  }
}

extension ServerConfigMapper on HaServerConfig {
  HaServer toDb() {
    return HaServer(
      uri: url,
      name: name,
    );
  }
}
