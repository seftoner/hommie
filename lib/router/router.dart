import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/features/auth/auth_provider.dart';
import 'package:hommie/router/routes.dart';

final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

final router = GoRouter(
  navigatorKey: routerKey,
  refreshListenable: authStateListenable,
  initialLocation: const SplashRoute().location,
  debugLogDiagnostics: true,
  routes: $appRoutes,
  redirect: (context, state) {
    final isLoggedIn = authStateListenable.value;
    final isGotoLoggin = state.uri.path == const LoginRoute().location;

    if (!isLoggedIn && !isGotoLoggin) return const LoginRoute().location;

    if (isLoggedIn && isGotoLoggin) return const HomeRoute().location;

    return null;
  },
);
