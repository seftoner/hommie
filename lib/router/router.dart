import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/features/auth/domain/entities/auth_state.dart';
import 'package:hommie/features/auth/application/auth_state_provider.dart';
import 'package:hommie/router/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final router = GoRouter(
    navigatorKey: rootKey,
    initialLocation: const StartupRoute().location,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
  );

  void refreshRouter<T>(_, AsyncValue<AuthState> next) {
    switch (next) {
      case AsyncLoading():
        router.go(const StartupRoute().location);
        break;
      case AsyncError():
        router.go(const StartupRoute().location);
        break;
      case AsyncData(value: final AuthState authState):
        switch (authState) {
          case Initial():
          case Authenticating():
            router.go(const StartupRoute().location);
            break;
          case Unauthenticated():
          case Revoked():
          case Failure():
            router.go(const OnboardingRoute().location);
            break;
          case Authenticated():
          case Refreshing():
            router.go(const HomeRouteData().location);
            break;
        }
    }
  }

  ref.listen<AsyncValue<AuthState>>(authStateProvider, refreshRouter);

  return router;
}
