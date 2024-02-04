// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hommie/networking/home_assitant_websocket/web_socket_response.dart';
import 'package:oauth2/oauth2.dart';
import 'package:web_socket_channel/io.dart';

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
  late IOWebSocketChannel _webSocket;
  late String haVersion;
  late final Credentials _credentials;
  Map<int, Completer> _commands = {};
  Map<int, Object> _eventListeners = {};

  int get getCommndID => ++_commndID;

  HAConnection.connect(Credentials credentials) : _credentials = credentials {
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

    _webSocket = IOWebSocketChannel.connect(serverUrl);
    _webSocket.stream.listen(_messageListener, onError: (error) {
      print(error);
    }, onDone: () {
      print("done");
    });
  }

  void close() {
    _webSocket.sink.close();
  }

  void _messageListener(dynamic message) {
    print(message);

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
      _webSocket.sink.add(message);
      return completer.future;
    }
  }
}
