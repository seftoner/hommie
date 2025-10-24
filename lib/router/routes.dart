import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/bootstrap/app_startup.dart';
import 'package:hommie/features/auth/presentation/screens/server_discovery_page.dart';
import 'package:hommie/features/automation/presentation/automations_page.dart';
import 'package:hommie/features/home/presentation/screens/home_page.dart';
import 'package:hommie/features/auth/presentation/screens/enter_address_page.dart';
import 'package:hommie/features/home/presentation/screens/app_scaffold_page.dart';
import 'package:hommie/features/servers/presentation/screens/servers_page.dart';
import 'package:hommie/features/servers/presentation/screens/add_edit_server_page.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
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
      routes: [TypedGoRoute<HomeRouteData>(path: '/home')],
    ),
    TypedStatefulShellBranch<AutomationsShellBranchData>(
      routes: [TypedGoRoute<AutomationsRouteData>(path: '/automations')],
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
    return AppScaffoldPage(navigationShell: navigationShell);
  }
}

class AutomationsShellBranchData extends StatefulShellBranchData {
  const AutomationsShellBranchData();
}

class AutomationsRouteData extends GoRouteData with $AutomationsRouteData {
  const AutomationsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AutomationsPage();
  }
}

@TypedGoRoute<SettingsRouteData>(
  path: '/settings',
  routes: [
    TypedGoRoute<HubRouteData>(path: 'hub'),
    TypedGoRoute<ServersRouteData>(
      path: 'servers',
      routes: [
        TypedGoRoute<AddServerRouteData>(path: 'add'),
        TypedGoRoute<EditServerRouteData>(path: 'edit'),
      ],
    ),
    TypedGoRoute<LogsRouteData>(path: 'logs'),
    TypedGoRoute<AboutRouteData>(path: 'about'),
    TypedGoRoute<SensorsRouteData>(path: 'sensors'),
  ],
)
class SettingsRouteData extends GoRouteData with $SettingsRouteData {
  const SettingsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

class LogsRouteData extends GoRouteData with $LogsRouteData {
  const LogsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LogsPage();
  }
}

class AboutRouteData extends GoRouteData with $AboutRouteData {
  const AboutRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AboutPage();
  }
}

class SensorsRouteData extends GoRouteData with $SensorsRouteData {
  const SensorsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SensorsPage();
  }
}

class HubRouteData extends GoRouteData with $HubRouteData {
  const HubRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HubPage();
  }
}

class ServersRouteData extends GoRouteData with $ServersRouteData {
  const ServersRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ServersPage();
  }
}

// ignore: provider_dependencies
class AddServerRouteData extends GoRouteData with $AddServerRouteData {
  const AddServerRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AddEditServerPage();
  }
}

// ignore: provider_dependencies
class EditServerRouteData extends GoRouteData with $EditServerRouteData {
  EditServerRouteData(this.$extra);

  final Server? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddEditServerPage(server: $extra);
  }
}

class HomeShellBranchData extends StatefulShellBranchData {
  const HomeShellBranchData();
}

class HomeRouteData extends GoRouteData with $HomeRouteData {
  const HomeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

// ignore: provider_dependencies
@TypedGoRoute<DiscoveryRoute>(path: '/discovery')
class DiscoveryRoute extends GoRouteData with $DiscoveryRoute {
  const DiscoveryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // Use flow-aware variant so the same route participates in linear auth flows
    // while remaining compatible when accessed directly.
    return const ServerDiscoveryPage();
  }
}

// ignore: provider_dependencies
@TypedGoRoute<EnterAddressRoute>(path: '/manualAddres')
class EnterAddressRoute extends GoRouteData with $EnterAddressRoute {
  const EnterAddressRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EnterAddressPage();
  }
}

@TypedGoRoute<StartupRoute>(path: '/startup')
class StartupRoute extends GoRouteData with $StartupRoute {
  const StartupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppStartup();
  }
}
