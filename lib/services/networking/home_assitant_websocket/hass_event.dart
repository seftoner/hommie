import 'package:freezed_annotation/freezed_annotation.dart';

part 'hass_event.freezed.dart';
part 'hass_event.g.dart';

@freezed
abstract class Context with _$Context {
  const factory Context({
    required String id,
    String? user_id,
    String? parent_id,
  }) = _Context;

  factory Context.fromJson(Map<String, Object?> json) =>
      _$ContextFromJson(json);
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
