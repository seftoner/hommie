import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/server_auth_controller.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_handler.g.dart';

@Riverpod(keepAlive: true, dependencies: [ActiveServer, ServerAuthController])
class AppStateHandler extends _$AppStateHandler {
  @override
  Future<void> build() async {
    ref.listen(activeServerProvider, (_, next) {
      next.whenData((server) {
        if (server != null) {
          _initializeServer(server.id!);
        } else {
          ref.read(goRouterProvider).go(const DicoveryRoute().location);
        }
      });
    });
  }

  Future<void> _initializeServer(int serverId) async {
    // Create a new auth controller for this server
    final authController =
        ref.read(serverAuthControllerProvider(serverId).notifier);

    // Listen to auth state changes
    ref.listen(
      serverAuthControllerProvider(serverId),
      (previous, next) {
        next.whenData((authState) {
          switch (authState) {
            case Authenticated():
              ref
                  .read(serverConnectionManagerProvider.notifier)
                  .reconnect(serverId);
              ref.read(goRouterProvider).go(const HomeRouteData().location);
              break;
            case Unauthenticated():
              ref.read(goRouterProvider).go(const DicoveryRoute().location);
              break;
            default:
              break;
          }
        });
      },
    );

    // Initialize auth state
    await authController.initialize(serverId);
  }
}
