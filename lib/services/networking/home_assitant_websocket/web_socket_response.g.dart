// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebSocketPongResponseImpl _$$WebSocketPongResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketPongResponseImpl(
      id: json['id'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WebSocketPongResponseImplToJson(
        _$WebSocketPongResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.$type,
    };

_$WebSocketEventResponseImpl _$$WebSocketEventResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketEventResponseImpl(
      id: json['id'] as int,
      event: HassEvent.fromJson(json['event'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WebSocketEventResponseImplToJson(
        _$WebSocketEventResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event': instance.event,
      'type': instance.$type,
    };

_$WebSocketResultResponseSuccessImpl
    _$$WebSocketResultResponseSuccessImplFromJson(Map<String, dynamic> json) =>
        _$WebSocketResultResponseSuccessImpl(
          id: json['id'] as int,
          result: json['result'],
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$WebSocketResultResponseSuccessImplToJson(
        _$WebSocketResultResponseSuccessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'type': instance.$type,
    };

_$WebSocketResultResponseErrorImpl _$$WebSocketResultResponseErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketResultResponseErrorImpl(
      id: json['id'] as int,
      code: json['code'] as String,
      message: json['message'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WebSocketResultResponseErrorImplToJson(
        _$WebSocketResultResponseErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'message': instance.message,
      'type': instance.$type,
    };
