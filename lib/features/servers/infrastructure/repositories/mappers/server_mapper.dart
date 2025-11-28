import 'package:drift/drift.dart';
import 'package:hommie/features/auth/domain/entities/ha_version.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/core/database/database.dart';

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
  ServerEntitiesCompanion toCompanion() {
    return ServerEntitiesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      url: Value(url),
      isActive: const Value(false),
      version: Value(version?.toString()),
    );
  }
}
