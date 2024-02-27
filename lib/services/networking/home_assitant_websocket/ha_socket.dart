import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/messages.dart';
import 'package:oauth2/oauth2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class HASocket {
  late final String haVersion;
  final Uri _wsUri;

  late WebSocketChannel _innerchanel;
  late final StreamController<dynamic> _streamController;

  Stream<dynamic> get stream => _streamController.stream;
  int? get closeCode => _innerchanel.closeCode;
  String? get closeReason => _innerchanel.closeReason;

  HASocket.connect(this._wsUri) {
    _streamController = StreamController.broadcast();
    _streamController.onListen = () {
      print('New listener added!');
    };
    _streamController.onCancel = () {
      print('Listener unsubscribed!');
    };

    _startConnection();
  }

  void _startConnection() {
    _innerchanel = WebSocketChannel.connect(_wsUri);

    _innerchanel.stream.listen(
      (event) {
        _streamController.add(event);
      },
      onError: (error) {
        print("Inner socket error: $error");
        _streamController.addError(error);
      },
      onDone: () {
        print(
            "Inner socket is closed. Code ${_innerchanel.closeCode} Reason: ${_innerchanel.closeReason}");
        _streamController.close();
      },
    );
  }

  void sendMessage(Map<String, dynamic> data) {
    print("Sending message: $data");
    _innerchanel.sink.add(jsonEncode(data));
  }

  bool isClosed() {
    return _streamController.isClosed;
  }

  void close() {
    print("Going to close socket");
    _innerchanel.sink.close(status.goingAway);
    _streamController.close();
  }
}

class HAConnectionOption {
  final Credentials _credentials;

  static const _authRequired = "auth_required";
  static const _authInvalid = "auth_invalid";
  static const _authOk = "auth_ok";

  HAConnectionOption(this._credentials);

  Future<HASocket> createSocket() async {
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
    Completer<HASocket> completer = Completer();
    _connect(Uri.parse(serverUrl), completer);
    return completer.future;
  }

  void _connect(Uri uri, Completer completer) {
    final socket = HASocket.connect(uri);

    StreamSubscription<dynamic>? subscription;

    handleOpen(dynamic message) {
      Map<String, dynamic> messageJson = jsonDecode(message);

      if (messageJson.containsKey("type")) {
        switch (messageJson["type"]) {
          case _authRequired:
            socket.sendMessage(Messages.auth(_credentials.accessToken));
            break;
          case _authInvalid:
            completer.completeError(messageJson["message"]);
            break;
          case _authOk:
            print("Auth OK");
            socket.haVersion = messageJson["ha_version"];
            subscription?.cancel();
            completer.complete(socket);
            break;
          default:
            print("Unknown message type: ${messageJson}");
        }
      }
    }

    handleClose() {
      print("Auth closed");
      subscription?.cancel();
      completer.completeError(Exception(
          "Socket is closed. Code ${socket.closeCode} Reason: ${socket.closeReason}"));
    }

    handleError(dynamic error) {
      print("Auth error $error");
      completer.completeError(error);
    }

    subscription = socket.stream
        .listen(handleOpen, onError: handleError, onDone: handleClose);
  }
}
