import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/services/networking/home_assitant_websocket/hass_event.dart';

part 'web_socket_response.freezed.dart';
part 'web_socket_response.g.dart';

@Freezed(unionKey: 'type')
class WebSocketResponse with _$WebSocketResponse {
  @FreezedUnionValue('pong')
  const factory WebSocketResponse.pong({required int id}) =
      WebSocketPongResponse;

  @FreezedUnionValue('event')
  const factory WebSocketResponse.event({
    required int id,
    required HassEvent event,
  }) = WebSocketEventResponse;

  @FreezedUnionValue('result')
  const factory WebSocketResponse.resultSuccess({
    required int id,
    required dynamic result,
  }) = WebSocketResultResponseSuccess;

  @FreezedUnionValue('result')
  const factory WebSocketResponse.resultError({
    required int id,
    required String code,
    required String message,
  }) = WebSocketResultResponseError;

  factory WebSocketResponse.fromJson(Map<String, dynamic> json) =>
      _$WebSocketResponseFromJson(json);
}

/*
// @WebSocketResponseConverter()
 class WebSocketResponseConverter
    implements JsonConverter<WebSocketResponse, Map<String, dynamic>> {
  const WebSocketResponseConverter();

  @override
  WebSocketResponse fromJson(Map<String, dynamic> json) {
    // // type data was already set (e.g. because we serialized it ourselves)
    // if (json['runtimeType'] != null) {
    //   return MyResponse.fromJson(json);
    // }

    switch (json['type']) {
      case 'pong':
        return WebSocketResponse.pong(id: json['id']);
      case 'event':
        return WebSocketResponse.event(
          id: json['id'],
          event: HassEvent.fromJson(json['event']),
        );
      case 'result':
        if (json['success']) {
          return WebSocketResponse.resultSuccess(
            id: json['id'],
            result: json['result'],
          );
        } else {
          return WebSocketResponse.resultError(
            id: json['id'],
            code: json['error']['code'],
            message: json['error']['message'],
          );
        }
      default:
        throw Exception(
            'Could not determine the constructor for mapping from JSON');
    }
  }

  @override
  Map<String, dynamic> toJson(WebSocketResponse data) => data.toJson();
}
 */