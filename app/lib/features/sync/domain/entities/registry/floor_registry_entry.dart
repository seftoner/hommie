import 'package:freezed_annotation/freezed_annotation.dart';

import 'registry_entry.dart';

part 'floor_registry_entry.freezed.dart';
part 'floor_registry_entry.g.dart';

@freezed
sealed class FloorRegistryEntry
    with _$FloorRegistryEntry
    implements RegistryEntry {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FloorRegistryEntry({
    required double createdAt,
    required double modifiedAt,
    required String floorId,
    required String name,
    int? level,
    String? icon,
    required List<String> aliases,
  }) = _FloorRegistryEntry;

  factory FloorRegistryEntry.fromJson(Map<String, dynamic> json) =>
      _$FloorRegistryEntryFromJson(json);
}
