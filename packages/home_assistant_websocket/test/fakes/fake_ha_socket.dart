import 'dart:async';
import 'dart:convert';

import 'package:home_assistant_websocket/src/ha_messages.dart';
import 'package:home_assistant_websocket/src/ha_socket.dart';
import 'package:home_assistant_websocket/src/ha_socket_state.dart';

/// In-memory socket fake for deterministic `HAConnection` tests.
///
/// - Records outbound [HABaseMessage]s.
/// - Allows injecting inbound server messages via [addIncoming].
/// - Can simulate server-initiated close via [closeFromServer].
final class FakeHASocket implements HASocket {
  FakeHASocket({HASocketState initialState = const Disconnected()})
    : _state = initialState,
      _stateController = StreamController<HASocketState>.broadcast(),
      _incomingController = StreamController<dynamic>.broadcast(),
      _sentController = StreamController<HABaseMessage>.broadcast();

  final StreamController<HASocketState> _stateController;
  final StreamController<dynamic> _incomingController;
  final StreamController<HABaseMessage> _sentController;

  final List<HABaseMessage> sentMessages = <HABaseMessage>[];

  HASocketState _state;

  int? _closeCode;
  String? _closeReason;
  bool _isAuthInvalid = false;

  @override
  Stream<HASocketState> get stateStream => _stateController.stream;

  @override
  HASocketState get state => _state;

  @override
  Stream<dynamic> get stream => _incomingController.stream;

  @override
  bool get isClosed => _incomingController.isClosed;

  @override
  int? get closeCode => _closeCode;

  @override
  String? get closeReason => _closeReason;

  @override
  bool get isAuthInvalid => _isAuthInvalid;

  void setAuthInvalid({required bool value}) {
    _isAuthInvalid = value;
  }

  void setState(HASocketState newState) {
    _state = newState;
    if (!_stateController.isClosed) {
      _stateController.add(newState);
    }
  }

  /// Adds an inbound server message (as JSON map) to [stream].
  void addIncoming(Map<String, dynamic> message) {
    if (isClosed) return;
    _incomingController.add(jsonEncode(message));
  }

  /// Adds an inbound raw payload to [stream]. Use for invalid JSON tests.
  void addIncomingRaw(dynamic raw) {
    if (isClosed) return;
    _incomingController.add(raw);
  }

  /// Waits for the next outbound message that matches [predicate].
  Future<HABaseMessage> nextSentWhere(bool Function(HABaseMessage) predicate) {
    final completer = Completer<HABaseMessage>();

    late StreamSubscription<HABaseMessage> sub;
    sub = _sentController.stream.listen((m) {
      if (predicate(m) && !completer.isCompleted) {
        completer.complete(m);
        sub.cancel();
      }
    });

    // Also check already-recorded messages first.
    for (final m in sentMessages) {
      if (predicate(m)) {
        sub.cancel();
        return Future<HABaseMessage>.value(m);
      }
    }

    return completer.future;
  }

  @override
  void sendMessage(HABaseMessage message) {
    // Record before any side-effects.
    sentMessages.add(message);
    if (!_sentController.isClosed) {
      _sentController.add(message);
    }

    // Simulate Home Assistant behavior: invalid client message => server closes.
    final type = message.payload['type'];
    if (type is! String || type.isEmpty) {
      closeFromServer(
        closeCode: 1002,
        reason: 'Invalid client message: missing type',
        type: DisconnectionType.error,
      );
    }
  }

  /// Simulates the server closing the socket (triggers onDone for listeners).
  Future<void> closeFromServer({
    int? closeCode,
    String? reason,
    DisconnectionType type = DisconnectionType.error,
  }) async {
    _closeCode = closeCode;
    _closeReason = reason;

    setState(Disconnected(type: type, reason: reason));

    if (!_incomingController.isClosed) {
      await _incomingController.close();
    }

    if (!_stateController.isClosed) {
      await _stateController.close();
    }
  }

  @override
  Future<void> close() async {
    _closeCode ??= 1000;
    _closeReason ??= 'Client closed';

    setState(
      Disconnected(type: DisconnectionType.normal, reason: _closeReason),
    );

    if (!_incomingController.isClosed) {
      await _incomingController.close();
    }

    if (!_stateController.isClosed) {
      await _stateController.close();
    }

    if (!_sentController.isClosed) {
      await _sentController.close();
    }
  }
}
