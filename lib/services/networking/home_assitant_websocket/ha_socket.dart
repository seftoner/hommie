import 'dart:async';
import 'dart:convert';

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

  bool _isFirstRestart = false;
  bool _isFollowingRestart = false;
  bool _isManuallyClosed = false;

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
        _isFirstRestart = false;
        _streamController.add(event);
      },
      onError: (error) {
        //TODO: Make propper reconnection
        // _handleLostConnection();
        print("Inner socket error: $error");
        _streamController.addError(error);
      },
      onDone: () {
        if (!_isManuallyClosed) {
          //TODO: Make propper reconnection
          // _handleLostConnection();
        }
        print(
            "Inner socket is closed. Code ${_innerchanel.closeCode} Reason: ${_innerchanel.closeReason}");

        //Close _controller????
      },
    );
  }

  void _handleLostConnection() {
    if (_isFirstRestart && !_isFollowingRestart) {
      Future.delayed(const Duration(seconds: 3), () {
        _isFollowingRestart = false;
        _startConnection();
      });
      _isFollowingRestart = true;
    } else {
      _isFirstRestart = true;
      _startConnection();
    }
  }

  void sendMessage(dynamic data) {
    print("Sending message: $data");
    _innerchanel.sink.add(data);
  }

  bool isClosed() {
    return _streamController.isClosed;
  }

  void close() {
    print("Going to close socket");
    _isManuallyClosed = true;
    _innerchanel.sink.close(status.goingAway);
    _streamController.close();
  }
}

class HAConnectionOption {
  final Credentials _credentials;

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
      print(message);
      const MSG_TYPE_AUTH_REQUIRED = "auth_required";
      const MSG_TYPE_AUTH_INVALID = "auth_invalid";
      const MSG_TYPE_AUTH_OK = "auth_ok";

      Map<String, dynamic> messageJson = jsonDecode(message);

      if (messageJson.containsKey("type")) {
        switch (messageJson["type"]) {
          case MSG_TYPE_AUTH_REQUIRED:
            socket.sendMessage(jsonEncode({
              "type": "auth",
              "access_token": _credentials.accessToken,
            }));
            break;
          case MSG_TYPE_AUTH_INVALID:
            completer.completeError(Exception("Invalid token"));
            break;
          case MSG_TYPE_AUTH_OK:
            print("Auth ok");
            socket.haVersion = messageJson["ha_version"];
            // subscription?.cancel().then((v) => completer.complete(socket));
            subscription?.cancel();
            completer.complete(socket);

            break;
          default:
            print("Unknown message type: ${messageJson}");
        }
      }
    }

    handleClose() {
      print(
          "Socket is closed. Code ${socket.closeCode} Reason: ${socket.closeReason}");
    }

    handleError(dynamic error) {
      completer.completeError(error);
    }

    subscription = socket.stream.listen(handleOpen, onError: handleError);
  }
}
