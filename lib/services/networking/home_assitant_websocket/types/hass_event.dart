// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hass_event.freezed.dart';
part 'hass_event.g.dart';

@freezed
class EntityStateRemove with _$EntityStateRemove {
  factory EntityStateRemove(List<String> a) = _EntityStateRemove;

  factory EntityStateRemove.fromJson(Map<String, dynamic> json) =>
      _$EntityStateRemoveFromJson(json);
}

@freezed
class EntityState with _$EntityState {
  factory EntityState(
      {@JsonKey(name: 's') String? state,
      @JsonKey(name: 'a') Map<String, dynamic>? attributes,
      @JsonKey(name: 'c') Context? context,
      @JsonKey(name: 'ls') double? last_changed,
      @JsonKey(name: 'lu') double? last_updated}) = _EntityState;

  factory EntityState.fromJson(Map<String, dynamic> json) =>
      _$EntityStateFromJson(json);
}

@freezed
class EntityDiff with _$EntityDiff {
  factory EntityDiff({
    @JsonKey(name: '+') EntityState? add,
    @JsonKey(name: '-') EntityStateRemove? remove,
  }) = _EntityDiff;

  factory EntityDiff.fromJson(Map<String, dynamic> json) =>
      _$EntityDiffFromJson(json);
}

@freezed
class StatesUpdates with _$StatesUpdates {
  const factory StatesUpdates({
    @JsonKey(name: 'a') Map<String, EntityState>? add,
    @JsonKey(name: 'r') List<String>? remove,
    @JsonKey(name: 'c') Map<String, EntityDiff>? change,
  }) = _StatesUpdates;

  factory StatesUpdates.fromJson(Map<String, dynamic> json) =>
      _$StatesUpdatesFromJson(json);
}

@freezed
sealed class Context with _$Context {
  const factory Context(String? id) = ContextId;
  const factory Context.full(
      {required String id, String? user_id, String? parent_id}) = ContextFull;

  factory Context.fromJson(dynamic json) =>
      const ContextConverter().fromJson(json);
}

class ContextConverter implements JsonConverter<Context, Map<String, dynamic>> {
  const ContextConverter();

  @override
  Context fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Context.full(
          id: json["id"],
          parent_id: json["parent_id"],
          user_id: json["user_id"]);
    } else if (json is String) {
      return Context(json);
    } else {
      ///TODO: Throw better error with description.
      throw Error();
    }
  }

  @override
  Map<String, dynamic> toJson(Context object) {
    return object.toJson();
  }
}

@freezed
abstract class HassEventBase with _$HassEventBase {
  const factory HassEventBase({
    required Context context,
    required String origin,
    required String timeFired,
  }) = _HassEventBase;
}

@freezed
sealed class HassEvent with _$HassEvent {
  factory HassEvent({
    required Context context,
    required String origin,
    required String timeFired,
    required String eventType,
    required Map<String, dynamic> data,
  }) = _HassEvent;

  factory HassEvent.fromJson(Map<String, Object?> json) =>
      _$HassEventFromJson(json);
}

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

@freezed
class HassEntityAttributeBase with _$HassEntityAttributeBase {
  const factory HassEntityAttributeBase({
    String? friendly_name,
    String? unit_of_measurement,
    String? icon,
    String? entity_picture,
    num? supported_features,
    bool? hidden,
    bool? assumed_state,
    String? device_class,
    String? state_class,
    bool? restored,
  }) = _HassEntityAttributeBase;

  factory HassEntityAttributeBase.fromJson(Map<String, dynamic> json) =>
      _$HassEntityAttributeBaseFromJson(json);
}
