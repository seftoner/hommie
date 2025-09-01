// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketPongResponse _$WebSocketPongResponseFromJson(
  Map<String, dynamic> json,
) => WebSocketPongResponse(
  id: (json['id'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WebSocketPongResponseToJson(
  WebSocketPongResponse instance,
) => <String, dynamic>{'id': instance.id, 'runtimeType': instance.$type};

WebSocketEventResponse _$WebSocketEventResponseFromJson(
  Map<String, dynamic> json,
) => WebSocketEventResponse(
  id: (json['id'] as num).toInt(),
  event: StatesUpdates.fromJson(json['event'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WebSocketEventResponseToJson(
  WebSocketEventResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'event': instance.event,
  'runtimeType': instance.$type,
};

WebSocketResultResponseSuccess _$WebSocketResultResponseSuccessFromJson(
  Map<String, dynamic> json,
) => WebSocketResultResponseSuccess(
  id: (json['id'] as num).toInt(),
  result: json['result'],
  success: json['success'] as bool? ?? true,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WebSocketResultResponseSuccessToJson(
  WebSocketResultResponseSuccess instance,
) => <String, dynamic>{
  'id': instance.id,
  'result': instance.result,
  'success': instance.success,
  'runtimeType': instance.$type,
};

WebSocketResultResponseError _$WebSocketResultResponseErrorFromJson(
  Map<String, dynamic> json,
) => WebSocketResultResponseError(
  id: (json['id'] as num).toInt(),
  success: json['success'] as bool? ?? false,
  error: HassError.fromJson(json['error'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WebSocketResultResponseErrorToJson(
  WebSocketResultResponseError instance,
) => <String, dynamic>{
  'id': instance.id,
  'success': instance.success,
  'error': instance.error,
  'runtimeType': instance.$type,
};
