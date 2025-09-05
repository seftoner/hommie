// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_flow_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $chooseModeRoute,
  $discoverRoute,
  $enterManualRoute,
  $summaryRoute,
];

RouteBase get $chooseModeRoute =>
    GoRouteData.$route(path: '/choose', factory: $ChooseModeRoute._fromState);

mixin $ChooseModeRoute on GoRouteData {
  static ChooseModeRoute _fromState(GoRouterState state) =>
      const ChooseModeRoute();

  @override
  String get location => GoRouteData.$location('/choose');

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

RouteBase get $discoverRoute =>
    GoRouteData.$route(path: '/discover', factory: $DiscoverRoute._fromState);

mixin $DiscoverRoute on GoRouteData {
  static DiscoverRoute _fromState(GoRouterState state) =>
      DiscoverRoute(seed: state.uri.queryParameters['seed']);

  DiscoverRoute get _self => this as DiscoverRoute;

  @override
  String get location => GoRouteData.$location(
    '/discover',
    queryParams: {if (_self.seed != null) 'seed': _self.seed},
  );

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

RouteBase get $enterManualRoute =>
    GoRouteData.$route(path: '/manual', factory: $EnterManualRoute._fromState);

mixin $EnterManualRoute on GoRouteData {
  static EnterManualRoute _fromState(GoRouterState state) =>
      const EnterManualRoute();

  @override
  String get location => GoRouteData.$location('/manual');

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

RouteBase get $summaryRoute =>
    GoRouteData.$route(path: '/summary', factory: $SummaryRoute._fromState);

mixin $SummaryRoute on GoRouteData {
  static SummaryRoute _fromState(GoRouterState state) => const SummaryRoute();

  @override
  String get location => GoRouteData.$location('/summary');

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
