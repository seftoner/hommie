import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

extension EntityRowMapper on EntityRow {
  HaEntity toDomain() => HaEntity(
    entityId: entityId,
    domain: domain,
    name: name,
    deviceId: deviceId,
    areaId: areaHaId,
  );
}

extension HaEntityCompanionMapper on HaEntity {
  EntitiesCompanion toCompanion(int serverId) => EntitiesCompanion(
    entityId: Value(entityId),
    name: Value(name),
    domain: Value(domain),
    deviceId: Value(deviceId),
    areaHaId: Value(areaId),
    serverId: Value(serverId),
  );
}
