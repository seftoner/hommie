// ignore_for_file: invalid_annotation_target, non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hass_event.freezed.dart';
part 'hass_event.g.dart';

@freezed
sealed class EntityStateRemove with _$EntityStateRemove {
  factory EntityStateRemove(List<String> a) = _EntityStateRemove;

  factory EntityStateRemove.fromJson(Map<String, dynamic> json) =>
      _$EntityStateRemoveFromJson(json);
}

@freezed
sealed class EntityState with _$EntityState {
  factory EntityState({
    @JsonKey(name: 's') String? state,
    @JsonKey(name: 'a') Map<String, dynamic>? attributes,
    @JsonKey(name: 'c') Context? context,
    /** last_changed; if set, also applies to lu */
    @JsonKey(name: 'lc') double? last_changed,
    /** last_updated */
    @JsonKey(name: 'lu') double? last_updated,
  }) = _EntityState;

  factory EntityState.fromJson(Map<String, dynamic> json) =>
      _$EntityStateFromJson(json);
}

@freezed
sealed class EntityDiff with _$EntityDiff {
  factory EntityDiff({
    @JsonKey(name: '+') EntityState? add,
    @JsonKey(name: '-') EntityStateRemove? remove,
  }) = _EntityDiff;

  factory EntityDiff.fromJson(Map<String, dynamic> json) =>
      _$EntityDiffFromJson(json);
}

@freezed
sealed class StatesUpdates with _$StatesUpdates {
  const factory StatesUpdates({
    @JsonKey(name: 'a') Map<String, EntityState>? add,
    @JsonKey(name: 'r') List<String>? remove,
    @JsonKey(name: 'c') Map<String, EntityDiff>? change,
  }) = _StatesUpdates;

  factory StatesUpdates.fromJson(Map<String, dynamic> json) =>
      _$StatesUpdatesFromJson(json);
}

@freezed
sealed class CallServiceResponse with _$CallServiceResponse {
  factory CallServiceResponse({required Context context, dynamic response}) =
      _CallServiceResponse;

  factory CallServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$CallServiceResponseFromJson(json);
}

@freezed
sealed class Context with _$Context {
  const factory Context({
    required String id,
    String? user_id,
    String? parent_id,
  }) = _Context;

  factory Context.fromJson(dynamic json) =>
      const ContextConverter().fromJson(json);
}

class ContextConverter implements JsonConverter<Context, Map<String, dynamic>> {
  const ContextConverter();

  @override
  Context fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Context(
        id: json['id'],
        parent_id: json['parent_id'],
        user_id: json['user_id'],
      );
    } else if (json is String) {
      return Context(id: json);
    } else {
      throw const FormatException('Invalid JSON format for Context');
    }
  }

  @override
  Map<String, dynamic> toJson(Context object) {
    return object.toJson();
  }
}

@freezed
sealed class HassEvent with _$HassEvent {
  factory HassEvent({
    required Context context,
    required String origin,
    required String time_fired,
    required String event_type,
    required Map<String, dynamic> data,
  }) = _HassEvent;

  factory HassEvent.fromJson(Map<String, dynamic> json) =>
      _$HassEventFromJson(json);
}

typedef HassEntityAttributeBase = Map<String, dynamic>;

@freezed
sealed class HassEntity with _$HassEntity {
  const factory HassEntity({
    required String entity_id,
    required String state,
    required String last_changed,
    required String last_updated,
    required HassEntityAttributeBase attributes,
    required Context context,
  }) = _HassEntity;

  factory HassEntity.fromJson(Map<String, dynamic> json) =>
      _$HassEntityFromJson(json);
}

/// Convenience accessors for common Home Assistant entity attribute keys.
extension HassEntityAttributesMapX on HassEntityAttributeBase {
  String? get friendly_name => this['friendly_name'] as String?;
  String? get unit_of_measurement => this['unit_of_measurement'] as String?;
  String? get icon => this['icon'] as String?;
  String? get entity_picture => this['entity_picture'] as String?;

  num? get supported_features {
    final v = this['supported_features'];
    return v is num ? v : null;
  }

  bool? get hidden => this['hidden'] as bool?;
  bool? get assumed_state => this['assumed_state'] as bool?;
  String? get device_class => this['device_class'] as String?;
  String? get state_class => this['state_class'] as String?;
  bool? get restored => this['restored'] as bool?;
}
