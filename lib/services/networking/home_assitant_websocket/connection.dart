import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hommie/services/networking/home_assitant_websocket/web_socket_response.dart';
import 'package:oauth2/oauth2.dart';
// import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AuthOption {
  late Uri _serverUri;
  AuthOption({required String serverAddress}) {
    _serverUri = Uri.parse(serverAddress.replaceFirst("http", "ws"));
  }
  Uri get serverUri => _serverUri;
}

class HAConnection {
  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  late WebSocketChannel _webSocketChanel;
  late String haVersion;
  final Credentials _credentials;
  Map<int, Completer> _commands = {};
  Map<int, Object> _eventListeners = {};

  HAConnection(this._credentials);

  int get getCommndID => ++_commndID;

  void connect() async {
    var serverUrl = _credentials.tokenEndpoint != null
        ? (() {
            switch (_credentials.tokenEndpoint!.scheme) {
              case "http":
                return "ws://${_credentials.tokenEndpoint!.host}";
              case "https":
                return "wss://${_credentials.tokenEndpoint!.host}";
              default:
                throw Exception("Invalid scheme");
            }
          })()
        : throw Exception("Token endpoint is null");

    serverUrl += ":${_credentials.tokenEndpoint?.port}/api/websocket";

    _webSocketChanel = WebSocketChannel.connect(Uri.parse(serverUrl));
    await _webSocketChanel.ready;

    _webSocketChanel.stream.listen(_handleOpen, onError: (error) {
      print(error);
    }, onDone: () {
      print("WEB SOCKET is closed");
    });
  }

  Future<void> _handleOpen(dynamic message) async {
    print(message);
    const MSG_TYPE_AUTH_REQUIRED = "auth_required";
    const MSG_TYPE_AUTH_INVALID = "auth_invalid";
    const MSG_TYPE_AUTH_OK = "auth_ok";

    Map<String, dynamic> messageJson = jsonDecode(message);

    if (messageJson.containsKey("type")) {
      switch (messageJson["type"]) {
        case MSG_TYPE_AUTH_REQUIRED:
          await Future.delayed(Duration(seconds: 2));

          _webSocketChanel.sink.add(jsonEncode({
            "type": "auth",
            "access_token": _credentials.accessToken,
          }));

          break;
        case MSG_TYPE_AUTH_INVALID:
          throw Exception("Invalid token");
        case MSG_TYPE_AUTH_OK:
          print("Auth ok");
          break;
        default:
          print("Unknown message type: ${messageJson}");
      }
    }
  }

  void close() {
    _webSocketChanel.sink.close();
  }

  void _messageListener(dynamic message) {
    print("Server response:  $message");

    Map<String, dynamic> messageJson = jsonDecode(message);

    final response = WebSocketResponse.fromJson(jsonDecode(message));
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
        break;
      case WebSocketResponse.resultError:
        completer?.completeError(response);
        _commands.remove(response.id);
        break;
      default:
        print("Unknown message type: ${messageJson}");
    }

    /*   if (messageJson.containsKey("id")) {
      var id = messageJson["id"];

      var completer = _commands[id];
      if (completer != null) {
        if (messageJson.containsKey("error")) {
          completer.completeError(messageJson["error"]);
        } else {
          switch (messageJson["type"]) {
            case "pong":
              completer.complete();
              break;
            case "result":
              completer.complete(messageJson["result"]);
              break;
            case "event":
              completer.complete(messageJson["event"]);
              break;
            default:
              print("Unknown message type: ${messageJson}");
          }
          _commands.remove(id);
        }
      }
    }
 */

    Future<TResponce> sendMessage<TResponce>(
        Map<String, dynamic> message) async {
      var completer = Completer<TResponce>();
      var id = getCommndID;
      _commands[id] = completer;
      message["id"] = id;
      _webSocketChanel.sink.add(message);
      return completer.future;
    }
  }
}
