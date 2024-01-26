import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/state/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(isAuth.dispose) // don't forget to clean after yourselves (:
    // update the listenable, when some provider value changes
    // here, we are just interested in wheter the user's logged in
    ..listen(
      authControllerProvider
          .select((value) => value.whenData((value) => value.isAuth)),
      (_, next) {
        isAuth.value = next;
      },
    );

  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: isAuth,
    initialLocation: const SplashRoute().location,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    redirect: (context, state) {
      if (isAuth.value.unwrapPrevious().hasError)
        return const LoginRoute().location;
      if (isAuth.value.isLoading || !isAuth.value.hasValue)
        return const SplashRoute().location;

      final auth = isAuth.value.requireValue;

      final isSplash = state.uri.path == const SplashRoute().location;
      if (isSplash)
        return auth ? const HomeRoute().location : const LoginRoute().location;

      final isLoggingIn = state.uri.path == const LoginRoute().location;
      if (isLoggingIn) return auth ? const HomeRoute().location : null;

      return auth ? null : const SplashRoute().location;
    },
  );
  ref.onDispose(router.dispose); // always clean up after yourselves (:

  return router;
}
