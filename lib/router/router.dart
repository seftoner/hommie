import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authStateNotifier = ValueNotifier<AuthState>(const AuthState.initial());
  ref
    ..onDispose(authStateNotifier.dispose)
    ..listen(
      authControllerProvider,
      (_, next) {
        authStateNotifier.value = next.value!;
      },
    );

  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: authStateNotifier,
    initialLocation: const StartupRoute().location,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    redirect: (context, state) {
      logger.d(
          "Try to redirect. Router listanable state: ${authStateNotifier.value}");

      final currentAuthState = authStateNotifier.value;
      final currentLocation = state.matchedLocation;

      switch (currentAuthState) {
        case Autenticated():
          if (currentLocation == const StartupRoute().location ||
              currentLocation == const EnterAddressRoute().location ||
              currentLocation == const DicoveryRoute().location) {
            return const HomeRouteData().location;
          }
          return null; // Allow navigation if already authenticated
        case Unauthicated():
          if (currentLocation != const DicoveryRoute().location &&
              currentLocation != const EnterAddressRoute().location) {
            return const DicoveryRoute().location;
          }
          return null; // Stay on Discovery or EnterAddress
        case Failure():
          if (currentLocation != const DicoveryRoute().location &&
              currentLocation != const EnterAddressRoute().location) {
            return const DicoveryRoute().location;
          }
          return null; // Stay on Discovery or EnterAddress
        case Initial():
          return null; // No redirection needed during initialization
        default:
          return null; // Handle any other undefined states gracefully
      }
    },
  );

  return router;
}
