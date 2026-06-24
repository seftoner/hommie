// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_registry_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SensorEntityOptions _$SensorEntityOptionsFromJson(Map<String, dynamic> json) =>
    _SensorEntityOptions(
      displayPrecision: (json['display_precision'] as num?)?.toInt(),
      suggestedDisplayPrecision: (json['suggested_display_precision'] as num?)
          ?.toInt(),
      unitOfMeasurement: json['unit_of_measurement'] as String?,
    );

Map<String, dynamic> _$SensorEntityOptionsToJson(
  _SensorEntityOptions instance,
) => <String, dynamic>{
  'display_precision': instance.displayPrecision,
  'suggested_display_precision': instance.suggestedDisplayPrecision,
  'unit_of_measurement': instance.unitOfMeasurement,
};

_NumberEntityOptions _$NumberEntityOptionsFromJson(Map<String, dynamic> json) =>
    _NumberEntityOptions(
      unitOfMeasurement: json['unit_of_measurement'] as String?,
    );

Map<String, dynamic> _$NumberEntityOptionsToJson(
  _NumberEntityOptions instance,
) => <String, dynamic>{'unit_of_measurement': instance.unitOfMeasurement};

_LockEntityOptions _$LockEntityOptionsFromJson(Map<String, dynamic> json) =>
    _LockEntityOptions(defaultCode: json['default_code'] as String?);

Map<String, dynamic> _$LockEntityOptionsToJson(_LockEntityOptions instance) =>
    <String, dynamic>{'default_code': instance.defaultCode};

_AlarmControlPanelEntityOptions _$AlarmControlPanelEntityOptionsFromJson(
  Map<String, dynamic> json,
) => _AlarmControlPanelEntityOptions(
  defaultCode: json['default_code'] as String?,
);

Map<String, dynamic> _$AlarmControlPanelEntityOptionsToJson(
  _AlarmControlPanelEntityOptions instance,
) => <String, dynamic>{'default_code': instance.defaultCode};

_WeatherEntityOptions _$WeatherEntityOptionsFromJson(
  Map<String, dynamic> json,
) => _WeatherEntityOptions(
  precipitationUnit: json['precipitation_unit'] as String?,
  pressureUnit: json['pressure_unit'] as String?,
  temperatureUnit: json['temperature_unit'] as String?,
  visibilityUnit: json['visibility_unit'] as String?,
  windSpeedUnit: json['wind_speed_unit'] as String?,
);

Map<String, dynamic> _$WeatherEntityOptionsToJson(
  _WeatherEntityOptions instance,
) => <String, dynamic>{
  'precipitation_unit': instance.precipitationUnit,
  'pressure_unit': instance.pressureUnit,
  'temperature_unit': instance.temperatureUnit,
  'visibility_unit': instance.visibilityUnit,
  'wind_speed_unit': instance.windSpeedUnit,
};

_LightEntityOptions _$LightEntityOptionsFromJson(Map<String, dynamic> json) =>
    _LightEntityOptions(
      favoriteColors: const LightColorListConverter().fromJson(
        json['favorite_colors'] as List?,
      ),
    );

Map<String, dynamic> _$LightEntityOptionsToJson(_LightEntityOptions instance) =>
    <String, dynamic>{
      'favorite_colors': const LightColorListConverter().toJson(
        instance.favoriteColors,
      ),
    };

_SwitchAsXEntityOptions _$SwitchAsXEntityOptionsFromJson(
  Map<String, dynamic> json,
) => _SwitchAsXEntityOptions(
  entityId: json['entity_id'] as String,
  invert: json['invert'] as bool,
);

Map<String, dynamic> _$SwitchAsXEntityOptionsToJson(
  _SwitchAsXEntityOptions instance,
) => <String, dynamic>{
  'entity_id': instance.entityId,
  'invert': instance.invert,
};

_EntityRegistryOptions _$EntityRegistryOptionsFromJson(
  Map<String, dynamic> json,
) => _EntityRegistryOptions(
  number: json['number'] == null
      ? null
      : NumberEntityOptions.fromJson(json['number'] as Map<String, dynamic>),
  sensor: json['sensor'] == null
      ? null
      : SensorEntityOptions.fromJson(json['sensor'] as Map<String, dynamic>),
  alarmControlPanel: json['alarm_control_panel'] == null
      ? null
      : AlarmControlPanelEntityOptions.fromJson(
          json['alarm_control_panel'] as Map<String, dynamic>,
        ),
  lock: json['lock'] == null
      ? null
      : LockEntityOptions.fromJson(json['lock'] as Map<String, dynamic>),
  weather: json['weather'] == null
      ? null
      : WeatherEntityOptions.fromJson(json['weather'] as Map<String, dynamic>),
  light: json['light'] == null
      ? null
      : LightEntityOptions.fromJson(json['light'] as Map<String, dynamic>),
  switchAsX: json['switch_as_x'] == null
      ? null
      : SwitchAsXEntityOptions.fromJson(
          json['switch_as_x'] as Map<String, dynamic>,
        ),
  conversation: json['conversation'] as Map<String, dynamic>?,
  cloudAlexa: json['cloud.alexa'] as Map<String, dynamic>?,
  cloudGoogleAssistant: json['cloud.google_assistant'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$EntityRegistryOptionsToJson(
  _EntityRegistryOptions instance,
) => <String, dynamic>{
  'number': instance.number,
  'sensor': instance.sensor,
  'alarm_control_panel': instance.alarmControlPanel,
  'lock': instance.lock,
  'weather': instance.weather,
  'light': instance.light,
  'switch_as_x': instance.switchAsX,
  'conversation': instance.conversation,
  'cloud.alexa': instance.cloudAlexa,
  'cloud.google_assistant': instance.cloudGoogleAssistant,
};
