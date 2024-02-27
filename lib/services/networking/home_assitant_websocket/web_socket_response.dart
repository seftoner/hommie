import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/services/networking/home_assitant_websocket/hass_event.dart';

part 'web_socket_response.freezed.dart';
part 'web_socket_response.g.dart';

@freezed
abstract class Error with _$Error {
  const factory Error({
    required String code,
    required String message,
  }) = _Error;

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
}

@freezed
sealed class WebSocketResponse with _$WebSocketResponse {
  const factory WebSocketResponse.pong({required int id}) =
      WebSocketPongResponse;

  const factory WebSocketResponse.event({
    required int id,
    required HassEvent event,
  }) = WebSocketEventResponse;

  const factory WebSocketResponse.resultSuccess({
    required int id,
    required dynamic result,
    @Default(true) bool success,
  }) = WebSocketResultResponseSuccess;

  const factory WebSocketResponse.resultError({
    required int id,
    @Default(false) bool success,
    required Error error,
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
    final success = json['success'] as bool;
    final result = json['result'];

    switch (type) {
      case 'pong':
        return WebSocketResponse.pong(id: id);
      case 'event':
        return WebSocketResponse.event(
            id: id, event: HassEvent.fromJson(result as Map<String, dynamic>));
      case 'result' when success:
        return WebSocketResponse.resultSuccess(
          id: id,
          result: result,
          success: true,
        );
      case 'result' when !success:
        return WebSocketResponse.resultError(
          id: id,
          success: false,
          error: Error.fromJson(json['error'] as Map<String, dynamic>),
        );
      default:
        throw UnsupportedError('Unsupported response type: $type');
    }
  }

  @override
  Map<String, dynamic> toJson(WebSocketResponse object) {
    return object.toJson();
  }
}
