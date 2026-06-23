import 'dart:async';

import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_revocation_handler.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [ActiveServerSession, serverLifecycleController],
)
void authRevocationHandler(Ref ref) {
  final handledServerIds = <int>{};

  Future<void> signOutRevokedServer(int serverId) async {
    try {
      await ref.read(serverLifecycleControllerProvider).signOutServer(serverId);
    } catch (error, stackTrace) {
      handledServerIds.remove(serverId);
      logger.w(
        'Failed to handle auth revocation for server $serverId',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  ref.listen(activeServerSessionProvider, (_, next) {
    if (next is AuthRevokedServerSession) {
      final serverId = next.activeServer.id;
      if (serverId != null && handledServerIds.add(serverId)) {
        unawaited(signOutRevokedServer(serverId));
      }
      return;
    }

    if (next is OnlineServerSession) {
      final serverId = next.activeServer.id;
      if (serverId != null) {
        handledServerIds.remove(serverId);
      }
    }
  }, fireImmediately: true);
}
