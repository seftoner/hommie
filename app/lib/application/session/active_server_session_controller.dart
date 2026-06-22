import 'dart:async';

import 'package:home_assistant_websocket/home_assistant_websocket.dart'
    show AuthenticationError, ConnectionError;
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
    ServerConnectionState,
  ],
)
class ActiveServerSession extends _$ActiveServerSession {
  Server? _activeServer;
  AuthState? _authState;
  ActiveServerSessionState? _lastSession;
  _ConnectionAttempt? _connectingAttempt;
  final _signedOutServerIds = <int>{};
  int _sessionRevision = 0;
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
        _setInputs(server, auth);
        return _stateForCurrentInputs();
      case (AsyncError(), _) || (_, AsyncError()):
        _setInputs(null, null);
        ref.read(serverConnectionManagerProvider).setActiveServer(null);
        return _remember(const NoActiveServerSession());
      case _:
        _setInputs(null, null);
        return _remember(const ResolvingServerSession());
    }
  }

  void _setInputs(Server? server, AuthState? auth) {
    final previousServerId = _activeServer?.id;
    final previousAuthType = _authState?.runtimeType;
    final previousAuthenticated = _hasAuthenticatedSession;
    final nextServerId = server?.id;
    final nextAuthenticated = auth is Authenticated || auth is Refreshing;

    _activeServer = server;
    _authState = auth;

    if (previousServerId != nextServerId ||
        previousAuthType != auth?.runtimeType ||
        previousAuthenticated != nextAuthenticated) {
      _sessionRevision += 1;
      _connectingAttempt = null;
    }

    if (nextServerId != null && nextAuthenticated) {
      _signedOutServerIds.remove(nextServerId);
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
    if (serverId == null) {
      return;
    }

    final revision = _sessionRevision;
    final currentAttempt = _connectingAttempt;
    if (currentAttempt != null &&
        currentAttempt.serverId == serverId &&
        currentAttempt.revision == revision) {
      return;
    }

    _connectingAttempt = _ConnectionAttempt(
      serverId: serverId,
      revision: revision,
    );
    ref.read(serverConnectionManagerProvider).setActiveServer(serverId);
    unawaited(_open(server, revision));
  }

  Future<void> _open(Server server, int revision) async {
    final serverId = server.id!;
    try {
      final connection = await ref
          .read(serverConnectionManagerProvider)
          .getConnection(serverId);
      if (_isCurrent(serverId, revision) && _hasAuthenticatedSession) {
        _publish(
          OnlineServerSession(activeServer: server, connection: connection),
        );
      }
    } on ConnectionOpenCancelled {
      return;
    } on AuthenticationError {
      if (_isCurrent(serverId, revision) && _hasAuthenticatedSession) {
        _publish(AuthRevokedServerSession(server));
        _triggerSignOut(server);
      }
    } catch (error, stackTrace) {
      if (_isAuthOrTokenError(error) &&
          _isCurrent(serverId, revision) &&
          _hasAuthenticatedSession) {
        _publish(AuthRevokedServerSession(server));
        _triggerSignOut(server);
        return;
      }

      logger.w(
        'Failed to open active session for server $serverId',
        error: error,
        stackTrace: stackTrace,
      );
      if (_isCurrent(serverId, revision) && _hasAuthenticatedSession) {
        _publish(OfflineServerSession(activeServer: server, cause: error));
      }
    } finally {
      final currentAttempt = _connectingAttempt;
      if (currentAttempt != null &&
          currentAttempt.serverId == serverId &&
          currentAttempt.revision == revision) {
        _connectingAttempt = null;
      }
    }
  }

  bool _isCurrent(int serverId, int revision) {
    return _sessionRevision == revision && _activeServer?.id == serverId;
  }

  bool get _hasAuthenticatedSession {
    final auth = _authState;
    return auth is Authenticated || auth is Refreshing;
  }

  bool _isAuthOrTokenError(Object error) {
    if (error is AuthenticationError) {
      return true;
    }

    if (error is! ConnectionError) {
      return false;
    }

    final message = error.toString().toLowerCase();
    return message.contains('auth') || message.contains('token');
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
        if (_hasAuthenticatedSession) {
          _connect(server);
        }
      case HAServerConnectionState.unknown:
        break;
    }
  }

  void _triggerSignOut(Server server) {
    final serverId = server.id;
    if (serverId == null ||
        _signingOut ||
        _signedOutServerIds.contains(serverId)) {
      return;
    }

    _signingOut = true;
    _signedOutServerIds.add(serverId);
    unawaited(() async {
      try {
        await ref.read(authControllerProvider).signOut(serverId);
      } finally {
        _signingOut = false;
      }
    }());
  }
}

final class _ConnectionAttempt {
  const _ConnectionAttempt({required this.serverId, required this.revision});

  final int serverId;
  final int revision;
}
