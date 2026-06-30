import 'package:hommie/features/entities/domain/entity_display_name.dart';
import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

/// Turns registry rows into cached [HaEntity]s:
/// - resolves area as entity.area_id ?? device.area_id,
/// - derives domain from the entity_id prefix,
/// - name fallback: name -> original_name -> HA-like label from entity_id.
List<HaEntity> resolveEntities({
  required List<EntityRegistryRecord> entities,
  required List<DeviceRegistryRecord> devices,
}) {
  final deviceAreaById = <String, String?>{
    for (final d in devices) d.id: d.areaId,
  };

  final result = <HaEntity>[];
  for (final e in entities) {
    final domain = e.entityId.split('.').first;
    final area =
        e.areaId ?? (e.deviceId != null ? deviceAreaById[e.deviceId] : null);
    final name = resolveEntityRegistryDisplayName(
      name: e.name,
      originalName: e.originalName,
      entityId: e.entityId,
    );
    result.add(
      HaEntity(
        registryId: e.id,
        uniqueId: e.uniqueId,
        platform: e.platform,
        entityId: e.entityId,
        domain: domain,
        name: name,
        deviceId: e.deviceId,
        areaId: area,
        disabled: e.disabled,
        hidden: e.hidden,
        entityCategory: e.entityCategory,
      ),
    );
  }
  return result;
}
