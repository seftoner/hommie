import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

sealed class ActiveServerSessionState {
  const ActiveServerSessionState();

  Server? get server => null;
  bool get isOnline => this is OnlineServerSession;
  bool get isOffline => this is OfflineServerSession;
}

final class NoActiveServerSession extends ActiveServerSessionState {
  const NoActiveServerSession();
}

final class ResolvingServerSession extends ActiveServerSessionState {
  const ResolvingServerSession();
}

final class ConnectingServerSession extends ActiveServerSessionState {
  const ConnectingServerSession(this.activeServer);

  final Server activeServer;

  @override
  Server get server => activeServer;
}

final class OnlineServerSession extends ActiveServerSessionState {
  const OnlineServerSession({
    required this.activeServer,
    required this.connection,
  });

  final Server activeServer;
  final IHAConnection connection;

  @override
  Server get server => activeServer;
}

final class OfflineServerSession extends ActiveServerSessionState {
  const OfflineServerSession({required this.activeServer, this.cause});

  final Server activeServer;
  final Object? cause;

  @override
  Server get server => activeServer;
}

final class AuthRevokedServerSession extends ActiveServerSessionState {
  const AuthRevokedServerSession(this.activeServer);

  final Server activeServer;

  @override
  Server get server => activeServer;
}
