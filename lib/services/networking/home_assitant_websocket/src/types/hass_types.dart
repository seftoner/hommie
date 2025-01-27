// ignore_for_file: invalid_annotation_target, non_constant_identifier_names, constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'hass_types.freezed.dart';
part 'hass_types.g.dart';

@freezed
class HassError with _$HassError {
  const factory HassError({
    required String code,
    required String message,
  }) = _Error;

  factory HassError.fromJson(Map<String, dynamic> json) =>
      _$HassErrorFromJson(json);
}

@freezed
class AreaEntity with _$AreaEntity {
  /// [area_id] - [AreaEntity] Unique ID of area (generated by Home Assistant)
  /// [name] - [AreaEntity] Name of this area
  /// [picture] - [AreaEntity] Picture of this area
  /// [aliases] - [AreaEntity] List of aliases for this area
  const factory AreaEntity({
    required String area_id,
    required String name,
    String? picture,
    List<String>? aliases,
  }) = _AreaEntity;

  factory AreaEntity.fromJson(Map<String, dynamic> json) =>
      _$AreaEntityFromJson(json);
}

@freezed
class AreaEntityList with _$AreaEntityList {
  const factory AreaEntityList(List<AreaEntity> areasList) = _AreaEntityList;

  factory AreaEntityList.fromJson(Map<String, dynamic> json) =>
      _$AreaEntityListFromJson(json);
}

@freezed
abstract class HassUser with _$HassUser {
  const factory HassUser({
    required String id,
    required bool is_admin,
    required bool is_owner,
    required String name,
  }) = _HassUser;

  factory HassUser.fromJson(Map<String, dynamic> json) =>
      _$HassUserFromJson(json);
}

@JsonEnum(valueField: 'state')
enum State {
  NOT_RUNNING('NOT_RUNNING'),
  STARTING('STARTING'),
  RUNNING('RUNNING'),
  STOPPING('STOPPING'),
  FINAL_WRITE('FINAL_WRITE'),
  ;

  const State(this.state);
  final String state;
}

@freezed
class HassConfig with _$HassConfig {
  const factory HassConfig({
    required double latitude,
    required double longitude,
    required double elevation,
    required double radius,
    required UnitSystem unit_system,
    required String location_name,
    required String time_zone,
    required List<String> components,
    required String config_dir,
    required List<String> allowlist_external_dirs,
    required List<String> allowlist_external_urls,
    required String version,
    required String config_source,
    required bool recovery_mode,
    required bool safe_mode,
    // @StringEnum('NOT_RUNNING', 'STARTING', 'RUNNING', 'STOPPING', 'FINAL_WRITE')
    required State state,
    String? external_url,
    String? internal_url,
    List<String>? whitelist_external_dirs,
    required String currency,
    String? country,
    required String language,
  }) = _HassConfig;

  factory HassConfig.fromJson(Map<String, dynamic> json) =>
      _$HassConfigFromJson(json);
}

@freezed
class UnitSystem with _$UnitSystem {
  const factory UnitSystem({
    required String length,
    required String mass,
    required String volume,
    required String temperature,
    required String pressure,
    required String wind_speed,
    required String accumulated_precipitation,
  }) = _UnitSystem;

  factory UnitSystem.fromJson(Map<String, dynamic> json) =>
      _$UnitSystemFromJson(json);
}
