import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/router/router.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';

part 'auth_state_handler.g.dart';

@Riverpod(keepAlive: true)
void authStateHandler(Ref ref) async {
  ref.listen(authControllerProvider, (previous, next) {
    if (previous == next || next.value == null) {
      return;
    }

    final router = ref.read(goRouterProvider);
    final connectionManager =
        ref.read(serverConnectionManagerProvider.notifier);

    switch (next.value) {
      case Initial():
        break;
      case Authenticated():
        connectionManager.reconnect();
        router.go(const HomeRouteData().location);
        break;
      case Unauthenticated():
        connectionManager.disconnectAndCleanup();
        router.go(const DicoveryRoute().location);
        break;
      case Failure():
        break;
      default:
        break;
    }
  });

  ref.read(authControllerProvider.notifier).initialize();
}
