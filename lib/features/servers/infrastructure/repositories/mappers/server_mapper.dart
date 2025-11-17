import 'package:hommie/features/auth/domain/entities/ha_version.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/services/database/models/server_entity.dart';

extension ServerEntityMapper on ServerEntity {
  Server toDomain() {
    HaVersion? haVersion;
    if (version != null) {
      try {
        haVersion = HaVersion.fromString(version!);
      } catch (_) {
        // Invalid version format, leave as null
      }
    }
    return Server(id: id, baseUrl: url, name: name, version: haVersion);
  }
}

extension ServerMapper on Server {
  ServerEntity toDb() {
    if (id != null) {
      return ServerEntity(url: url, name: name, version: version?.toString())
        ..id = id!;
    } else {
      return ServerEntity(url: url, name: name, version: version?.toString());
    }
  }
}
