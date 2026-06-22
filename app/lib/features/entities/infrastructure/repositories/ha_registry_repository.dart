import 'package:home_assistant_websocket/home_assistant_websocket.dart';

/// Minimal projection of a `config/entity_registry/list` row.
class EntityRegistryRecord {
  final String entityId;
  final String? name;
  final String? originalName;
  final String? deviceId;
  final String? areaId;
  final bool disabled;
  final bool hidden;
  final String? entityCategory;

  const EntityRegistryRecord({
    required this.entityId,
    this.name,
    this.originalName,
    this.deviceId,
    this.areaId,
    this.disabled = false,
    this.hidden = false,
    this.entityCategory,
  });

  factory EntityRegistryRecord.fromJson(Map<String, dynamic> j) =>
      EntityRegistryRecord(
        entityId: j['entity_id'] as String,
        name: j['name'] as String?,
        originalName: j['original_name'] as String?,
        deviceId: j['device_id'] as String?,
        areaId: j['area_id'] as String?,
        disabled: j['disabled_by'] != null,
        hidden: j['hidden_by'] != null,
        entityCategory: j['entity_category'] as String?,
      );
}

/// Minimal projection of a `config/device_registry/list` row.
class DeviceRegistryRecord {
  final String id;
  final String? areaId;

  const DeviceRegistryRecord({required this.id, this.areaId});

  factory DeviceRegistryRecord.fromJson(Map<String, dynamic> j) =>
      DeviceRegistryRecord(id: j['id'] as String, areaId: j['area_id'] as String?);
}
