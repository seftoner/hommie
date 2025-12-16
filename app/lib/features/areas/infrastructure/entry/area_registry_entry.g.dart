// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_registry_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AreaRegistryEntry _$AreaRegistryEntryFromJson(
  Map<String, dynamic> json,
) => _AreaRegistryEntry(
  createdAt: (json['created_at'] as num).toDouble(),
  modifiedAt: (json['modified_at'] as num).toDouble(),
  aliases: (json['aliases'] as List<dynamic>).map((e) => e as String).toList(),
  areaId: json['area_id'] as String,
  floorId: json['floor_id'] as String?,
  humidityEntityId: json['humidity_entity_id'] as String?,
  icon: json['icon'] as String?,
  labels: (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
  name: json['name'] as String,
  picture: json['picture'] as String?,
  temperatureEntityId: json['temperature_entity_id'] as String?,
);

Map<String, dynamic> _$AreaRegistryEntryToJson(_AreaRegistryEntry instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt,
      'modified_at': instance.modifiedAt,
      'aliases': instance.aliases,
      'area_id': instance.areaId,
      'floor_id': instance.floorId,
      'humidity_entity_id': instance.humidityEntityId,
      'icon': instance.icon,
      'labels': instance.labels,
      'name': instance.name,
      'picture': instance.picture,
      'temperature_entity_id': instance.temperatureEntityId,
    };
