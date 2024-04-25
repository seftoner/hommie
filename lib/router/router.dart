import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/features/auth/application/auth_controller.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
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
      switch (currentAuthState) {
        case Autenticated()
            when (state.matchedLocation == const StartupRoute().location) ||
                (state.matchedLocation == const LoginRoute().location):
          return const HomeRouteData().location;
        case Unauthicated():
          return const LoginRoute().location;

        /// FIXME: Make it better. A lot of failures might occured, Need to handle
        /// propperly each of them. For example: refresh token is invalid, no connections, etc
        case Failure():
          return const LoginRoute().location;
        case Initial():
          return null;
        default:
          return null;
      }
    },
  );

  return router;
}
