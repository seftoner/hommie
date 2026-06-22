import 'package:home_assistant_websocket/home_assistant_websocket.dart';

final class ManagedHAConnection {
  const ManagedHAConnection({
    required this.currentConnection,
    required this.currentState,
    required this.states,
    required this.close,
  });

  final IHAConnection Function() currentConnection;
  final HASocketState currentState;
  final Stream<HASocketState> states;
  final Future<void> Function() close;

  IHAConnection get connection => currentConnection();
}

final class HAConnectionOpening {
  const HAConnectionOpening({required this.future, required this.close});

  final Future<ManagedHAConnection> future;
  final Future<void> Function() close;
}

final class ConnectionOpenCancelled implements Exception {
  const ConnectionOpenCancelled();

  @override
  String toString() => 'Connection open was cancelled.';
}
