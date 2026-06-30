import 'package:drift/drift.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';

extension EntityRowMapper on EntityRow {
  HaEntity toDomain() => HaEntity(
    registryId: registryId,
    uniqueId: uniqueId,
    platform: platform,
    entityId: entityId,
    domain: domain,
    name: name,
    deviceId: deviceId,
    areaId: areaHaId,
    disabled: disabled,
    hidden: hidden,
    entityCategory: entityCategory,
  );
}

extension HaEntityCompanionMapper on HaEntity {
  EntitiesCompanion toCompanion(int serverId) => EntitiesCompanion(
    registryId: Value(registryId),
    uniqueId: Value(uniqueId),
    platform: Value(platform),
    entityId: Value(entityId),
    name: Value(name),
    domain: Value(domain),
    deviceId: Value(deviceId),
    areaHaId: Value(areaId),
    entityCategory: Value(entityCategory),
    disabled: Value(disabled),
    hidden: Value(hidden),
    serverId: Value(serverId),
  );
}
