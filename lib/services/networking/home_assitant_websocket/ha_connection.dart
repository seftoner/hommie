import 'dart:async';
import 'dart:convert';

import 'package:hommie/services/networking/home_assitant_websocket/ha_messages.dart';
import 'package:hommie/services/networking/home_assitant_websocket/ha_socket.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/web_socket_response.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assitant_websocket/backoff.dart';

/// Configuration options for Home Assistant connection.
class AuthOption {
  late Uri _serverUri;
  AuthOption({required String serverAddress}) {
    _serverUri = Uri.parse(serverAddress.replaceFirst("http", "ws"));
  }
  Uri get serverUri => _serverUri;
}

/// Represents a subscription to Home Assistant events.
/// Provides a stream of events and a way to unsubscribe.
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

/// Interface for Home Assistant websocket connection.
abstract class IHAConnection {
  /// Sends a message to Home Assistant and returns the response.
  Future<dynamic> sendMessage(HABaseMessgae message);

  /// Subscribes to Home Assistant events.
  /// Returns a [HassSubscription] that can be used to receive events and unsubscribe.
  HassSubscription subscribeMessage(HABaseMessgae subscribeMessage);

  /// Closes the connection.
  void close();
}

/// Implementation of Home Assistant websocket connection.
/// Handles connection management, message sending, and event subscriptions.
class HAConnection implements IHAConnection {
  HASocket? _socket;
  StreamSubscription<dynamic>? _socketSubscription;
  StreamSubscription<HASocketState>? _socketStateSubscription;
  final HAConnectionOption haConnectionOption;
  final _stateController = StreamController<HASocketState>.broadcast();
  final Backoff _backoff;
  bool _closeRequested = false;

  HAConnection(this.haConnectionOption, [Backoff? backoff])
      : _backoff = backoff ?? const ConstantBackoff(Duration(seconds: 5));

  /// Stream of connection state changes.
  Stream<HASocketState> get state => _stateController.stream;

  /// Current connection state.
  HASocketState get currentState =>
      _socket?.state ?? HASocketState.disconnected;

  //Wonder why 2? this part from official code: socket may send 1 at the start to enable features
  int _commndID = 2;
  final Map<int, Completer> _commands = {};
  final Map<int, HassSubscription> _subscriptions = {};
  int get _getCommndID => _commndID++;

  /// Establishes connection to Home Assistant.
  /// Throws an exception if connection fails.
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
    _backoff.reset();
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
      _reconnect();
    }

    _stateController.add(HASocketState.disconnected);
    logger.d("Connection closed");
  }

  void _reconnect() {
    final delay = _backoff.next;
    logger.i("Scheduling reconnection in ${delay.inSeconds} seconds");

    Future.delayed(delay, () {
      if (!_closeRequested) {
        _stateController.add(HASocketState.reconnecting);
        connect().catchError((e) {
          logger.e("Reconnection failed", error: e);
          _reconnect(); // Try again if failed
        });
      }
    });
  }

  void _handleError(dynamic error) {
    logger.e(error);
  }

  void _setSocket(HASocket socket) {
    _socket = socket;

    _socketSubscription?.cancel();
    _socketStateSubscription?.cancel();

    _socketSubscription = socket.stream
        .listen(_messageListener, onDone: _handleClose, onError: _handleError);

    _socketStateSubscription = socket.stateStream.listen((state) {
      _stateController.add(state);
    });

    logger.i("Connection established 🤝");
  }
}
