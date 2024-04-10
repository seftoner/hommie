import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/web_socket_response.dart';

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
      print('New listener added to subscribtion stream!');
    };
    _streamController.onCancel = () {
      print('Listener unsubscribed from subscribtion stream!');
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

  Future<dynamic> sendMessage(Map<String, dynamic> message) async {
    print("HAConnection.sendMessage: (RAW data)  $message");

    assert(!_socket.isClosed(), "Connections is closed");

    var completer = Completer<dynamic>();
    var id = _getCommndID;
    _commands[id] = completer;
    message["id"] = id;
    _socket.sendMessage(message);
    return completer.future;
  }

  void close() {
    _closeRequested = true;
    _socket.close();
  }

  HassSubscription subscribeMessage(Map<String, dynamic> subscribeMessage) {
    print("HAConnection.sendMessage: (RAW data)  $subscribeMessage");

    assert(!_socket.isClosed(), "Connections is closed");

    var id = _getCommndID;

    var hassSubscribtion = HassSubscription(unsubscribe: () async {
      if (!_socket.isClosed()) {
        await sendMessage(Messages.unsubscribeEvents(id));
      }
      _subscriptions.remove(id);
    });

    _subscriptions[id] = hassSubscribtion;

    subscribeMessage["id"] = id;
    _socket.sendMessage(subscribeMessage);
    return hassSubscribtion;
  }

  void _messageListener(dynamic message) {
    print("HAConnection.messageListener: Server response:  $message");

    Map<String, dynamic> messageJson = jsonDecode(message);

    final response = WebSocketResponse.fromJson(messageJson);
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
          print(
              "HAConnection.messageListener: Unknown subscribtion ${response.id}. Unsubscribing");

          sendMessage(Messages.unsubscribeEvents(response.id)).catchError(() {
            print("Error unsubsribing from unknown subscription ${message.id}");
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
        print(
            "HAConnection.messageListener: Unknown message type: ${messageJson}");
    }
  }

  void _handleClose() {
    _commndID = 1;
    _commands.forEach((key, value) {
      value.completeError("HAConnection.handleClose: Connection lost");
    });
    _commands.clear();
    _socketSubscription.cancel();
    if (!_closeRequested) {
      //BUG: HERE CAN BE INFINITIVE LOOP
      _reconnect();
    }

    print("HAConnection.handleClose: Closed");
  }

  void _handleError(dynamic error) {
    print("HAConnection.handleError: $error");
  }

  void _setSocket(HASocket socket) {
    _socket = socket;
    _socketSubscription = _socket.stream
        .listen(_messageListener, onDone: _handleClose, onError: _handleError);
    print("HAConnection.setSocket: connection established");
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 1), () {
      print("HAConnection.reconnect: trying to reconnect");

      haConnectionOption
          .createSocket()
          .then((socket) => _setSocket(socket))
          .catchError((e) => {print("Error reconnect: ${e}")});
    });
  }
}
