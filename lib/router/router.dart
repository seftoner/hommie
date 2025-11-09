import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_guards/go_router_guards.dart';
import 'package:hommie/app/boot/boot_status.dart';
import 'package:hommie/app/boot/boot_status_provider.dart';
// import 'package:hommie/features/auth/application/auth_lifecycle_coordinator.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/active_auth_state_provider.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/router/guards/auth_guard.dart';
import 'package:hommie/router/guards/boot_ready_guard.dart';
import 'package:hommie/router/guards/safe_guard_wrapper.dart';
import 'package:hommie/router/guards/server_configured_guard.dart';
import 'package:hommie/router/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [BootStatusController, ActiveServer, activeAuthState],
)
GoRouter goRouter(Ref ref) {
  final router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: const StartupRoute().location,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    // Wrap guards in safeRedirect to prevent RouterNotMountedException during cold start.
    // The go_router_guards package calls GoRouter.of(context) in executeWithResolver
    // before the router widget is mounted. safeRedirect catches the FlutterError
    // and returns null (allowing navigation) until the router is ready.
    // After mounting, router.refresh() triggers guards to re-evaluate.
    redirect: safeRedirect(
      ConditionalGuard(
        guard: guardAll([
          BootReadyGuard(ref),
          ServerConfiguredGuard(ref),
          AuthGuard(ref),
        ]),
        excludedPaths: [
          // const StartupRoute().location,
          const DiscoveryRoute().location,
          const EnterAddressRoute().location,
        ],
      ).toRedirect(),
    ),
  );

  var disposed = false;

  void refreshRouter(_, __) {
    if (disposed) {
      return;
    }

    router.refresh();
  }

  ref
    ..onDispose(() {
      disposed = true;
      router.dispose();
    })
    ..listen<AsyncValue<BootStatus>>(
      bootStatusControllerProvider,
      refreshRouter,
    )
    ..listen<AsyncValue<Server?>>(activeServerProvider, refreshRouter)
    ..listen<AsyncValue<AuthState>>(activeAuthStateProvider, refreshRouter);

  return router;
}
