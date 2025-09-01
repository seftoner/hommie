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
        GoRouteData.$route(path: '/home', factory: _$HomeRouteData._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/automations',
          factory: _$AutomationsRouteData._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) =>
      const MainShellRouteData();
}

mixin _$HomeRouteData on GoRouteData {
  static HomeRouteData _fromState(GoRouterState state) => const HomeRouteData();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AutomationsRouteData on GoRouteData {
  static AutomationsRouteData _fromState(GoRouterState state) =>
      const AutomationsRouteData();

  @override
  String get location => GoRouteData.$location('/automations');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRouteData => GoRouteData.$route(
  path: '/settings',
  factory: _$SettingsRouteData._fromState,
  routes: [
    GoRouteData.$route(path: 'hub', factory: _$HubRouteData._fromState),
    GoRouteData.$route(path: 'servers', factory: _$ServersRouteData._fromState),
    GoRouteData.$route(path: 'logs', factory: _$LogsRouteData._fromState),
    GoRouteData.$route(path: 'about', factory: _$AboutRouteData._fromState),
    GoRouteData.$route(path: 'sensors', factory: _$SensorsRouteData._fromState),
  ],
);

mixin _$SettingsRouteData on GoRouteData {
  static SettingsRouteData _fromState(GoRouterState state) =>
      const SettingsRouteData();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$HubRouteData on GoRouteData {
  static HubRouteData _fromState(GoRouterState state) => const HubRouteData();

  @override
  String get location => GoRouteData.$location('/settings/hub');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ServersRouteData on GoRouteData {
  static ServersRouteData _fromState(GoRouterState state) =>
      const ServersRouteData();

  @override
  String get location => GoRouteData.$location('/settings/servers');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$LogsRouteData on GoRouteData {
  static LogsRouteData _fromState(GoRouterState state) => const LogsRouteData();

  @override
  String get location => GoRouteData.$location('/settings/logs');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AboutRouteData on GoRouteData {
  static AboutRouteData _fromState(GoRouterState state) =>
      const AboutRouteData();

  @override
  String get location => GoRouteData.$location('/settings/about');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SensorsRouteData on GoRouteData {
  static SensorsRouteData _fromState(GoRouterState state) =>
      const SensorsRouteData();

  @override
  String get location => GoRouteData.$location('/settings/sensors');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dicoveryRoute =>
    GoRouteData.$route(path: '/discovery', factory: _$DicoveryRoute._fromState);

mixin _$DicoveryRoute on GoRouteData {
  static DicoveryRoute _fromState(GoRouterState state) => const DicoveryRoute();

  @override
  String get location => GoRouteData.$location('/discovery');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $enterAddressRoute => GoRouteData.$route(
  path: '/manualAddres',
  factory: _$EnterAddressRoute._fromState,
);

mixin _$EnterAddressRoute on GoRouteData {
  static EnterAddressRoute _fromState(GoRouterState state) =>
      const EnterAddressRoute();

  @override
  String get location => GoRouteData.$location('/manualAddres');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $startupRoute =>
    GoRouteData.$route(path: '/startup', factory: _$StartupRoute._fromState);

mixin _$StartupRoute on GoRouteData {
  static StartupRoute _fromState(GoRouterState state) => const StartupRoute();

  @override
  String get location => GoRouteData.$location('/startup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
