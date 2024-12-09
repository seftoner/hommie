import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/utils.dart';
import 'package:hommie/core/utils/logger.dart';
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

  void _startConnection() async {
    try {
      _innerchanel = WebSocketChannel.connect(_wsUri);

      _innerchanel.stream.listen(
        (event) => _streamController.add(event),
        onError: (error) {
          logger.t("Inner socket error: $error");
          _streamController.addError(error);
        },
        onDone: () {
          logger.t(
              "Inner socket is closed. Code ${_innerchanel.closeCode} Reason: ${_innerchanel.closeReason}");
          if (!_streamController.isClosed) {
            _reconnect(); // Attempt to reconnect
          } else {
            _streamController.close();
          }
        },
      );
    } catch (e) {
      logger.e("Failed to start connection: $e");
      _streamController.addError(e);
    }
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 5), () {
      logger.i("Attempting to reconnect...");
      _startConnection();
    });
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
    logger.t("Closing socket");
    _innerchanel.sink.close(status.goingAway);
    if (!_streamController.isClosed) {
      _streamController.close();
    }
  }
}

class HAConnectionOption {
  final Credentials _credentials;

  static const _authRequired = "auth_required";
  static const _authInvalid = "auth_invalid";
  static const _authOk = "auth_ok";

  HAConnectionOption(this._credentials);

  Future<HASocket> createSocket() async {
    final tokenEndpoint = _credentials.tokenEndpoint;
    if (tokenEndpoint == null) {
      throw Exception("Token endpoint is null");
    }

    final serverUrl = _buildWebSocketUrl(tokenEndpoint);

    logger.i("Trying to establish a new connection to $serverUrl");

    final completer = Completer<HASocket>();
    _connect(Uri.parse(serverUrl), completer);

    return completer.future;
  }

  String _buildWebSocketUrl(Uri tokenEndpoint) {
    final scheme = switch (tokenEndpoint.scheme) {
      "http" => "ws",
      "https" => "wss",
      _ => throw Exception("Unsupported scheme: ${tokenEndpoint.scheme}"),
    };

    final host = tokenEndpoint.host;
    final port = tokenEndpoint.port;

    return "$scheme://$host:$port/api/websocket";
  }

  void _connect(Uri uri, Completer<HASocket> completer) {
    final socket = HASocket.connect(uri);

    StreamSubscription<dynamic>? subscription;

    void handleOpen(dynamic message) {
      try {
        final messageJson = jsonDecode(message);
        if (messageJson.containsKey("type")) {
          switch (messageJson["type"]) {
            case _authRequired:
              logger.i("Auth REQUIRED");
              socket.sendMessage(
                AuthMessage(accessToken: _credentials.accessToken),
              );
              break;
            case _authInvalid:
              logger.f("Auth INVALID: ${messageJson["message"]}");
              _completeWithError(completer, Exception(messageJson["message"]));
              break;
            case _authOk:
              logger.i("Auth OK");
              socket.haVersion = messageJson["ha_version"];
              subscription?.cancel();
              if (atLeastHaVersion(socket.haVersion, 2022, 9)) {
                socket.sendMessage(SupportedFeaturesMessage());
              }
              _completeSuccessfully(completer, socket);
              break;
            default:
              logger.i("Unknown message type: $messageJson");
          }
        }
      } catch (e) {
        _completeWithError(completer, e);
      }
    }

    void handleClose() {
      logger.d("Socket closed");
      subscription?.cancel();
      if (!completer.isCompleted) {
        _completeWithError(
          completer,
          Exception(
            "Socket is closed. Code ${socket.closeCode} Reason: ${socket.closeReason}",
          ),
        );
      }
    }

    void handleError(dynamic error) {
      logger.e("Socket error: $error");
      _completeWithError(completer, error);
    }

    subscription = socket.stream.listen(
      handleOpen,
      onError: handleError,
      onDone: handleClose,
    );
  }

  void _completeSuccessfully(Completer<HASocket> completer, HASocket socket) {
    if (!completer.isCompleted) {
      completer.complete(socket);
    }
  }

  void _completeWithError(Completer completer, Object error) {
    if (!completer.isCompleted) {
      completer.completeError(error);
    }
  }
}
