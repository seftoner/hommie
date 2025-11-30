// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hass_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Error _$ErrorFromJson(Map<String, dynamic> json) =>
    _Error(code: json['code'] as String, message: json['message'] as String);

Map<String, dynamic> _$ErrorToJson(_Error instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
};

_AreaEntity _$AreaEntityFromJson(Map<String, dynamic> json) => _AreaEntity(
  area_id: json['area_id'] as String,
  name: json['name'] as String,
  picture: json['picture'] as String?,
  aliases: (json['aliases'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AreaEntityToJson(_AreaEntity instance) =>
    <String, dynamic>{
      'area_id': instance.area_id,
      'name': instance.name,
      'picture': instance.picture,
      'aliases': instance.aliases,
    };

_AreaEntityList _$AreaEntityListFromJson(Map<String, dynamic> json) =>
    _AreaEntityList(
      (json['areasList'] as List<dynamic>)
          .map((e) => AreaEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AreaEntityListToJson(_AreaEntityList instance) =>
    <String, dynamic>{'areasList': instance.areasList};

_HassUser _$HassUserFromJson(Map<String, dynamic> json) => _HassUser(
  id: json['id'] as String,
  is_admin: json['is_admin'] as bool,
  is_owner: json['is_owner'] as bool,
  name: json['name'] as String,
);

Map<String, dynamic> _$HassUserToJson(_HassUser instance) => <String, dynamic>{
  'id': instance.id,
  'is_admin': instance.is_admin,
  'is_owner': instance.is_owner,
  'name': instance.name,
};

_HassConfig _$HassConfigFromJson(Map<String, dynamic> json) => _HassConfig(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  elevation: (json['elevation'] as num).toDouble(),
  radius: (json['radius'] as num).toDouble(),
  unit_system: UnitSystem.fromJson(json['unit_system'] as Map<String, dynamic>),
  location_name: json['location_name'] as String,
  time_zone: json['time_zone'] as String,
  components: (json['components'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  config_dir: json['config_dir'] as String,
  allowlist_external_dirs: (json['allowlist_external_dirs'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  allowlist_external_urls: (json['allowlist_external_urls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  version: json['version'] as String,
  config_source: json['config_source'] as String,
  recovery_mode: json['recovery_mode'] as bool,
  safe_mode: json['safe_mode'] as bool,
  state: $enumDecode(_$StateEnumMap, json['state']),
  external_url: json['external_url'] as String?,
  internal_url: json['internal_url'] as String?,
  whitelist_external_dirs: (json['whitelist_external_dirs'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  currency: json['currency'] as String,
  country: json['country'] as String?,
  language: json['language'] as String,
);

Map<String, dynamic> _$HassConfigToJson(_HassConfig instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'elevation': instance.elevation,
      'radius': instance.radius,
      'unit_system': instance.unit_system,
      'location_name': instance.location_name,
      'time_zone': instance.time_zone,
      'components': instance.components,
      'config_dir': instance.config_dir,
      'allowlist_external_dirs': instance.allowlist_external_dirs,
      'allowlist_external_urls': instance.allowlist_external_urls,
      'version': instance.version,
      'config_source': instance.config_source,
      'recovery_mode': instance.recovery_mode,
      'safe_mode': instance.safe_mode,
      'state': _$StateEnumMap[instance.state]!,
      'external_url': instance.external_url,
      'internal_url': instance.internal_url,
      'whitelist_external_dirs': instance.whitelist_external_dirs,
      'currency': instance.currency,
      'country': instance.country,
      'language': instance.language,
    };

const _$StateEnumMap = {
  State.NOT_RUNNING: 'NOT_RUNNING',
  State.STARTING: 'STARTING',
  State.RUNNING: 'RUNNING',
  State.STOPPING: 'STOPPING',
  State.FINAL_WRITE: 'FINAL_WRITE',
};

_UnitSystem _$UnitSystemFromJson(Map<String, dynamic> json) => _UnitSystem(
  length: json['length'] as String,
  mass: json['mass'] as String,
  volume: json['volume'] as String,
  temperature: json['temperature'] as String,
  pressure: json['pressure'] as String,
  wind_speed: json['wind_speed'] as String,
  accumulated_precipitation: json['accumulated_precipitation'] as String,
);

Map<String, dynamic> _$UnitSystemToJson(_UnitSystem instance) =>
    <String, dynamic>{
      'length': instance.length,
      'mass': instance.mass,
      'volume': instance.volume,
      'temperature': instance.temperature,
      'pressure': instance.pressure,
      'wind_speed': instance.wind_speed,
      'accumulated_precipitation': instance.accumulated_precipitation,
    };
