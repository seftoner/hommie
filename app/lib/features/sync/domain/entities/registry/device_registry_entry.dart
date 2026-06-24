import 'package:freezed_annotation/freezed_annotation.dart';

import 'registry_entry.dart';
import 'registry_enums.dart';

part 'device_registry_entry.freezed.dart';
part 'device_registry_entry.g.dart';

@freezed
sealed class DeviceRegistryEntry with _$DeviceRegistryEntry {
  @JsonSerializable(fieldRename: FieldRename.snake)
  @Implements<RegistryEntry>()
  const factory DeviceRegistryEntry({
    required double createdAt,
    required double modifiedAt,
    required String id,
    required List<String> configEntries,
    required Map<String, List<String?>> configEntriesSubentries,
    required List<List<String>> connections,
    required List<List<String>> identifiers,
    String? manufacturer,
    String? model,
    String? modelId,
    String? name,
    required List<String> labels,
    String? swVersion,
    String? hwVersion,
    String? serialNumber,
    String? viaDeviceId,
    String? areaId,
    String? nameByUser,
    DeviceRegistryEntryType? entryType,
    DeviceRegistryDisabledBy? disabledBy,
    String? configurationUrl,
    String? primaryConfigEntry,
  }) = _DeviceRegistryEntry;

  factory DeviceRegistryEntry.fromJson(Map<String, dynamic> json) =>
      _$DeviceRegistryEntryFromJson(json);
}
