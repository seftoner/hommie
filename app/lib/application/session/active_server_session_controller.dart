import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_link_state_provider.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_server_session_controller.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [serverConnectionManager, activeServer, authState],
)
class ActiveServerSession extends _$ActiveServerSession {
  @override
  ActiveServerSessionState build() {
    final activeServer = ref.watch(activeServerProvider);
    final authState = ref.watch(authStateProvider);
    final linkState = ref.watch(serverLinkStateProvider);

    switch ((activeServer, authState)) {
      case (AsyncData(value: final server), AsyncData(value: final auth)):
        return _project(server, auth, linkState);
      case (AsyncError(), _) || (_, AsyncError()):
        ref.read(serverConnectionManagerProvider).setActiveServer(null);
        return const NoActiveServerSession();
      case _:
        return const ResolvingServerSession();
    }
  }

  ActiveServerSessionState _project(
    Server? server,
    AuthState auth,
    ServerLinkState linkState,
  ) {
    final serverId = server?.id;
    if (server == null || serverId == null) {
      ref.read(serverConnectionManagerProvider).setActiveServer(null);
      return const NoActiveServerSession();
    }

    if (auth is Authenticated) {
      ref.read(serverConnectionManagerProvider).setActiveServer(serverId);
      return switch (linkState) {
        LinkOnline(serverId: final linkServerId, :final connection)
            when linkServerId == serverId =>
          OnlineServerSession(activeServer: server, connection: connection),
        LinkConnecting(serverId: final linkServerId)
            when linkServerId == serverId =>
          ConnectingServerSession(server),
        LinkIdle() => ConnectingServerSession(server),
        LinkReconnecting(serverId: final linkServerId)
            when linkServerId == serverId =>
          OfflineServerSession(activeServer: server),
        LinkOffline(serverId: final linkServerId, :final cause)
            when linkServerId == serverId =>
          OfflineServerSession(activeServer: server, cause: cause),
        LinkAuthFailed(serverId: final linkServerId)
            when linkServerId == serverId =>
          AuthRevokedServerSession(server),
        _ => ConnectingServerSession(server),
      };
    }

    if (auth is Revoked) {
      ref.read(serverConnectionManagerProvider).setActiveServer(serverId);
      return AuthRevokedServerSession(server);
    }

    ref.read(serverConnectionManagerProvider).setActiveServer(null);
    return const NoActiveServerSession();
  }
}
