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
    final type = json['type'] as String;
    final id = json['id'] as int;
    final success = json['success'] as bool?;
    final result = json['result'];

    switch (type) {
      case 'pong':
        return WebSocketResponse.pong(id: id);
      case 'event':
      // return WebSocketResponse.event(
      //     id: id,
      //     event:
      //         StatesUpdates.fromJson(json['event'] as Map<String, dynamic>));
      case 'result' when success! == true:
        return WebSocketResponse.resultSuccess(
          id: id,
          result: result,
          success: true,
        );
      case 'result' when success! == false:
        return WebSocketResponse.resultError(
          id: id,
          success: false,
          error: HassError.fromJson(json['error'] as Map<String, dynamic>),
        );
      default:
        throw UnsupportedError('Unsupported response type: $type');
    }
  }

  @override
  Map<String, dynamic> toJson(WebSocketResponse object) {
    throw UnimplementedError("To json is not implemented");
  }
}
