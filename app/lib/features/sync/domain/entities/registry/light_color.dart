// ignore_for_file: invalid_annotation_target, non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'light_color.freezed.dart';

@freezed
sealed class LightColor with _$LightColor {
  const factory LightColor.colorTempKelvin({
    @JsonKey(name: 'color_temp_kelvin') required int colorTempKelvin,
  }) = LightColorTempKelvin;

  const factory LightColor.hsColor({
    @JsonKey(name: 'hs_color') required List<num> hsColor,
  }) = LightColorHsColor;

  const factory LightColor.rgbColor({
    @JsonKey(name: 'rgb_color') required List<num> rgbColor,
  }) = LightColorRgbColor;

  const factory LightColor.rgbwColor({
    @JsonKey(name: 'rgbw_color') required List<num> rgbwColor,
  }) = LightColorRgbwColor;

  const factory LightColor.rgbwwColor({
    @JsonKey(name: 'rgbww_color') required List<num> rgbwwColor,
  }) = LightColorRgbwwColor;
}

class LightColorConverter
    implements JsonConverter<LightColor, Map<String, dynamic>> {
  const LightColorConverter();

  @override
  LightColor fromJson(Map<String, dynamic> json) {
    if (json.containsKey('color_temp_kelvin')) {
      return LightColor.colorTempKelvin(
        colorTempKelvin: json['color_temp_kelvin'] as int,
      );
    }
    if (json.containsKey('hs_color')) {
      return LightColor.hsColor(
        hsColor: (json['hs_color'] as List).cast<num>(),
      );
    }
    if (json.containsKey('rgb_color')) {
      return LightColor.rgbColor(
        rgbColor: (json['rgb_color'] as List).cast<num>(),
      );
    }
    if (json.containsKey('rgbw_color')) {
      return LightColor.rgbwColor(
        rgbwColor: (json['rgbw_color'] as List).cast<num>(),
      );
    }
    if (json.containsKey('rgbww_color')) {
      return LightColor.rgbwwColor(
        rgbwwColor: (json['rgbww_color'] as List).cast<num>(),
      );
    }

    throw UnsupportedError('Unsupported LightColor json: $json');
  }

  @override
  Map<String, dynamic> toJson(LightColor object) {
    return object.map(
      colorTempKelvin: (value) => {'color_temp_kelvin': value.colorTempKelvin},
      hsColor: (value) => {'hs_color': value.hsColor},
      rgbColor: (value) => {'rgb_color': value.rgbColor},
      rgbwColor: (value) => {'rgbw_color': value.rgbwColor},
      rgbwwColor: (value) => {'rgbww_color': value.rgbwwColor},
    );
  }
}

class LightColorListConverter
    implements JsonConverter<List<LightColor>?, List<dynamic>?> {
  const LightColorListConverter();

  static const _itemConverter = LightColorConverter();

  @override
  List<LightColor>? fromJson(List<dynamic>? json) {
    if (json == null) {
      return null;
    }
    return json
        .cast<Map<String, dynamic>>()
        .map(_itemConverter.fromJson)
        .toList();
  }

  @override
  List<dynamic>? toJson(List<LightColor>? object) {
    if (object == null) {
      return null;
    }
    return object.map(_itemConverter.toJson).toList();
  }
}
