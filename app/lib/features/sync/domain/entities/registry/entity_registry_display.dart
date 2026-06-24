// ignore_for_file: invalid_annotation_target, non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

import 'registry_enums.dart';

part 'entity_registry_display.freezed.dart';
part 'entity_registry_display.g.dart';

@freezed
sealed class EntityRegistryDisplayEntry with _$EntityRegistryDisplayEntry {
  @JsonSerializable(explicitToJson: true)
  const factory EntityRegistryDisplayEntry({
    required String entity_id,
    String? name,
    String? icon,
    String? device_id,
    String? area_id,
    required List<String> labels,
    bool? hidden,
    EntityCategory? entity_category,
    String? translation_key,
    String? platform,
    int? display_precision,
    bool? has_entity_name,
  }) = _EntityRegistryDisplayEntry;

  factory EntityRegistryDisplayEntry.fromJson(Map<String, dynamic> json) =>
      _$EntityRegistryDisplayEntryFromJson(json);
}

@freezed
sealed class EntityRegistryDisplayEntryResponseEntity
    with _$EntityRegistryDisplayEntryResponseEntity {
  @JsonSerializable()
  const factory EntityRegistryDisplayEntryResponseEntity({
    @JsonKey(name: 'ei') required String entityId,
    @JsonKey(name: 'di') String? deviceId,
    @JsonKey(name: 'ai') String? areaId,
    @JsonKey(name: 'lb') required List<String> labels,
    @JsonKey(name: 'ec') int? entityCategoryId,
    @JsonKey(name: 'en') String? name,
    @JsonKey(name: 'ic') String? icon,
    @JsonKey(name: 'pl') String? platform,
    @JsonKey(name: 'tk') String? translationKey,
    @JsonKey(name: 'hb') bool? hidden,
    @JsonKey(name: 'dp') int? displayPrecision,
    @JsonKey(name: 'hn') bool? hasEntityName,
  }) = _EntityRegistryDisplayEntryResponseEntity;

  factory EntityRegistryDisplayEntryResponseEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$EntityRegistryDisplayEntryResponseEntityFromJson(json);
}

@freezed
sealed class EntityRegistryDisplayEntryResponse
    with _$EntityRegistryDisplayEntryResponse {
  @JsonSerializable(explicitToJson: true)
  const factory EntityRegistryDisplayEntryResponse({
    required List<EntityRegistryDisplayEntryResponseEntity> entities,
    @JsonKey(
      name: 'entity_categories',
      fromJson: _entityCategoriesFromJson,
      toJson: _entityCategoriesToJson,
    )
    required Map<int, EntityCategory> entityCategories,
  }) = _EntityRegistryDisplayEntryResponse;

  factory EntityRegistryDisplayEntryResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$EntityRegistryDisplayEntryResponseFromJson(json);
}

Map<int, EntityCategory> _entityCategoriesFromJson(Map<String, dynamic> json) {
  return json.map(
    (key, value) => MapEntry(
      int.parse(key),
      EntityCategory.values.firstWhere((c) => c.name == (value as String)),
    ),
  );
}

Map<String, dynamic> _entityCategoriesToJson(Map<int, EntityCategory> object) {
  return object.map((key, value) => MapEntry(key.toString(), value.name));
}

extension EntityRegistryDisplayEntryResponseEntityX
    on EntityRegistryDisplayEntryResponseEntity {
  EntityRegistryDisplayEntry toDisplayEntry(
    Map<int, EntityCategory> entityCategories,
  ) {
    return EntityRegistryDisplayEntry(
      entity_id: entityId,
      name: name,
      icon: icon,
      device_id: deviceId,
      area_id: areaId,
      labels: labels,
      hidden: hidden,
      entity_category: entityCategoryId != null
          ? entityCategories[entityCategoryId!]
          : null,
      translation_key: translationKey,
      platform: platform,
      display_precision: displayPrecision,
      has_entity_name: hasEntityName,
    );
  }
}
