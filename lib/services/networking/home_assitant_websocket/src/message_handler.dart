import 'dart:convert';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/hass_event.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/hass_types.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/web_socket_response.dart';

class HAMessageHandler {
  List<WebSocketResponse> parseMessages(dynamic rawMessage) {
    final decodedJson = jsonDecode(rawMessage);
    final List<dynamic> jsonMessages = _normalizeMessages(decodedJson);

    return jsonMessages
        .map((json) => WebSocketResponse.fromJson(json))
        .toList();
  }

  List<dynamic> _normalizeMessages(dynamic decodedJson) {
    return [
      if (decodedJson is List<dynamic>) ...decodedJson,
      if (decodedJson is! List<dynamic>) decodedJson,
    ];
  }

  /// Handles websocket response messages from Home Assistant server.
  ///
  /// This method processes incoming messages and performs appropriate actions based
  /// on the response type. It is responsible for managing the message flow between
  /// the client and Home Assistant server through the websocket connection.
  ///
  /// The method should be called whenever a new message is received from the
  /// websocket connection.
  void handleResponse(
    WebSocketResponse response, {
    required Function() onPong,
    required Function(StatesUpdates) onEvent,
    required Function(dynamic) onSuccess,
    required Function(HassError) onError,
  }) {
    switch (response) {
      case WebSocketPongResponse():
        onPong();
      case WebSocketEventResponse(event: final event):
        onEvent(event);
      case WebSocketResultResponseSuccess(result: final result):
        onSuccess(result);
      case WebSocketResultResponseError(error: final error):
        onError(error);
    }
  }
}
