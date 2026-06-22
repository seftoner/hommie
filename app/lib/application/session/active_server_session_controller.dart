import 'dart:async';

import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_server_session_controller.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [
    serverConnectionManager,
    authController,
    activeServer,
    authState,
  ],
)
class ActiveServerSession extends _$ActiveServerSession {
  Server? _activeServer;
  AuthState? _authState;
  ActiveServerSessionState? _lastSession;
  int? _connectingServerId;
  bool _signingOut = false;

  @override
  ActiveServerSessionState build() {
    ref.listen(serverConnectionStateProvider, (_, next) {
      _handleTransportState(next);
    });

    final activeServer = ref.watch(activeServerProvider);
    final authState = ref.watch(authStateProvider);

    switch ((activeServer, authState)) {
      case (AsyncData(value: final server), AsyncData(value: final auth)):
        _activeServer = server;
        _authState = auth;
        return _stateForCurrentInputs();
      case (AsyncError(), _) || (_, AsyncError()):
        _activeServer = null;
        _authState = null;
        ref.read(serverConnectionManagerProvider).setActiveServer(null);
        return _remember(const NoActiveServerSession());
      case _:
        return _remember(const ResolvingServerSession());
    }
  }

  ActiveServerSessionState _stateForCurrentInputs() {
    final server = _activeServer;
    final serverId = server?.id;
    if (server == null || serverId == null) {
      ref.read(serverConnectionManagerProvider).setActiveServer(null);
      return _remember(const NoActiveServerSession());
    }

    final auth = _authState;
    if (auth is Authenticated || auth is Refreshing) {
      final current = _lastSession;
      if (current is OnlineServerSession &&
          current.activeServer.id == serverId) {
        return _remember(current);
      }
      _connect(server);
      return _remember(ConnectingServerSession(server));
    }

    if (auth is Revoked) {
      _triggerSignOut(server);
      return _remember(AuthRevokedServerSession(server));
    }

    ref.read(serverConnectionManagerProvider).setActiveServer(null);
    return _remember(const NoActiveServerSession());
  }

  ActiveServerSessionState _remember(ActiveServerSessionState session) {
    _lastSession = session;
    return session;
  }

  void _publish(ActiveServerSessionState session) {
    _lastSession = session;
    state = session;
  }

  void _connect(Server server) {
    final serverId = server.id;
    if (serverId == null || _connectingServerId == serverId) {
      return;
    }

    _connectingServerId = serverId;
    ref.read(serverConnectionManagerProvider).setActiveServer(serverId);
    unawaited(_open(server));
  }

  Future<void> _open(Server server) async {
    final serverId = server.id!;
    try {
      final connection = await ref
          .read(serverConnectionManagerProvider)
          .getConnection(serverId);
      if (_activeServer?.id == serverId && _hasAuthenticatedSession) {
        _publish(
          OnlineServerSession(activeServer: server, connection: connection),
        );
      }
    } on ConnectionOpenCancelled {
      if (_activeServer?.id == serverId) {
        _publish(ConnectingServerSession(server));
      }
    } catch (error, stackTrace) {
      logger.w(
        'Failed to open active session for server $serverId',
        error: error,
        stackTrace: stackTrace,
      );
      if (_activeServer?.id == serverId) {
        _publish(OfflineServerSession(activeServer: server, cause: error));
      }
    } finally {
      if (_connectingServerId == serverId) {
        _connectingServerId = null;
      }
    }
  }

  bool get _hasAuthenticatedSession {
    final auth = _authState;
    return auth is Authenticated || auth is Refreshing;
  }

  void _handleTransportState(HAServerConnectionState transportState) {
    final server = _activeServer;
    if (server == null) {
      return;
    }

    switch (transportState) {
      case HAServerConnectionState.authFailure:
        _publish(AuthRevokedServerSession(server));
        _triggerSignOut(server);
      case HAServerConnectionState.disconnected:
      case HAServerConnectionState.reconnecting:
        _publish(OfflineServerSession(activeServer: server));
      case HAServerConnectionState.connecting:
        _publish(ConnectingServerSession(server));
      case HAServerConnectionState.connected:
      case HAServerConnectionState.unknown:
        break;
    }
  }

  void _triggerSignOut(Server server) {
    final serverId = server.id;
    if (serverId == null || _signingOut) {
      return;
    }

    _signingOut = true;
    unawaited(() async {
      try {
        await ref.read(authControllerProvider).signOut(serverId);
      } finally {
        _signingOut = false;
      }
    }());
  }
}
