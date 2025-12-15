import 'dart:async';

import 'package:home_assistant_websocket/src/logging/logger_interface.dart';

import 'ha_socket.dart';
import 'ha_socket_state.dart';

class HAConnectionState {
  final StreamController<HASocketState> _controller;
  final HaLogger _logger;
  HASocketState _currentState;
  StreamSubscription<HASocketState>? _socketSubscription;

  Stream<HASocketState> get stateStream => _controller.stream;
  HASocketState get currentState => _currentState;

  HAConnectionState(this._logger)
    : _controller = StreamController<HASocketState>.broadcast(),
      _currentState = const Disconnected();

  void monitorSocket(HASocket socket) {
    _socketSubscription?.cancel();
    _socketSubscription = socket.stateStream.listen(
      (newState) {
        setState(newState);
      },
      onError: (error) {
        _logger.error('Socket state error: $error');
      },
    );

    setState(socket.state);
  }

  void setState(HASocketState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      _controller.add(newState);
      _logger.debug('Connection state changed to: $newState');
    }
  }

  void dispose() {
    _socketSubscription?.cancel();
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}
