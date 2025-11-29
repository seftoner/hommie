import 'dart:async';

import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/ha_socket.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_socket_state.dart';

class HAConnectionState {
  final StreamController<HASocketState> _controller;
  HASocketState _currentState;
  StreamSubscription<HASocketState>? _socketSubscription;

  Stream<HASocketState> get stateStream => _controller.stream;
  HASocketState get currentState => _currentState;

  HAConnectionState()
    : _controller = StreamController<HASocketState>.broadcast(),
      _currentState = const Disconnected();

  void monitorSocket(HASocket socket) {
    _socketSubscription?.cancel();
    _socketSubscription = socket.stateStream.listen(
      (newState) {
        setState(newState);
      },
      onError: (error) {
        logger.e('Socket state error: $error');
      },
    );

    setState(socket.state);
  }

  void setState(HASocketState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      _controller.add(newState);
      logger.d('Connection state changed to: $newState');
    }
  }

  void dispose() {
    _socketSubscription?.cancel();
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}
