// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_registry_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceRegistryEntry _$DeviceRegistryEntryFromJson(
  Map<String, dynamic> json,
) => _DeviceRegistryEntry(
  createdAt: (json['created_at'] as num).toDouble(),
  modifiedAt: (json['modified_at'] as num).toDouble(),
  id: json['id'] as String,
  configEntries: (json['config_entries'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  configEntriesSubentries:
      (json['config_entries_subentries'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String?).toList()),
      ),
  connections: (json['connections'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
  identifiers: (json['identifiers'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
  manufacturer: json['manufacturer'] as String?,
  model: json['model'] as String?,
  modelId: json['model_id'] as String?,
  name: json['name'] as String?,
  labels: (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
  swVersion: json['sw_version'] as String?,
  hwVersion: json['hw_version'] as String?,
  serialNumber: json['serial_number'] as String?,
  viaDeviceId: json['via_device_id'] as String?,
  areaId: json['area_id'] as String?,
  nameByUser: json['name_by_user'] as String?,
  entryType: $enumDecodeNullable(
    _$DeviceRegistryEntryTypeEnumMap,
    json['entry_type'],
  ),
  disabledBy: $enumDecodeNullable(
    _$DeviceRegistryDisabledByEnumMap,
    json['disabled_by'],
  ),
  configurationUrl: json['configuration_url'] as String?,
  primaryConfigEntry: json['primary_config_entry'] as String?,
);

Map<String, dynamic> _$DeviceRegistryEntryToJson(
  _DeviceRegistryEntry instance,
) => <String, dynamic>{
  'created_at': instance.createdAt,
  'modified_at': instance.modifiedAt,
  'id': instance.id,
  'config_entries': instance.configEntries,
  'config_entries_subentries': instance.configEntriesSubentries,
  'connections': instance.connections,
  'identifiers': instance.identifiers,
  'manufacturer': instance.manufacturer,
  'model': instance.model,
  'model_id': instance.modelId,
  'name': instance.name,
  'labels': instance.labels,
  'sw_version': instance.swVersion,
  'hw_version': instance.hwVersion,
  'serial_number': instance.serialNumber,
  'via_device_id': instance.viaDeviceId,
  'area_id': instance.areaId,
  'name_by_user': instance.nameByUser,
  'entry_type': _$DeviceRegistryEntryTypeEnumMap[instance.entryType],
  'disabled_by': _$DeviceRegistryDisabledByEnumMap[instance.disabledBy],
  'configuration_url': instance.configurationUrl,
  'primary_config_entry': instance.primaryConfigEntry,
};

const _$DeviceRegistryEntryTypeEnumMap = {
  DeviceRegistryEntryType.service: 'service',
};

const _$DeviceRegistryDisabledByEnumMap = {
  DeviceRegistryDisabledBy.user: 'user',
  DeviceRegistryDisabledBy.integration: 'integration',
  DeviceRegistryDisabledBy.configEntry: 'config_entry',
};
