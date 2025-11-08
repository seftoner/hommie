import 'dart:async';

import 'package:hommie/features/auth/application/auth_state_machine.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_lifecycle_coordinator.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [
    ActiveServer,
    AuthStateMachine,
    ServerConnectionState,
    goRouter,
  ],
)
class AuthLifecycleCoordinator extends _$AuthLifecycleCoordinator {
  @override
  Future<void> build() async {
    ref.listen<AsyncValue<Server?>>(activeServerProvider, (previous, next) {
      final nextServerId = next.asData?.value?.id;
      if (nextServerId != null) {
        Future.microtask(
          () => ref
              .read(authStateMachineProvider(nextServerId).notifier)
              .hydrate(),
        );
      }
    });

    ref.listen<HAServerConnectionState>(serverConnectionStateProvider, (
      _,
      next,
    ) {
      if (next == HAServerConnectionState.authFailure) {
        _handleAuthRevocation();
      }
    });
  }

  Future<void> _handleAuthRevocation() async {
    final activeServer = await ref.read(activeServerProvider.future);
    final serverId = activeServer?.id;
    if (serverId == null) {
      return;
    }

    final authMachine = ref.read(authStateMachineProvider(serverId).notifier);
    authMachine.markRevoked(const AuthFailure.invalidToken());

    ref.read(goRouterProvider).go(const DiscoveryRoute().location);
  }
}
