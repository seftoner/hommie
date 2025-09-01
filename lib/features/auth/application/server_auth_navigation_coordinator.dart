import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/server_auth_controller.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/router/routes.dart';
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
    ref.listen(activeServerProvider, (_, next) {
      next.whenData((server) {
        if (server != null) {
          _handleServerSelection(server.id!);
        } else {
          // No active server - go to discovery page
          ref.read(goRouterProvider).go(const DicoveryRoute().location);
        }
      });
    });

    // Listen to global connection state for auth failures
    ref.listen(serverConnectionStateProvider, (_, next) {
      if (next == HAServerConnectionState.authFailure) {
        _handleAuthFailure();
      }
    });
  }

  Future<void> _handleServerSelection(int serverId) async {
    // Create a new auth controller for this server
    final authController = ref.read(serverAuthControllerProvider.notifier);

    final goRouter = ref.read(goRouterProvider);

    // Listen to auth state changes
    ref.listen(serverAuthControllerProvider, (previous, next) {
      next.whenData((authState) {
        switch (authState) {
          case Authenticated():
            goRouter.go(const HomeRouteData().location);
            break;
          case Unauthenticated():
            // Go to discovery page when unauthenticated
            goRouter.go(const DicoveryRoute().location);
            break;
          default:
            break;
        }
      });
    });

    // Initialize auth state
    await authController.initialize(serverId);
  }

  /// Handles auth failures by signing out the active server
  Future<void> _handleAuthFailure() async {
    final activeServer = await ref.read(activeServerProvider.future);
    if (activeServer != null) {
      await ref
          .read(serverAuthControllerProvider.notifier)
          .signOut(activeServer.id!);
    }
  }
}
