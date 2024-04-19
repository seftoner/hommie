import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/utils.dart';
import 'package:hommie/utils/logger.dart';
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
      logger.t('New listener added!');
    };
    _streamController.onCancel = () {
      logger.t('Listener unsubscribed!');
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
        logger.t("Inner socket error: $error");
        _streamController.addError(error);
      },
      onDone: () {
        logger.t(
            "Inner socket is closed. Code ${_innerchanel.closeCode} Reason: ${_innerchanel.closeReason}");
        _streamController.close();
      },
    );
  }

  void sendMessage(HABaseMessgae message) {
    final encodedData = message.toJson();
    logger.t("Sending message: $encodedData");

    _innerchanel.sink.add(encodedData);
  }

  bool isClosed() {
    return _streamController.isClosed;
  }

  void close() {
    logger.t("Going to close socket");
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
            //TODO: rewrite this
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
    logger.i("Trying to establish a new connection to $serverUrl");

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
            logger.i("Auth REQUIRED");
            socket.sendMessage(
                AuthMessage(accessToken: _credentials.accessToken));
            break;
          case _authInvalid:
            logger.f("Auth INVALID");
            completer.completeError(messageJson["message"]);
            break;
          case _authOk:
            logger.i("Auth OK");
            socket.haVersion = messageJson["ha_version"];
            subscription?.cancel();
            if (atLeastHaVersion(socket.haVersion, 2022, 9)) {
              socket.sendMessage(SupportedFeaturesMessage());
            }
            completer.complete(socket);
            break;
          default:
            print("Unknown message type: ${messageJson}");
        }
      }
    }

    handleClose() {
      logger.d("Auth closed");
      subscription?.cancel();
      if (!completer.isCompleted) {
        completer.completeError(Exception(
            "Socket is closed. Code ${socket.closeCode} Reason: ${socket.closeReason}"));
      }
    }

    handleError(dynamic error) {
      logger.e("Auth error $error");
      if (!completer.isCompleted) {
        completer.completeError(error);
      }
    }

    subscription = socket.stream
        .listen(handleOpen, onError: handleError, onDone: handleClose);
  }
}
