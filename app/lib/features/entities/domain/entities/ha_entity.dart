/// Cached, domain-agnostic Home Assistant entity metadata.
class HaEntity {
  final String registryId; // stable HA entity registry id
  final String uniqueId; // integration-provided stable unique id
  final String platform; // HA integration/platform
  final String entityId; // e.g. "light.kitchen"
  final String domain; // e.g. "light"
  final String name;
  final String? deviceId;
  final String? areaId; // HA area slug (matches AreaEntities.haId), or null
  final bool disabled;
  final bool hidden;
  final String? entityCategory;

  const HaEntity({
    String? registryId,
    String? uniqueId,
    this.platform = 'unknown',
    required this.entityId,
    required this.domain,
    required this.name,
    this.deviceId,
    this.areaId,
    this.disabled = false,
    this.hidden = false,
    this.entityCategory,
  }) : registryId = registryId ?? entityId,
       uniqueId = uniqueId ?? entityId;
}
