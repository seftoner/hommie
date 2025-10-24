import 'dart:async';

import 'package:hommie/features/auth/application/server_auth_controller.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_auth_navigation_coordinator.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [ActiveServer, ServerConnectionState, ServerAuthController],
)
class ServerAuthNavigationCoordinator
    extends _$ServerAuthNavigationCoordinator {
  @override
  Future<void> build() async {
    ref.listen<AsyncValue<Server?>>(activeServerProvider, (previous, next) {
      final previousId = previous?.asData?.value?.id;
      final nextId = next.asData?.value?.id;

      if (nextId == null || nextId == previousId) {
        return;
      }

      // Kick off auth initialization asynchronously to avoid blocking the
      // listener.
      Future.microtask(
        () =>
            ref.read(serverAuthControllerProvider.notifier).initialize(nextId),
      );
    });

    // Listen to global connection state for auth failures and trigger a
    // cascading sign-out when required.
    ref.listen<HAServerConnectionState>(serverConnectionStateProvider, (
      _,
      next,
    ) {
      if (next == HAServerConnectionState.authFailure) {
        _handleAuthFailure();
      }
    });
  }

  /// Handles auth failures by signing out the active server
  Future<void> _handleAuthFailure() async {
    final activeServer = await ref.read(activeServerProvider.future);
    final serverId = activeServer?.id;
    if (serverId != null) {
      await ref.read(serverAuthControllerProvider.notifier).signOut(serverId);
    }
  }
}
