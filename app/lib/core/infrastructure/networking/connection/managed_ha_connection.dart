import 'package:home_assistant_websocket/home_assistant_websocket.dart';

final class ManagedHAConnection {
  const ManagedHAConnection({
    required this.connection,
    required this.states,
    required this.close,
  });

  final IHAConnection connection;
  final Stream<HASocketState> states;
  final Future<void> Function() close;
}
