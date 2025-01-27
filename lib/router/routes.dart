import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/bootstrap/app_startup.dart';
import 'package:hommie/features/auth/presentation/screens/server_discovery_page.dart';
import 'package:hommie/features/home/presentation/screens/home_page.dart';
import 'package:hommie/features/auth/presentation/screens/enter_address_page.dart';
import 'package:hommie/features/home/presentation/screens/app_scaffold_page.dart';
import 'package:hommie/features/settings/presentation/screens/about_page.dart';
import 'package:hommie/features/settings/presentation/screens/hub_page.dart';
import 'package:hommie/features/settings/presentation/screens/logs_page.dart';
import 'package:hommie/features/settings/presentation/screens/sensors_page.dart';
import 'package:hommie/features/settings/presentation/screens/settings_page.dart';

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
            TypedGoRoute<HubRouteData>(path: 'hub'),
            TypedGoRoute<LogsRouteData>(path: 'logs'),
            TypedGoRoute<AboutRouteData>(path: 'about'),
            TypedGoRoute<SensorsRouteData>(path: 'sensors'),
          ],
        ),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppScaffoldPage(
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

class LogsRouteData extends GoRouteData {
  const LogsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LogsPage();
  }
}

class AboutRouteData extends GoRouteData {
  const AboutRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AboutPage();
  }
}

class SensorsRouteData extends GoRouteData {
  const SensorsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SensorsPage();
  }
}

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

@TypedGoRoute<DicoveryRoute>(path: '/discovery')
class DicoveryRoute extends GoRouteData {
  const DicoveryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ServerDiscoveryPage();
  }
}

@TypedGoRoute<EnterAddressRoute>(path: '/manualAddres')
class EnterAddressRoute extends GoRouteData {
  const EnterAddressRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EnterAddressPage();
  }
}

@TypedGoRoute<StartupRoute>(path: '/startup')
class StartupRoute extends GoRouteData {
  const StartupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppStartup();
  }
}
