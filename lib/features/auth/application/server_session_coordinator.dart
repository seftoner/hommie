import 'dart:async';

import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/application/auth_flow_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/auth_state_provider.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/i_server_connection_manager.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_session_coordinator.g.dart';

/// Coordinates everything related to a server "session":
/// - eagerly opens a websocket connection after the user authenticates
/// - watches for auth revocations from credential or transport layers and
///   triggers the logout flow so persisted data gets wiped
@Riverpod(
  keepAlive: true,
  dependencies: [
    authFlowController,
    serverConnectionManager,
    ServerConnectionState,
  ],
)
void serverSessionCoordinator(Ref ref) {
  final handler = _ServerSessionHandler(ref);
  ref.onDispose(handler.dispose);

  ref.listen(activeServerProvider, (_, next) {
    next.when(
      data: handler.updateActiveServer,
      loading: () {},
      error: (_, __) => handler.updateActiveServer(null),
    );
  });

  ref.listen(authStateProvider, (_, next) {
    next.when(data: handler.handleAuthState, loading: () {}, error: (_, __) {});
  });

  ref.listen(
    serverConnectionStateProvider,
    (_, next) => handler.handleConnectionState(next),
  );
}

@Dependencies([
  serverConnectionManager,
  ServerConnectionState,
  authFlowController,
])
class _ServerSessionHandler {
  _ServerSessionHandler(this._ref);

  final Ref _ref;
  IServerConnectionManager get _connectionManager =>
      _ref.read(serverConnectionManagerProvider);

  AuthState? _latestAuthState;
  int? _activeServerId;
  int? _lastHandledServerId;
  bool _signingOut = false;
  bool _connecting = false;

  void updateActiveServer(Server? server) {
    final newId = server?.id;
    if (_activeServerId == newId) {
      return;
    }
    _activeServerId = newId;
    _lastHandledServerId = null;
    _connectionManager.setActiveServer(newId);
    if (newId == null) {
      _ref.read(serverConnectionStateProvider.notifier).reset();
      return;
    }
    _scheduleConnectionIfNeeded();
  }

  void handleAuthState(AuthState state) {
    _latestAuthState = state;
    switch (state) {
      case Authenticated() || Refreshing():
        _scheduleConnectionIfNeeded();
      case Revoked():
        _triggerSignOut();
      default:
        break;
    }
  }

  void handleConnectionState(HAServerConnectionState state) {
    if (state == HAServerConnectionState.authFailure) {
      _triggerSignOut();
    }
  }

  void _scheduleConnectionIfNeeded() {
    final serverId = _activeServerId;
    if (serverId == null || _connecting) {
      return;
    }
    final state = _latestAuthState;
    final hasCredentials = state is Authenticated || state is Refreshing;
    if (!hasCredentials) {
      return;
    }
    _connecting = true;
    unawaited(_connect(serverId));
  }

  Future<void> _connect(int serverId) async {
    try {
      await _connectionManager.getConnection(serverId);
    } catch (error, stackTrace) {
      logger.w(
        'Failed to open connection for server $serverId',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _connecting = false;
    }
  }

  void _triggerSignOut() {
    final serverId = _activeServerId;
    if (serverId == null || _signingOut || _lastHandledServerId == serverId) {
      return;
    }
    _signingOut = true;
    unawaited(_signOut(serverId));
  }

  Future<void> _signOut(int serverId) async {
    try {
      await _ref.read(authFlowControllerProvider).signOut(serverId);
      _lastHandledServerId = serverId;
    } catch (error, stackTrace) {
      logger.e(
        'Failed to sign out after token revocation for server $serverId',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _signingOut = false;
    }
  }

  void dispose() {}
}
