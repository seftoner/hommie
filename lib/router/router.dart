import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/features/auth/auth_provider.dart';
import 'package:hommie/router/routes.dart';

// @riverpod
// GoRouter router(RouterRef ref) {
final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
//   final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
//   ref
//     ..onDispose(isAuth.dispose) // don't forget to clean after yourselves (:
//     // update the listenable, when some provider value changes
//     // here, we are just interested in wheter the user's logged in
//     ..listen(
//       authControllerProvider.select((value) =>
//           value.whenData((value) => value == AuthState.authenticated())),
//       (_, next) {
//         isAuth.value = next;
//       },
//     );

final router = GoRouter(
  navigatorKey: routerKey,
  refreshListenable: authStateListenable,
  initialLocation: const SplashRoute().location,
  debugLogDiagnostics: true,
  routes: $appRoutes,
  redirect: (context, state) {
    // if (isAuth.value.unwrapPrevious().hasError)
    //   return const LoginRoute().location;
    // if (isAuth.value.isLoading || !isAuth.value.hasValue)
    //   return const SplashRoute().location;

    final loggedIn = authStateListenable.value;

    final isSplash = state.uri.path == const SplashRoute().location;
    if (isSplash)
      return loggedIn
          ? const HomeRoute().location
          : const LoginRoute().location;

    final isLoggingIn = state.uri.path == const LoginRoute().location;
    if (isLoggingIn) return loggedIn ? const HomeRoute().location : null;

    return loggedIn ? null : const SplashRoute().location;
  },
);
//   ref.onDispose(router.dispose); // always clean up after yourselves (:

//   return router;
// }
