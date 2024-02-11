// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hass_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContextImpl _$$ContextImplFromJson(Map<String, dynamic> json) =>
    _$ContextImpl(
      id: json['id'] as String,
      user_id: json['user_id'] as String?,
      parent_id: json['parent_id'] as String?,
    );

Map<String, dynamic> _$$ContextImplToJson(_$ContextImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'parent_id': instance.parent_id,
    };

_$HassEventImpl _$$HassEventImplFromJson(Map<String, dynamic> json) =>
    _$HassEventImpl(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      origin: json['origin'] as String,
      timeFired: json['timeFired'] as String,
      eventType: json['eventType'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$HassEventImplToJson(_$HassEventImpl instance) =>
    <String, dynamic>{
      'context': instance.context,
      'origin': instance.origin,
      'timeFired': instance.timeFired,
      'eventType': instance.eventType,
      'data': instance.data,
    };
