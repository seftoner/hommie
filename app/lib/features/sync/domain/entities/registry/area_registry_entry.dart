import 'package:freezed_annotation/freezed_annotation.dart';

import 'registry_entry.dart';

part 'area_registry_entry.freezed.dart';
part 'area_registry_entry.g.dart';

@freezed
sealed class AreaRegistryEntry with _$AreaRegistryEntry {
  @JsonSerializable(fieldRename: FieldRename.snake)
  @Implements<RegistryEntry>()
  const factory AreaRegistryEntry({
    required double createdAt,
    required double modifiedAt,
    required List<String> aliases,
    required String areaId,
    String? floorId,
    String? humidityEntityId,
    String? icon,
    required List<String> labels,
    required String name,
    String? picture,
    String? temperatureEntityId,
  }) = _AreaRegistryEntry;

  factory AreaRegistryEntry.fromJson(Map<String, dynamic> json) =>
      _$AreaRegistryEntryFromJson(json);
}
