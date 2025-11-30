import 'dart:async';

import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/providers/connection_state_provider.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_session_coordinator.g.dart';

/// Coordinates everything related to a server "session":
/// - eagerly opens a websocket connection after the user authenticates
/// - watches for auth revocations from credential or transport layers and
///   triggers the logout flow so persisted data gets wiped
@Riverpod(
  keepAlive: true,
  dependencies: [serverConnectionManager, authController],
)
void serverSessionCoordinator(Ref ref) {
  final handler = _ServerSessionHandler(ref);
  ref.onDispose(handler.dispose);

  ref.listen(activeServerProvider, (_, next) {
    switch (next) {
      case AsyncData(:final value):
        handler.updateActiveServer(value);
      case AsyncError():
        handler.updateActiveServer(null);
      case AsyncLoading():
        break;
    }
  });

  ref.listen(authStateProvider, (_, next) {
    switch (next) {
      case AsyncData(:final value):
        handler.handleAuthState(value);
      case AsyncError():
      case AsyncLoading():
        break;
    }
  });

  ref.listen(serverConnectionStateProvider, (_, next) {
    handler.handleConnectionState(next);
  });
}

@Dependencies([authController])
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
      await _ref.read(authControllerProvider).signOut(serverId);
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
