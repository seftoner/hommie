// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AreaEntityImpl _$$AreaEntityImplFromJson(Map<String, dynamic> json) =>
    _$AreaEntityImpl(
      area_id: json['area_id'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String?,
      aliases:
          (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$AreaEntityImplToJson(_$AreaEntityImpl instance) =>
    <String, dynamic>{
      'area_id': instance.area_id,
      'name': instance.name,
      'picture': instance.picture,
      'aliases': instance.aliases,
    };

_$AreaEntityListImpl _$$AreaEntityListImplFromJson(Map<String, dynamic> json) =>
    _$AreaEntityListImpl(
      (json['areasList'] as List<dynamic>)
          .map((e) => AreaEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AreaEntityListImplToJson(
        _$AreaEntityListImpl instance) =>
    <String, dynamic>{
      'areasList': instance.areasList,
    };

_$HassUserImpl _$$HassUserImplFromJson(Map<String, dynamic> json) =>
    _$HassUserImpl(
      id: json['id'] as String,
      is_admin: json['is_admin'] as bool,
      is_owner: json['is_owner'] as bool,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$HassUserImplToJson(_$HassUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_admin': instance.is_admin,
      'is_owner': instance.is_owner,
      'name': instance.name,
    };

_$HassConfigImpl _$$HassConfigImplFromJson(Map<String, dynamic> json) =>
    _$HassConfigImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      elevation: (json['elevation'] as num).toDouble(),
      unitSystem:
          UnitSystem.fromJson(json['unitSystem'] as Map<String, dynamic>),
      locationName: json['locationName'] as String,
      timeZone: json['timeZone'] as String,
      components: (json['components'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      configDir: json['configDir'] as String,
      allowlistExternalDirs: (json['allowlistExternalDirs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allowlistExternalUrls: (json['allowlistExternalUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      version: json['version'] as String,
      configSource: json['configSource'] as String,
      recoveryMode: json['recoveryMode'] as bool,
      safeMode: json['safeMode'] as bool,
      state: $enumDecode(_$StateEnumMap, json['state']),
      externalUrl: json['externalUrl'] as String?,
      internalUrl: json['internalUrl'] as String?,
      currency: json['currency'] as String,
      country: json['country'] as String?,
      language: json['language'] as String,
    );

Map<String, dynamic> _$$HassConfigImplToJson(_$HassConfigImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'elevation': instance.elevation,
      'unitSystem': instance.unitSystem,
      'locationName': instance.locationName,
      'timeZone': instance.timeZone,
      'components': instance.components,
      'configDir': instance.configDir,
      'allowlistExternalDirs': instance.allowlistExternalDirs,
      'allowlistExternalUrls': instance.allowlistExternalUrls,
      'version': instance.version,
      'configSource': instance.configSource,
      'recoveryMode': instance.recoveryMode,
      'safeMode': instance.safeMode,
      'state': _$StateEnumMap[instance.state]!,
      'externalUrl': instance.externalUrl,
      'internalUrl': instance.internalUrl,
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

_$UnitSystemImpl _$$UnitSystemImplFromJson(Map<String, dynamic> json) =>
    _$UnitSystemImpl(
      length: json['length'] as String,
      mass: json['mass'] as String,
      volume: json['volume'] as String,
      temperature: json['temperature'] as String,
      pressure: json['pressure'] as String,
      windSpeed: json['windSpeed'] as String,
      accumulatedPrecipitation: json['accumulatedPrecipitation'] as String,
    );

Map<String, dynamic> _$$UnitSystemImplToJson(_$UnitSystemImpl instance) =>
    <String, dynamic>{
      'length': instance.length,
      'mass': instance.mass,
      'volume': instance.volume,
      'temperature': instance.temperature,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'accumulatedPrecipitation': instance.accumulatedPrecipitation,
    };
