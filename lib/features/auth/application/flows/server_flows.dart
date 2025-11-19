import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow_builder/flow_blueprint.dart';
import 'package:hommie/core/flow_builder/flow_controller.dart';
import 'package:hommie/core/flow_builder/flow_navigation.dart';
import 'package:hommie/features/auth/application/auth_flow_controller.dart';
import 'package:hommie/router/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

const _serverAddressKey = 'serverAddress';
const _routePassKey = '__flowRoutePass';

final FlowRoutePass _onboardingRoutePass = FlowRoutePass(
  discoveryRoute: (_) => const OnboardingDiscoveryRouteData(),
  manualEntryRoute: (_) => const OnboardingManualEntryRouteData(),
);

final FlowRoutePass _addServerRoutePass = FlowRoutePass(
  discoveryRoute: (_) => const AddServerDiscoveryRouteData(),
  manualEntryRoute: (_) => const AddServerManualEntryRouteData(),
);

@Dependencies([AuthFlowController])
FlowBlueprint onboardingServerFlow(FlowNavigator navigator) {
  return FlowBlueprint(
    id: 'onboarding-server',
    description: 'Initial authentication experience for first time app launch.',
    steps: [
      const FlowRouteStep(
        id: 'discover-or-enter',
        routeBuilder: _discoverRoute,
      ),
      FlowActionStep(
        id: 'login',
        action: (ctx) async {
          final address = ctx.expectValue<String>(_serverAddressKey);
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
    onFinish: (ctx) async {
      final context = navigator.context ?? ctx.navigationContext;
      if (context != null) {
        const HomeRouteData().go(context);
      }
    },
  );
}

@Dependencies([AuthFlowController])
FlowBlueprint addServerFlow(FlowNavigator navigator) {
  return FlowBlueprint(
    id: 'add-server',
    description: 'Flow for adding an extra Home Assistant server.',
    steps: [
      const FlowRouteStep(
        id: 'discover-or-enter',
        routeBuilder: _discoverRoute,
      ),
      FlowActionStep(
        id: 'login',
        action: (ctx) async {
          final address = ctx.expectValue<String>(_serverAddressKey);
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
    onFinish: (ctx) async {
      final context = navigator.context ?? ctx.navigationContext;
      if (context != null) {
        const SettingsRouteData().go(context);
        const ServersRouteData().go(context);
      }
    },
  );
}

@Dependencies([AuthFlowController])
Future<void> startOnboardingServerFlow(WidgetRef ref) async {
  final navigator = ref.read(flowNavigatorProvider);
  await ref
      .read(flowControllerProvider.notifier)
      .start(
        onboardingServerFlow(navigator),
        initialData: {_routePassKey: _onboardingRoutePass},
      );
}

@Dependencies([AuthFlowController])
Future<void> startAddServerFlow(WidgetRef ref) async {
  final navigator = ref.read(flowNavigatorProvider);
  await ref
      .read(flowControllerProvider.notifier)
      .start(
        addServerFlow(navigator),
        initialData: {_routePassKey: _addServerRoutePass},
      );
}

@Dependencies([AuthFlowController])
Future<void> handleServerSelection(WidgetRef ref, String address) async {
  final flowState = ref.read(flowControllerProvider);
  final flowController = ref.read(flowControllerProvider.notifier);

  if (flowState is FlowActive) {
    await flowController.completeStep(output: {_serverAddressKey: address});
  } else {
    await ref.read(authFlowControllerProvider.notifier).login(address);
  }
}

FlowRoutePass _requirePass(FlowContext context) =>
    context.expectValue<FlowRoutePass>(_routePassKey);

GoRouteData _discoverRoute(FlowContext context) =>
    _requirePass(context).discoveryRoute(context);

GoRouteData manualEntryRouteForContext(FlowContext context) =>
    _requirePass(context).manualEntryRoute(context);

GoRouteData manualEntryRouteForState(FlowStatus status) {
  if (status is FlowActive) {
    final context = status.snapshot.context;
    final pass = context.readValue<FlowRoutePass>(_routePassKey);
    if (pass != null) {
      return pass.manualEntryRoute(context);
    }
  }
  return const EnterAddressRoute();
}
