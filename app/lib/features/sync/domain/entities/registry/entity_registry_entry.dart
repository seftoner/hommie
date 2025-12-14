import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity_registry_options.dart';
import 'registry_entry.dart';
import 'registry_enums.dart';

part 'entity_registry_entry.freezed.dart';
part 'entity_registry_entry.g.dart';

@freezed
sealed class EntityRegistryEntry with _$EntityRegistryEntry {
  @JsonSerializable(fieldRename: FieldRename.snake)
  @Implements<RegistryEntry>()
  const factory EntityRegistryEntry({
    required double createdAt,
    required double modifiedAt,
    required String id,
    required String entityId,
    String? name,
    String? icon,
    required String platform,
    String? configEntryId,
    String? configSubentryId,
    String? deviceId,
    String? areaId,
    required List<String> labels,
    EntityRegistryDisabledBy? disabledBy,
    EntityRegistryHiddenBy? hiddenBy,
    EntityCategory? entityCategory,
    required bool hasEntityName,
    String? originalName,
    required String uniqueId,
    String? translationKey,
    EntityRegistryOptions? options,
    required Map<String, String> categories,
  }) = _EntityRegistryEntry;

  factory EntityRegistryEntry.fromJson(Map<String, dynamic> json) =>
      _$EntityRegistryEntryFromJson(json);
}

/* @freezed
sealed class ExtEntityRegistryEntry with _$ExtEntityRegistryEntry {
  @JsonSerializable(fieldRename: FieldRename.snake)
  @Implements<RegistryEntry>()
  const factory ExtEntityRegistryEntry({
    required double createdAt,
    required double modifiedAt,
    required String id,
    required String entityId,
    String? name,
    String? icon,
    required String platform,
    String? configEntryId,
    String? configSubentryId,
    String? deviceId,
    String? areaId,
    required List<String> labels,
    EntityRegistryDisabledBy? disabledBy,
    EntityRegistryHiddenBy? hiddenBy,
    EntityCategory? entityCategory,
    required bool hasEntityName,
    String? originalName,
    required String uniqueId,
    String? translationKey,
    EntityRegistryOptions? options,
    required Map<String, String> categories,
    required Map<String, dynamic> capabilities,
    String? originalIcon,
    String? deviceClass,
    String? originalDeviceClass,
    required List<String> aliases,
  }) = _ExtEntityRegistryEntry;

  factory ExtEntityRegistryEntry.fromJson(Map<String, dynamic> json) =>
      _$ExtEntityRegistryEntryFromJson(json);
}

@freezed
sealed class UpdateEntityRegistryEntryResult
    with _$UpdateEntityRegistryEntryResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdateEntityRegistryEntryResult({
    required ExtEntityRegistryEntry entityEntry,
    int? reloadDelay,
    bool? requireRestart,
  }) = _UpdateEntityRegistryEntryResult;

  factory UpdateEntityRegistryEntryResult.fromJson(Map<String, dynamic> json) =>
      _$UpdateEntityRegistryEntryResultFromJson(json);
}

@freezed
sealed class EntityRegistryEntryUpdateParams
    with _$EntityRegistryEntryUpdateParams {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EntityRegistryEntryUpdateParams({
    String? name,
    String? icon,
    String? deviceClass,
    String? areaId,
    String? disabledBy,
    required String? hiddenBy,
    String? newEntityId,
    String? optionsDomain,
    Map<String, dynamic>? options,
    List<String>? aliases,
    List<String>? labels,
    Map<String, String?>? categories,
  }) = _EntityRegistryEntryUpdateParams;

  factory EntityRegistryEntryUpdateParams.fromJson(Map<String, dynamic> json) =>
      _$EntityRegistryEntryUpdateParamsFromJson(json);
}
 */
