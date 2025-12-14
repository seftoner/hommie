// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_registry_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EntityRegistryEntry _$EntityRegistryEntryFromJson(
  Map<String, dynamic> json,
) => _EntityRegistryEntry(
  createdAt: (json['created_at'] as num).toDouble(),
  modifiedAt: (json['modified_at'] as num).toDouble(),
  id: json['id'] as String,
  entityId: json['entity_id'] as String,
  name: json['name'] as String?,
  icon: json['icon'] as String?,
  platform: json['platform'] as String,
  configEntryId: json['config_entry_id'] as String?,
  configSubentryId: json['config_subentry_id'] as String?,
  deviceId: json['device_id'] as String?,
  areaId: json['area_id'] as String?,
  labels: (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
  disabledBy: $enumDecodeNullable(
    _$EntityRegistryDisabledByEnumMap,
    json['disabled_by'],
  ),
  hiddenBy: $enumDecodeNullable(
    _$EntityRegistryHiddenByEnumMap,
    json['hidden_by'],
  ),
  entityCategory: $enumDecodeNullable(
    _$EntityCategoryEnumMap,
    json['entity_category'],
  ),
  hasEntityName: json['has_entity_name'] as bool,
  originalName: json['original_name'] as String?,
  uniqueId: json['unique_id'] as String,
  translationKey: json['translation_key'] as String?,
  options: json['options'] == null
      ? null
      : EntityRegistryOptions.fromJson(json['options'] as Map<String, dynamic>),
  categories: Map<String, String>.from(json['categories'] as Map),
);

Map<String, dynamic> _$EntityRegistryEntryToJson(
  _EntityRegistryEntry instance,
) => <String, dynamic>{
  'created_at': instance.createdAt,
  'modified_at': instance.modifiedAt,
  'id': instance.id,
  'entity_id': instance.entityId,
  'name': instance.name,
  'icon': instance.icon,
  'platform': instance.platform,
  'config_entry_id': instance.configEntryId,
  'config_subentry_id': instance.configSubentryId,
  'device_id': instance.deviceId,
  'area_id': instance.areaId,
  'labels': instance.labels,
  'disabled_by': _$EntityRegistryDisabledByEnumMap[instance.disabledBy],
  'hidden_by': _$EntityRegistryHiddenByEnumMap[instance.hiddenBy],
  'entity_category': _$EntityCategoryEnumMap[instance.entityCategory],
  'has_entity_name': instance.hasEntityName,
  'original_name': instance.originalName,
  'unique_id': instance.uniqueId,
  'translation_key': instance.translationKey,
  'options': instance.options,
  'categories': instance.categories,
};

const _$EntityRegistryDisabledByEnumMap = {
  EntityRegistryDisabledBy.user: 'user',
  EntityRegistryDisabledBy.device: 'device',
  EntityRegistryDisabledBy.integration: 'integration',
  EntityRegistryDisabledBy.configEntry: 'config_entry',
};

const _$EntityRegistryHiddenByEnumMap = {
  EntityRegistryHiddenBy.user: 'user',
  EntityRegistryHiddenBy.device: 'device',
  EntityRegistryHiddenBy.integration: 'integration',
};

const _$EntityCategoryEnumMap = {
  EntityCategory.config: 'config',
  EntityCategory.diagnostic: 'diagnostic',
};
