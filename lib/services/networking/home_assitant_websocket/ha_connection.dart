import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/web_socket_response.dart';
import 'package:hommie/utils/logger.dart';

class AuthOption {
  late Uri _serverUri;
  AuthOption({required String serverAddress}) {
    _serverUri = Uri.parse(serverAddress.replaceFirst("http", "ws"));
  }
  Uri get serverUri => _serverUri;
}

class HassSubscription {
  late final StreamController<dynamic> _streamController;

  final Function() unsubscribe;
  Stream<dynamic> get stream => _streamController.stream;

  HassSubscription({required this.unsubscribe}) {
    _streamController = StreamController.broadcast();
    _streamController.onListen = () {
      logger.d('New listener added to subscribtion stream!');
    };
    _streamController.onCancel = () {
      logger.d('Listener unsubscribed from subscribtion stream!');
    };
  }
}

class HAConnection {
  late HASocket _socket;
  late StreamSubscription<dynamic> _socketSubscription;
  final HAConnectionOption haConnectionOption;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  final Map<int, Completer> _commands = {};
  final Map<int, HassSubscription> _subscriptions = {};
  // Map<int, Object> _eventListeners = {};
  bool _closeRequested = false;
  int get _getCommndID => _commndID++;

  HAConnection(HASocket socket, this.haConnectionOption) {
    _setSocket(socket);
  }

  Future<dynamic> sendMessage(HABaseMessgae message) async {
    assert(!_socket.isClosed(), "Connections is closed");

    var completer = Completer<dynamic>();
    var id = _getCommndID;
    _commands[id] = completer;
    message.id = id;
    _socket.sendMessage(message);

    return completer.future;
  }

  void close() {
    _closeRequested = true;
    _socket.close();
  }

  HassSubscription subscribeMessage(HABaseMessgae subscribeMessage) {
    assert(!_socket.isClosed(), "Connections is closed");

    var id = _getCommndID;

    var hassSubscribtion = HassSubscription(unsubscribe: () async {
      if (!_socket.isClosed()) {
        await sendMessage(UnsubscribeEventsMessage(subsctibtionID: id));
      }
      _subscriptions.remove(id);
    });

    _subscriptions[id] = hassSubscribtion;

    subscribeMessage.id = id;
    _socket.sendMessage(subscribeMessage);
    return hassSubscribtion;
  }

  void _messageListener(dynamic incomingMessage) {
    logger.d("Server response:  $incomingMessage");

    final decodedJson = jsonDecode(incomingMessage);

    List<dynamic> jsonMessages = [
      if (decodedJson is List<dynamic>) ...decodedJson,
      if (decodedJson is! List<dynamic>) decodedJson,
    ];

    for (final json in jsonMessages) {
      final response = WebSocketResponse.fromJson(json);
      var msgCompleter = _commands[response.id];

      switch (response) {
        case WebSocketPongResponse():
          msgCompleter?.complete();
          _commands.remove(response.id);
          break;
        case WebSocketEventResponse(event: var event):
          var subscribtion = _subscriptions[response.id];
          if (subscribtion != null) {
            subscribtion._streamController.add(event);
          } else {
            logger.e("Unknown subscribtion ${response.id}. Unsubscribing");

            sendMessage(UnsubscribeEventsMessage(subsctibtionID: response.id))
                .catchError((e) {
              logger.e(
                  "Error unsubsribing from unknown subscription ${incomingMessage.id}. Error: $e");
            });
          }
          break;
        case WebSocketResultResponseSuccess(result: var result):
          msgCompleter?.complete(result);
          _commands.remove(response.id);
          break;
        case WebSocketResultResponseError(error: var result):
          msgCompleter?.completeError(result);
          _commands.remove(response.id);
          break;
        default:
          logger.e("Unknown message type: ${json}");
      }
    }
  }

  void _handleClose() {
    _commndID = 1;
    _commands.forEach((key, value) {
      value.completeError("Connection lost");
    });
    _commands.clear();
    _socketSubscription.cancel();
    if (!_closeRequested) {
      //BUG: HERE CAN BE INFINITIVE LOOP
      _reconnect();
    }

    logger.d("Closed");
  }

  void _handleError(dynamic error) {
    logger.e(error);
  }

  void _setSocket(HASocket socket) {
    _socket = socket;
    _socketSubscription = _socket.stream
        .listen(_messageListener, onDone: _handleClose, onError: _handleError);
    logger.d("connection established");
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 1), () {
      logger.d("trying to reconnect");

      haConnectionOption
          .createSocket()
          .then((socket) => _setSocket(socket))
          .catchError((e) => {logger.e("Error reconnect: ${e}")});
    });
  }
}
