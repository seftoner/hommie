import 'dart:async';
import 'dart:convert';

/// Helper function to emit socket messages with optional delay.
///
/// This is useful for simulating WebSocket message flow in tests.
///
/// Example:
/// ```dart
/// emitSocketMessage(
///   socketStreamController,
///   {'type': 'auth_ok', 'ha_version': '2021.1.0'},
/// );
///
/// emitSocketMessage(
///   socketStreamController,
///   {'id': 2, 'type': 'event', 'event': {...}},
///   delay: const Duration(milliseconds: 200),
/// );
/// ```
void emitSocketMessage(
  StreamController<String> controller,
  Map<String, dynamic> message, {
  Duration delay = Duration.zero,
}) {
  Future.delayed(delay, () {
    if (!controller.isClosed) {
      controller.add(jsonEncode(message));
    }
  });
}
