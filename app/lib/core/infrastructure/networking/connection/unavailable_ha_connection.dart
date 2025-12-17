import 'package:home_assistant_websocket/home_assistant_websocket.dart';

/// A placeholder connection used when the real Home Assistant websocket
/// connection is not currently available.
///
/// This keeps server-scoped providers mountable in offline mode while ensuring
/// any attempt to use the websocket results in a predictable error.
final class UnavailableHAConnection implements IHAConnection {
  final int serverId;
  final Object? cause;

  const UnavailableHAConnection({required this.serverId, this.cause});

  @override
  HAResponse sendMessage(HAMessage message) {
    return Future.error(
      ConnectionClosedError(
        'Home Assistant connection unavailable for server $serverId.',
      ),
    );
  }

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }

  @override
  Future<void> close() async {
    // No-op.
  }
}
