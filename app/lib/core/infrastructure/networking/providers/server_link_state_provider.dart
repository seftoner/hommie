import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:riverpod/riverpod.dart';

sealed class ServerLinkState {
  const ServerLinkState();

  int? get serverId => null;
}

final class LinkConnecting extends ServerLinkState {
  const LinkConnecting({required this.serverId});

  @override
  final int serverId;
}

final class LinkOnline extends ServerLinkState {
  const LinkOnline({required this.serverId, required this.connection});

  @override
  final int serverId;
  final IHAConnection connection;
}

final class LinkReconnecting extends ServerLinkState {
  const LinkReconnecting({required this.serverId});

  @override
  final int serverId;
}

final class LinkOffline extends ServerLinkState {
  const LinkOffline({required this.serverId, this.cause});

  @override
  final int serverId;
  final Object? cause;
}

final class LinkAuthFailed extends ServerLinkState {
  const LinkAuthFailed({required this.serverId});

  @override
  final int serverId;
}

final class LinkIdle extends ServerLinkState {
  const LinkIdle();
}

final serverLinkStateProvider =
    NotifierProvider<ServerLinkStateController, ServerLinkState>(
      ServerLinkStateController.new,
    );

final class ServerLinkStateController extends Notifier<ServerLinkState> {
  @override
  ServerLinkState build() => const LinkIdle();

  void set(ServerLinkState next) => state = next;

  void reset() => state = const LinkIdle();
}
