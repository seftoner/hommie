// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_registry_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FloorRegistryEntry _$FloorRegistryEntryFromJson(Map<String, dynamic> json) =>
    _FloorRegistryEntry(
      createdAt: (json['created_at'] as num).toDouble(),
      modifiedAt: (json['modified_at'] as num).toDouble(),
      floorId: json['floor_id'] as String,
      name: json['name'] as String,
      level: (json['level'] as num?)?.toInt(),
      icon: json['icon'] as String?,
      aliases: (json['aliases'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FloorRegistryEntryToJson(_FloorRegistryEntry instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt,
      'modified_at': instance.modifiedAt,
      'floor_id': instance.floorId,
      'name': instance.name,
      'level': instance.level,
      'icon': instance.icon,
      'aliases': instance.aliases,
    };
