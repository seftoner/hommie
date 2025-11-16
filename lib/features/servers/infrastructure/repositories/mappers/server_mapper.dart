import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/services/database/models/server_entity.dart';

extension ServerEntityMapper on ServerEntity {
  Server toDomain() {
    return Server(id: id, baseUrl: url, name: name);
  }
}

extension ServerMapper on Server {
  ServerEntity toDb() {
    if (id != null) {
      return ServerEntity(url: url, name: name)..id = id!;
    } else {
      return ServerEntity(url: url, name: name);
    }
  }
}
