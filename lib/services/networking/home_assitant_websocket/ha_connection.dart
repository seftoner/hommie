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

class HAConnection {
  late HASocket _socket;
  late StreamSubscription<dynamic> _subscription;
  final HAConnectionOption haConnectionOption;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  final Map<int, Completer> _commands = {};
  Map<int, Object> _eventListeners = {};
  bool _closeRequested = false;
  int get _getCommndID => ++_commndID;

  HAConnection(HASocket socket, this.haConnectionOption) {
    _setSocket(socket);
  }

  Future<dynamic> sendMessage(Map<String, dynamic> message) async {
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

  void _messageListener(dynamic message) {
    print("Server response:  $message");

    Map<String, dynamic> messageJson = jsonDecode(message);

    final response = WebSocketResponse.fromJson(messageJson);
    var completer = _commands[response.id];

    switch (response) {
      case WebSocketPongResponse():
        completer?.complete();
        _commands.remove(response.id);
        break;
      case WebSocketEventResponse():
        break;
      case WebSocketResultResponseSuccess(result: var result):
        completer?.complete(result);
        _commands.remove(response.id);
        break;
      case WebSocketResultResponseError(error: var result):
        completer?.completeError(result);
        _commands.remove(response.id);
        break;
      default:
        print("Unknown message type: ${messageJson}");
    }
  }

  void _handleClose() {
    _commndID = 1;
    _commands.forEach((key, value) {
      value.completeError("Connection lost");
    });
    _commands.clear();
    _subscription.cancel();
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
    _subscription = _socket.stream
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
