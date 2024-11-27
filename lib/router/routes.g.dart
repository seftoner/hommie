// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainShellRouteData,
      $aboutRouteData,
      $sensorsRouteData,
      $hubRouteData,
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
              path: '/settings',
              factory: $SettingsRouteDataExtension._fromState,
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

RouteBase get $aboutRouteData => GoRouteData.$route(
      path: '/settings/about',
      factory: $AboutRouteDataExtension._fromState,
    );

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

RouteBase get $sensorsRouteData => GoRouteData.$route(
      path: '/settings/sensors',
      factory: $SensorsRouteDataExtension._fromState,
    );

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

RouteBase get $hubRouteData => GoRouteData.$route(
      path: '/settings/hub',
      factory: $HubRouteDataExtension._fromState,
    );

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
