import 'package:home_assistant_client/home_assistant_client.dart';

final class ManagedHAConnection {
  const ManagedHAConnection({
    required this.currentConnection,
    required this.currentState,
    required this.states,
    required this.close,
    this.retryNow,
    this.setNetworkAvailable,
  });

  final IHAConnection Function() currentConnection;
  final HASocketState currentState;
  final Stream<HASocketState> states;
  final Future<void> Function() close;
  final void Function()? retryNow;
  final void Function({required bool isAvailable})? setNetworkAvailable;

  IHAConnection get connection => currentConnection();
}

final class HAConnectionOpening {
  const HAConnectionOpening({
    required this.future,
    required this.close,
    this.retryNow,
    this.setNetworkAvailable,
  });

  final Future<ManagedHAConnection> future;
  final Future<void> Function() close;
  final void Function()? retryNow;
  final void Function({required bool isAvailable})? setNetworkAvailable;
}

final class ConnectionOpenCancelled implements Exception {
  const ConnectionOpenCancelled();

  @override
  String toString() => 'Connection open was cancelled.';
}
