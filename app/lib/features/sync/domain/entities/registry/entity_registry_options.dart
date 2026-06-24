import 'package:freezed_annotation/freezed_annotation.dart';

import 'light_color.dart';

part 'entity_registry_options.freezed.dart';
part 'entity_registry_options.g.dart';

@freezed
sealed class SensorEntityOptions with _$SensorEntityOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SensorEntityOptions({
    int? displayPrecision,
    int? suggestedDisplayPrecision,
    String? unitOfMeasurement,
  }) = _SensorEntityOptions;

  factory SensorEntityOptions.fromJson(Map<String, dynamic> json) =>
      _$SensorEntityOptionsFromJson(json);
}

@freezed
sealed class NumberEntityOptions with _$NumberEntityOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NumberEntityOptions({String? unitOfMeasurement}) =
      _NumberEntityOptions;

  factory NumberEntityOptions.fromJson(Map<String, dynamic> json) =>
      _$NumberEntityOptionsFromJson(json);
}

@freezed
sealed class LockEntityOptions with _$LockEntityOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LockEntityOptions({String? defaultCode}) = _LockEntityOptions;

  factory LockEntityOptions.fromJson(Map<String, dynamic> json) =>
      _$LockEntityOptionsFromJson(json);
}

@freezed
sealed class AlarmControlPanelEntityOptions
    with _$AlarmControlPanelEntityOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AlarmControlPanelEntityOptions({String? defaultCode}) =
      _AlarmControlPanelEntityOptions;

  factory AlarmControlPanelEntityOptions.fromJson(Map<String, dynamic> json) =>
      _$AlarmControlPanelEntityOptionsFromJson(json);
}

@freezed
sealed class WeatherEntityOptions with _$WeatherEntityOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory WeatherEntityOptions({
    String? precipitationUnit,
    String? pressureUnit,
    String? temperatureUnit,
    String? visibilityUnit,
    String? windSpeedUnit,
  }) = _WeatherEntityOptions;

  factory WeatherEntityOptions.fromJson(Map<String, dynamic> json) =>
      _$WeatherEntityOptionsFromJson(json);
}

@freezed
sealed class LightEntityOptions with _$LightEntityOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LightEntityOptions({
    @LightColorListConverter() List<LightColor>? favoriteColors,
  }) = _LightEntityOptions;

  factory LightEntityOptions.fromJson(Map<String, dynamic> json) =>
      _$LightEntityOptionsFromJson(json);
}

@freezed
sealed class SwitchAsXEntityOptions with _$SwitchAsXEntityOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SwitchAsXEntityOptions({
    required String entityId,
    required bool invert,
  }) = _SwitchAsXEntityOptions;

  factory SwitchAsXEntityOptions.fromJson(Map<String, dynamic> json) =>
      _$SwitchAsXEntityOptionsFromJson(json);
}

@freezed
sealed class EntityRegistryOptions with _$EntityRegistryOptions {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EntityRegistryOptions({
    NumberEntityOptions? number,
    SensorEntityOptions? sensor,
    AlarmControlPanelEntityOptions? alarmControlPanel,
    LockEntityOptions? lock,
    WeatherEntityOptions? weather,
    LightEntityOptions? light,
    SwitchAsXEntityOptions? switchAsX,
    Map<String, dynamic>? conversation,
    @JsonKey(name: 'cloud.alexa') Map<String, dynamic>? cloudAlexa,
    @JsonKey(name: 'cloud.google_assistant')
    Map<String, dynamic>? cloudGoogleAssistant,
  }) = _EntityRegistryOptions;

  factory EntityRegistryOptions.fromJson(Map<String, dynamic> json) =>
      _$EntityRegistryOptionsFromJson(json);
}
