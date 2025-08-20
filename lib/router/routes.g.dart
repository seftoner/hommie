// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainShellRouteData,
      $settingsRouteData,
      $dicoveryRoute,
      $enterAddressRoute,
      $startupRoute,
    ];

RouteBase get $mainShellRouteData => StatefulShellRouteData.$route(
      factory: $MainShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/automations',
              factory: $AutomationsRouteDataExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) =>
      const MainShellRouteData();
}

extension $HomeRouteDataExtension on HomeRouteData {
  static HomeRouteData _fromState(GoRouterState state) => const HomeRouteData();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AutomationsRouteDataExtension on AutomationsRouteData {
  static AutomationsRouteData _fromState(GoRouterState state) =>
      const AutomationsRouteData();

  String get location => GoRouteData.$location(
        '/automations',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRouteData => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsRouteDataExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'hub',
          factory: $HubRouteDataExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'servers',
          factory: $ServersRouteDataExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'logs',
          factory: $LogsRouteDataExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'about',
          factory: $AboutRouteDataExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'sensors',
          factory: $SensorsRouteDataExtension._fromState,
        ),
      ],
    );

extension $SettingsRouteDataExtension on SettingsRouteData {
  static SettingsRouteData _fromState(GoRouterState state) =>
      const SettingsRouteData();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HubRouteDataExtension on HubRouteData {
  static HubRouteData _fromState(GoRouterState state) => const HubRouteData();

  String get location => GoRouteData.$location(
        '/settings/hub',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ServersRouteDataExtension on ServersRouteData {
  static ServersRouteData _fromState(GoRouterState state) =>
      const ServersRouteData();

  String get location => GoRouteData.$location(
        '/settings/servers',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LogsRouteDataExtension on LogsRouteData {
  static LogsRouteData _fromState(GoRouterState state) => const LogsRouteData();

  String get location => GoRouteData.$location(
        '/settings/logs',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AboutRouteDataExtension on AboutRouteData {
  static AboutRouteData _fromState(GoRouterState state) =>
      const AboutRouteData();

  String get location => GoRouteData.$location(
        '/settings/about',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SensorsRouteDataExtension on SensorsRouteData {
  static SensorsRouteData _fromState(GoRouterState state) =>
      const SensorsRouteData();

  String get location => GoRouteData.$location(
        '/settings/sensors',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dicoveryRoute => GoRouteData.$route(
      path: '/discovery',
      factory: $DicoveryRouteExtension._fromState,
    );

extension $DicoveryRouteExtension on DicoveryRoute {
  static DicoveryRoute _fromState(GoRouterState state) => const DicoveryRoute();

  String get location => GoRouteData.$location(
        '/discovery',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $enterAddressRoute => GoRouteData.$route(
      path: '/manualAddres',
      factory: $EnterAddressRouteExtension._fromState,
    );

extension $EnterAddressRouteExtension on EnterAddressRoute {
  static EnterAddressRoute _fromState(GoRouterState state) =>
      const EnterAddressRoute();

  String get location => GoRouteData.$location(
        '/manualAddres',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $startupRoute => GoRouteData.$route(
      path: '/startup',
      factory: $StartupRouteExtension._fromState,
    );

extension $StartupRouteExtension on StartupRoute {
  static StartupRoute _fromState(GoRouterState state) => const StartupRoute();

  String get location => GoRouteData.$location(
        '/startup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
