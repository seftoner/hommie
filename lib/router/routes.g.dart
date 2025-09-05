// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $mainShellRouteData,
  $settingsRouteData,
  $discoveryRoute,
  $enterAddressRoute,
  $startupRoute,
];

RouteBase get $mainShellRouteData => StatefulShellRouteData.$route(
  factory: $MainShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/home', factory: $HomeRouteData._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/automations',
          factory: $AutomationsRouteData._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) =>
      const MainShellRouteData();
}

mixin $HomeRouteData on GoRouteData {
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

mixin $AutomationsRouteData on GoRouteData {
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
  factory: $SettingsRouteData._fromState,
  routes: [
    GoRouteData.$route(path: 'hub', factory: $HubRouteData._fromState),
    GoRouteData.$route(
      path: 'servers',
      factory: $ServersRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'add',
          factory: $AddServerRouteData._fromState,
        ),
        GoRouteData.$route(
          path: 'edit',
          factory: $EditServerRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: 'logs', factory: $LogsRouteData._fromState),
    GoRouteData.$route(path: 'about', factory: $AboutRouteData._fromState),
    GoRouteData.$route(path: 'sensors', factory: $SensorsRouteData._fromState),
  ],
);

mixin $SettingsRouteData on GoRouteData {
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

mixin $HubRouteData on GoRouteData {
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

mixin $ServersRouteData on GoRouteData {
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

mixin $AddServerRouteData on GoRouteData {
  static AddServerRouteData _fromState(GoRouterState state) =>
      const AddServerRouteData();

  @override
  String get location => GoRouteData.$location('/settings/servers/add');

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

mixin $EditServerRouteData on GoRouteData {
  static EditServerRouteData _fromState(GoRouterState state) =>
      EditServerRouteData(state.extra as Server?);

  EditServerRouteData get _self => this as EditServerRouteData;

  @override
  String get location => GoRouteData.$location('/settings/servers/edit');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $LogsRouteData on GoRouteData {
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

mixin $AboutRouteData on GoRouteData {
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

mixin $SensorsRouteData on GoRouteData {
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

RouteBase get $discoveryRoute =>
    GoRouteData.$route(path: '/discovery', factory: $DiscoveryRoute._fromState);

mixin $DiscoveryRoute on GoRouteData {
  static DiscoveryRoute _fromState(GoRouterState state) =>
      const DiscoveryRoute();

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
  factory: $EnterAddressRoute._fromState,
);

mixin $EnterAddressRoute on GoRouteData {
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
    GoRouteData.$route(path: '/startup', factory: $StartupRoute._fromState);

mixin $StartupRoute on GoRouteData {
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
