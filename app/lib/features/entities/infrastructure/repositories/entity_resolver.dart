import 'package:hommie/features/entities/domain/entities/ha_entity.dart';
import 'package:hommie/features/entities/infrastructure/repositories/ha_registry_repository.dart';

/// Turns registry rows into cached [HaEntity]s:
/// - drops disabled/hidden entities,
/// - resolves area as entity.area_id ?? device.area_id,
/// - derives domain from the entity_id prefix,
/// - name fallback: name -> original_name -> entity_id.
List<HaEntity> resolveEntities({
  required List<EntityRegistryRecord> entities,
  required List<DeviceRegistryRecord> devices,
}) {
  final deviceAreaById = <String, String?>{
    for (final d in devices) d.id: d.areaId,
  };

  final result = <HaEntity>[];
  for (final e in entities) {
    if (e.disabled || e.hidden) continue;
    final domain = e.entityId.split('.').first;
    final area = e.areaId ?? (e.deviceId != null ? deviceAreaById[e.deviceId] : null);
    final name = e.name ?? e.originalName ?? e.entityId;
    result.add(HaEntity(
      entityId: e.entityId,
      domain: domain,
      name: name,
      deviceId: e.deviceId,
      areaId: area,
    ));
  }
  return result;
}
