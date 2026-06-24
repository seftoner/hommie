// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_registry_display.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EntityRegistryDisplayEntry _$EntityRegistryDisplayEntryFromJson(
  Map<String, dynamic> json,
) => _EntityRegistryDisplayEntry(
  entity_id: json['entity_id'] as String,
  name: json['name'] as String?,
  icon: json['icon'] as String?,
  device_id: json['device_id'] as String?,
  area_id: json['area_id'] as String?,
  labels: (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
  hidden: json['hidden'] as bool?,
  entity_category: $enumDecodeNullable(
    _$EntityCategoryEnumMap,
    json['entity_category'],
  ),
  translation_key: json['translation_key'] as String?,
  platform: json['platform'] as String?,
  display_precision: (json['display_precision'] as num?)?.toInt(),
  has_entity_name: json['has_entity_name'] as bool?,
);

Map<String, dynamic> _$EntityRegistryDisplayEntryToJson(
  _EntityRegistryDisplayEntry instance,
) => <String, dynamic>{
  'entity_id': instance.entity_id,
  'name': instance.name,
  'icon': instance.icon,
  'device_id': instance.device_id,
  'area_id': instance.area_id,
  'labels': instance.labels,
  'hidden': instance.hidden,
  'entity_category': _$EntityCategoryEnumMap[instance.entity_category],
  'translation_key': instance.translation_key,
  'platform': instance.platform,
  'display_precision': instance.display_precision,
  'has_entity_name': instance.has_entity_name,
};

const _$EntityCategoryEnumMap = {
  EntityCategory.config: 'config',
  EntityCategory.diagnostic: 'diagnostic',
};

_EntityRegistryDisplayEntryResponseEntity
_$EntityRegistryDisplayEntryResponseEntityFromJson(Map<String, dynamic> json) =>
    _EntityRegistryDisplayEntryResponseEntity(
      entityId: json['ei'] as String,
      deviceId: json['di'] as String?,
      areaId: json['ai'] as String?,
      labels: (json['lb'] as List<dynamic>).map((e) => e as String).toList(),
      entityCategoryId: (json['ec'] as num?)?.toInt(),
      name: json['en'] as String?,
      icon: json['ic'] as String?,
      platform: json['pl'] as String?,
      translationKey: json['tk'] as String?,
      hidden: json['hb'] as bool?,
      displayPrecision: (json['dp'] as num?)?.toInt(),
      hasEntityName: json['hn'] as bool?,
    );

Map<String, dynamic> _$EntityRegistryDisplayEntryResponseEntityToJson(
  _EntityRegistryDisplayEntryResponseEntity instance,
) => <String, dynamic>{
  'ei': instance.entityId,
  'di': instance.deviceId,
  'ai': instance.areaId,
  'lb': instance.labels,
  'ec': instance.entityCategoryId,
  'en': instance.name,
  'ic': instance.icon,
  'pl': instance.platform,
  'tk': instance.translationKey,
  'hb': instance.hidden,
  'dp': instance.displayPrecision,
  'hn': instance.hasEntityName,
};

_EntityRegistryDisplayEntryResponse
_$EntityRegistryDisplayEntryResponseFromJson(Map<String, dynamic> json) =>
    _EntityRegistryDisplayEntryResponse(
      entities: (json['entities'] as List<dynamic>)
          .map(
            (e) => EntityRegistryDisplayEntryResponseEntity.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      entityCategories: _entityCategoriesFromJson(
        json['entity_categories'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$EntityRegistryDisplayEntryResponseToJson(
  _EntityRegistryDisplayEntryResponse instance,
) => <String, dynamic>{
  'entities': instance.entities.map((e) => e.toJson()).toList(),
  'entity_categories': _entityCategoriesToJson(instance.entityCategories),
};
