import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/web_socket_response.dart';

class AuthOption {
  late Uri _serverUri;
  AuthOption({required String serverAddress}) {
    _serverUri = Uri.parse(serverAddress.replaceFirst("http", "ws"));
  }
  Uri get serverUri => _serverUri;
}

class HAWebsocketsConnection {
  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  final HASocket socket;
  Map<int, Completer> _commands = {};
  Map<int, Object> _eventListeners = {};

  int get getCommndID => ++_commndID;

  HAWebsocketsConnection(this.socket) {
    socket.stream
        .listen(_messageListener, onDone: _handleClose, onError: _handleError);
  }

  Future<TResponce> sendMessage<TResponce>(Map<String, dynamic> message) async {
    var completer = Completer<TResponce>();
    var id = getCommndID;
    _commands[id] = completer;
    message["id"] = id;
    socket.sendMessage(jsonEncode(message));
    return completer.future;
  }

  void close() {
    socket.close();
  }

  void _messageListener(dynamic message) {
    print("Server response:  $message");

    Map<String, dynamic> messageJson = jsonDecode(message);

    final response = WebSocketResponse.fromJson(messageJson);
    var completer = _commands[response.id];

    switch (response) {
      case WebSocketResponse.pong:
        completer?.complete();
        _commands.remove(response.id);
        break;
      case WebSocketResponse.event:
        break;
      case WebSocketResponse.resultSuccess:
        completer
            ?.complete((response as WebSocketResultResponseSuccess).result);
        _commands.remove(response.id);
        break;
      case WebSocketResponse.resultError:
        completer?.completeError(response);
        _commands.remove(response.id);
        break;
      default:
        print("Unknown message type: ${messageJson}");
    }
  }

  void _handleClose() {
    print("Socket is closed.");
  }

  void _handleError(dynamic error) {
    print(error);
  }
}
