// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

_$WebSocketPongResponseImpl _$$WebSocketPongResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketPongResponseImpl(
      id: json['id'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WebSocketPongResponseImplToJson(
        _$WebSocketPongResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'runtimeType': instance.$type,
    };

_$WebSocketEventResponseImpl _$$WebSocketEventResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketEventResponseImpl(
      id: json['id'] as int,
      event: StatesUpdates.fromJson(json['event'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WebSocketEventResponseImplToJson(
        _$WebSocketEventResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event': instance.event,
      'runtimeType': instance.$type,
    };

_$WebSocketResultResponseSuccessImpl
    _$$WebSocketResultResponseSuccessImplFromJson(Map<String, dynamic> json) =>
        _$WebSocketResultResponseSuccessImpl(
          id: json['id'] as int,
          result: json['result'],
          success: json['success'] as bool? ?? true,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$WebSocketResultResponseSuccessImplToJson(
        _$WebSocketResultResponseSuccessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'success': instance.success,
      'runtimeType': instance.$type,
    };

_$WebSocketResultResponseErrorImpl _$$WebSocketResultResponseErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketResultResponseErrorImpl(
      id: json['id'] as int,
      success: json['success'] as bool? ?? false,
      error: Error.fromJson(json['error'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WebSocketResultResponseErrorImplToJson(
        _$WebSocketResultResponseErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'success': instance.success,
      'error': instance.error,
      'runtimeType': instance.$type,
    };
