import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/features/home/presentation/screens/home_page.dart';
import 'package:hommie/features/auth/presentation/screens/login_page.dart';
import 'package:hommie/features/home/presentation/screens/root_page.dart';
import 'package:hommie/features/settings/presentation/screens/about_page.dart';
import 'package:hommie/features/settings/presentation/screens/hub_page.dart';
import 'package:hommie/features/settings/presentation/screens/settings_page.dart';
import 'package:hommie/ui/screens/startup_page.dart';

part 'routes.g.dart';

final rootKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

///Make this StatefulShellRoute base on this sample
///https://github.com/flutter/packages/blob/main/packages/go_router_builder/example/lib/stateful_shell_route_initial_location_example.dart
@TypedStatefulShellRoute<MainShellRouteData>(
  branches: [
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: [
        TypedGoRoute<HomeRouteData>(
          path: '/home',
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsShellBranchData>(
      routes: [
        TypedGoRoute<SettingsRouteData>(
          path: '/settings',
          routes: [
            // TypedGoRoute<AboutRouteData>(path: 'about'),
          ],
        ),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();
  // static final GlobalKey<NavigatorState> $navigatorKey = rootKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainPage(
      navigationShell: navigationShell,
    );
  }
}

class SettingsShellBranchData extends StatefulShellBranchData {
  const SettingsShellBranchData();
}

class SettingsRouteData extends GoRouteData {
  const SettingsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@TypedGoRoute<AboutRouteData>(path: '/settings/about')
class AboutRouteData extends GoRouteData {
  const AboutRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AboutPage();
  }
}

@TypedGoRoute<HubRouteData>(path: '/settings/hub')
class HubRouteData extends GoRouteData {
  const HubRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HubPage();
  }
}

class HomeShellBranchData extends StatefulShellBranchData {
  const HomeShellBranchData();
}

class HomeRouteData extends GoRouteData {
  const HomeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<StartupRoute>(path: '/startup')
class StartupRoute extends GoRouteData {
  const StartupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StartupPage();
  }
}
