import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/core/utils/logger.dart';
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
      logger.t("Trying to redirect to: ${state.fullPath}");

      final authState = authStateNotifier.value;
      final currentLocation = state.matchedLocation;

      if (_isUnauthenticated(authState) && !_isLoginFlow(currentLocation)) {
        return const DicoveryRoute().location;
      }

      if (_isAuthenticated(authState) &&
          _isInSplashOrLoginFlow(currentLocation)) {
        return const HomeRouteData().location;
      }
      return null;
    },
  );

  return router;
}

bool _isUnauthenticated(AuthState state) =>
    state is Unauthenticated || state is Failure;

bool _isAuthenticated(AuthState state) => state is Authenticated;

bool _isLoginFlow(String currentLocation) =>
    currentLocation == const DicoveryRoute().location ||
    currentLocation == const EnterAddressRoute().location;

bool _isInSplashOrLoginFlow(String currentLocation) =>
    currentLocation == const StartupRoute().location ||
    currentLocation == const DicoveryRoute().location ||
    currentLocation == const EnterAddressRoute().location;
