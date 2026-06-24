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
  // Note: `entityCategory` is intentionally not written here yet — `HaEntity`
  // doesn't carry it in v1. The column is reserved for future render filtering
  // and stays null until the domain model and sync expose it.
  EntitiesCompanion toCompanion(int serverId) => EntitiesCompanion(
    entityId: Value(entityId),
    name: Value(name),
    domain: Value(domain),
    deviceId: Value(deviceId),
    areaHaId: Value(areaId),
    serverId: Value(serverId),
  );
}
