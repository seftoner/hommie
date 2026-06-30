import 'package:home_assistant_client/home_assistant_client.dart';

/// Minimal projection of a `config/entity_registry/list` row.
class EntityRegistryRecord {
  final String id;
  final String entityId;
  final String uniqueId;
  final String platform;
  final String? name;
  final String? originalName;
  final String? deviceId;
  final String? areaId;
  final bool disabled;
  final bool hidden;
  final String? entityCategory;

  const EntityRegistryRecord({
    String? id,
    required this.entityId,
    String? uniqueId,
    this.platform = 'unknown',
    this.name,
    this.originalName,
    this.deviceId,
    this.areaId,
    this.disabled = false,
    this.hidden = false,
    this.entityCategory,
  }) : id = id ?? entityId,
       uniqueId = uniqueId ?? entityId;

  factory EntityRegistryRecord.fromJson(Map<String, dynamic> j) =>
      EntityRegistryRecord(
        id: j['id'] as String?,
        entityId: j['entity_id'] as String,
        uniqueId: j['unique_id'] as String?,
        platform: j['platform'] as String? ?? 'unknown',
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
  final String? name;
  final String? nameByUser;
  final String? manufacturer;
  final String? model;
  final bool disabled;

  const DeviceRegistryRecord({
    required this.id,
    this.areaId,
    this.name,
    this.nameByUser,
    this.manufacturer,
    this.model,
    this.disabled = false,
  });

  factory DeviceRegistryRecord.fromJson(Map<String, dynamic> j) =>
      DeviceRegistryRecord(
        id: j['id'] as String,
        areaId: j['area_id'] as String?,
        name: j['name'] as String?,
        nameByUser: j['name_by_user'] as String?,
        manufacturer: j['manufacturer'] as String?,
        model: j['model'] as String?,
        disabled: j['disabled_by'] != null,
      );
}

final class EntityRegistryListMessage extends HARequestMessage {
  const EntityRegistryListMessage();

  @override
  String get type => 'config/entity_registry/list';

  @override
  JsonMap get body => const <String, dynamic>{};
}

final class DeviceRegistryListMessage extends HARequestMessage {
  const DeviceRegistryListMessage();

  @override
  String get type => 'config/device_registry/list';

  @override
  JsonMap get body => const <String, dynamic>{};
}

class HaRegistryRepository {
  final IHAConnection _connection;

  HaRegistryRepository(this._connection);

  Future<List<EntityRegistryRecord>> getEntities() => _connection
      .sendMessage(const EntityRegistryListMessage())
      .mapList(EntityRegistryRecord.fromJson);

  Future<List<DeviceRegistryRecord>> getDevices() => _connection
      .sendMessage(const DeviceRegistryListMessage())
      .mapList(DeviceRegistryRecord.fromJson);
}
