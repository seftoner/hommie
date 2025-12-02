import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/common/domain/entities/ha_version.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';

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
    return Server(
      id: id,
      baseUrl: ServerUrl(url),
      name: name,
      version: haVersion,
    );
  }
}

extension ServerMapper on Server {
  ServerEntitiesCompanion toCompanion() {
    return ServerEntitiesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      //TODO: Should we store baseUrl or resolved url?
      url: Value(url),
      isActive: const Value(false),
      version: Value(version?.toString()),
    );
  }
}
