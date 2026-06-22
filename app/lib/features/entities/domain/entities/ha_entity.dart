/// Cached, domain-agnostic Home Assistant entity metadata.
class HaEntity {
  final String entityId; // e.g. "light.kitchen"
  final String domain; // e.g. "light"
  final String name;
  final String? deviceId;
  final String? areaId; // HA area slug (matches AreaEntities.haId), or null

  const HaEntity({
    required this.entityId,
    required this.domain,
    required this.name,
    this.deviceId,
    this.areaId,
  });
}
