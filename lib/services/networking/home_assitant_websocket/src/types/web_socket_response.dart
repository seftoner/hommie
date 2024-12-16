import 'package:freezed_annotation/freezed_annotation.dart';

import 'hass_event.dart';
import 'hass_types.dart';

part 'web_socket_response.freezed.dart';
part 'web_socket_response.g.dart';

@freezed
sealed class WebSocketResponse with _$WebSocketResponse {
  const factory WebSocketResponse.pong({required int id}) =
      WebSocketPongResponse;

  const factory WebSocketResponse.event({
    required int id,
    required StatesUpdates event,
  }) = WebSocketEventResponse;

  const factory WebSocketResponse.resultSuccess({
    required int id,
    required dynamic result,
    @Default(true) bool success,
  }) = WebSocketResultResponseSuccess;

  const factory WebSocketResponse.resultError({
    required int id,
    @Default(false) bool success,
    required HassError error,
  }) = WebSocketResultResponseError;

  factory WebSocketResponse.fromJson(Map<String, dynamic> json) =>
      const WebSocketResponseConverter().fromJson(json);
}

class WebSocketResponseConverter
    implements JsonConverter<WebSocketResponse, Map<String, dynamic>> {
  const WebSocketResponseConverter();

  @override
  WebSocketResponse fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'type': 'pong',
      } =>
        WebSocketResponse.pong(id: id),
      {
        'id': final int id,
        'type': 'event',
        'event': final Map<String, dynamic> event,
      } =>
        WebSocketResponse.event(id: id, event: StatesUpdates.fromJson(event)),
      {
        'id': int id,
        'type': 'result',
        'result': final dynamic result,
        'success': true,
      } =>
        WebSocketResponse.resultSuccess(
          id: id,
          result: result,
          success: true,
        ),
      {
        'id': final int id,
        'type': 'result',
        'error': final Map<String, dynamic> error,
        'success': false,
      } =>
        WebSocketResponse.resultError(
          id: id,
          error: HassError.fromJson(error),
          success: true,
        ),
      _ => throw UnsupportedError(
          'Unsupported response type: ${json['type'] as String}')
    };
  }

  @override
  Map<String, dynamic> toJson(WebSocketResponse object) {
    throw UnimplementedError('To json is not implemented');
  }
}
