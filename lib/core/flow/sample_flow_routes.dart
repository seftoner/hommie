import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'sample_flow_routes.g.dart';

// Sample onboarding flow route definitions for the flow builder demo

@TypedGoRoute<ChooseModeRoute>(path: '/choose')
class ChooseModeRoute extends GoRouteData with $ChooseModeRoute {
  const ChooseModeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChooseModePage();
}

@TypedGoRoute<DiscoverRoute>(path: '/discover')
class DiscoverRoute extends GoRouteData with $DiscoverRoute {
  final String? seed; // example query/param if needed

  const DiscoverRoute({this.seed});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DiscoverPage();
}

@TypedGoRoute<EnterManualRoute>(path: '/manual')
class EnterManualRoute extends GoRouteData with $EnterManualRoute {
  const EnterManualRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EnterManualPage();
}

@TypedGoRoute<SummaryRoute>(path: '/summary')
class SummaryRoute extends GoRouteData with $SummaryRoute {
  const SummaryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SummaryPage();
}

// Sample page implementations

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Connection Mode')),
      body: const Center(
        child: Text('Choose how to connect to your Home Assistant server'),
      ),
    );
  }
}

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover Servers')),
      body: const Center(child: Text('Discovering Home Assistant servers...')),
    );
  }
}

class EnterManualPage extends StatelessWidget {
  const EnterManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Server Address')),
      body: const Center(
        child: Text('Manually enter your Home Assistant server address'),
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: const Center(child: Text('Review your server connection settings')),
    );
  }
}
