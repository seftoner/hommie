import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/web_socket_response.dart';
import 'package:hommie/core/utils/logger.dart';

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

abstract class IHAConnection {
  Future<dynamic> sendMessage(HABaseMessgae message);
  HassSubscription subscribeMessage(HABaseMessgae subscribeMessage);
  void close();
}

class HAConnection implements IHAConnection {
  HASocket? _socket;
  StreamSubscription<dynamic>? _socketSubscription;
  StreamSubscription<HASocketState>? _socketStateSubscription;
  final HAConnectionOption haConnectionOption;
  final _stateController = StreamController<HASocketState>.broadcast();

  Stream<HASocketState> get state => _stateController.stream;
  HASocketState get currentState =>
      _socket?.state ?? HASocketState.disconnected;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  final Map<int, Completer> _commands = {};
  final Map<int, HassSubscription> _subscriptions = {};
  // Map<int, Object> _eventListeners = {};
  bool _closeRequested = false;
  int get _getCommndID => _commndID++;

  HAConnection(this.haConnectionOption);

  Future<void> connect() async {
    if (_socket != null) {
      logger.w("Connection already exists");
      return;
    }

    try {
      final socket = await haConnectionOption.createSocket();
      _setSocket(socket);
    } catch (e) {
      logger.e("Connection failed: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> sendMessage(HABaseMessgae message) async {
    assert(!_socket!.isClosed(), "Connections is closed");

    var completer = Completer<dynamic>();
    var id = _getCommndID;
    _commands[id] = completer;
    message.id = id;
    _socket!.sendMessage(message);

    return completer.future;
  }

  @override
  void close() {
    _closeRequested = true;
    _socketSubscription?.cancel();
    _socketStateSubscription?.cancel();
    _socket?.close();
    _socket = null;
    _stateController.close();
  }

  @override
  HassSubscription subscribeMessage(HABaseMessgae subscribeMessage) {
    assert(!_socket!.isClosed(), "Connections is closed");

    var id = _getCommndID;

    var hassSubscribtion = HassSubscription(unsubscribe: () async {
      if (!_socket!.isClosed()) {
        await sendMessage(UnsubscribeEventsMessage(subsctibtionID: id));
      }
      _subscriptions.remove(id);
    });

    _subscriptions[id] = hassSubscribtion;

    subscribeMessage.id = id;
    _socket!.sendMessage(subscribeMessage);
    return hassSubscribtion;
  }

  void _messageListener(dynamic incomingMessage) {
    logger.t("Server response:  $incomingMessage");

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
          logger.e("Unknown message type: $json");
      }
    }
  }

  void _handleClose() {
    _commndID = 1;
    _commands.forEach((key, value) {
      value.completeError("Connection lost 📡");
    });
    _commands.clear();
    _socketSubscription?.cancel();
    _socketStateSubscription?.cancel();
    _socket = null;
    if (!_closeRequested) {
      //BUG: HERE CAN BE INFINITIVE LOOP
      _reconnect();
    }

    logger.d("Connection closed");
  }

  void _handleError(dynamic error) {
    logger.e(error);
  }

  void _setSocket(HASocket socket) {
    _socket = socket;
    _socketSubscription = socket.stream
        .listen(_messageListener, onDone: _handleClose, onError: _handleError);

    _socketStateSubscription = socket.stateStream.listen((state) {
      _stateController.add(state);
    });

    logger.i("Connection established 🤝");
  }

  void _reconnect() {
    _socketSubscription?.cancel();
    _socketStateSubscription?.cancel();
    _socket = null;

    if (!_closeRequested) {
      connect().catchError((e) => logger.e("Reconnection error ❌", error: e));
    }
  }
}
