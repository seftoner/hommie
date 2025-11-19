import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow_builder/flow_blueprint_v2.dart';
import 'package:hommie/core/flow_builder/flow_controller_v2.dart';
import 'package:hommie/features/auth/application/auth_flow_controller.dart';
import 'package:hommie/router/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

/// Example of improved flow definition with better DX
/// 
/// Key improvements:
/// 1. No FlowRoutePass needed - routes are resolved dynamically
/// 2. Clear presentation styles
/// 3. Shell paths for route scoping
/// 4. Loading states for actions
/// 5. Inline page support to avoid route duplication

const _serverAddressKey = 'serverAddress';

/// Onboarding flow - first time user setup
/// Uses card presentation for a focused, non-intrusive experience
@Dependencies([AuthFlowController])
FlowBlueprintV2 onboardingServerFlowV2() {
  return FlowBlueprintV2(
    id: 'onboarding-server',
    description: 'Initial authentication experience for first time app launch.',
    presentation: FlowPresentationStyle.card,
    shellPath: '/onboarding',
    steps: [
      FlowRouteStepV2(
        id: 'discovery',
        label: 'Discover Server',
        routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
      ),
      FlowRouteStepV2(
        id: 'manual-entry',
        label: 'Enter Address',
        routeBuilder: (ctx) => const OnboardingManualEntryRouteData(),
      ),
      FlowActionStepV2(
        id: 'login',
        label: 'Authenticating',
        showLoading: true,
        loadingMessage: 'Connecting to your Home Assistant...',
        action: (ctx) async {
          final address = ctx.expectValue<String>(_serverAddressKey);
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
    onFinish: (ctx) async {
      final context = ctx.navigationContext;
      if (context != null) {
        const HomeRouteData().go(context);
      }
    },
  );
}

/// Add server flow - adding additional server from settings
/// Uses fullscreen presentation to integrate with settings navigation
@Dependencies([AuthFlowController])
FlowBlueprintV2 addServerFlowV2() {
  return FlowBlueprintV2(
    id: 'add-server',
    description: 'Flow for adding an extra Home Assistant server.',
    presentation: FlowPresentationStyle.fullscreen,
    shellPath: '/settings/servers/add',
    steps: [
      FlowRouteStepV2(
        id: 'discovery',
        label: 'Discover Server',
        routeBuilder: (ctx) => const AddServerDiscoveryRouteData(),
      ),
      FlowRouteStepV2(
        id: 'manual-entry',
        label: 'Enter Address',
        routeBuilder: (ctx) => const AddServerManualEntryRouteData(),
      ),
      FlowActionStepV2(
        id: 'login',
        label: 'Authenticating',
        showLoading: true,
        loadingMessage: 'Connecting to your Home Assistant...',
        action: (ctx) async {
          final address = ctx.expectValue<String>(_serverAddressKey);
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
    onFinish: (ctx) async {
      final context = ctx.navigationContext;
      if (context != null) {
        const SettingsRouteData().go(context);
        const ServersRouteData().go(context);
      }
    },
  );
}

/// Alternative: Inline page definitions to avoid route duplication
/// This approach uses pageBuilder instead of routeBuilder
@Dependencies([AuthFlowController])
FlowBlueprintV2 onboardingServerFlowInlineV2() {
  return FlowBlueprintV2(
    id: 'onboarding-server-inline',
    description: 'Onboarding with inline page definitions.',
    presentation: FlowPresentationStyle.card,
    steps: [
      FlowRouteStepV2(
        id: 'discovery',
        label: 'Discover Server',
        // Using pageBuilder allows us to avoid creating separate route classes
        // The FlowShell will handle rendering this directly
        pageBuilder: (context, flowContext) {
          // This would render the ServerDiscoveryPage directly
          // without needing OnboardingDiscoveryRouteData
          return const ServerDiscoveryPage();
        },
      ),
      FlowRouteStepV2(
        id: 'manual-entry',
        label: 'Enter Address',
        pageBuilder: (context, flowContext) {
          return const EnterAddressPage();
        },
      ),
      FlowActionStepV2(
        id: 'login',
        label: 'Authenticating',
        showLoading: true,
        loadingMessage: 'Connecting to your Home Assistant...',
        action: (ctx) async {
          final address = ctx.expectValue<String>(_serverAddressKey);
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
    onFinish: (ctx) async {
      final context = ctx.navigationContext;
      if (context != null) {
        const HomeRouteData().go(context);
      }
    },
  );
}

/// Example with branching - showing different paths based on conditions
@Dependencies([AuthFlowController])
FlowBlueprintV2 smartOnboardingFlowV2() {
  return FlowBlueprintV2(
    id: 'smart-onboarding',
    description: 'Smart onboarding that adapts to user choice.',
    presentation: FlowPresentationStyle.card,
    steps: [
      // Start with a choice page
      FlowRouteStepV2(
        id: 'choose-method',
        label: 'Choose Setup Method',
        routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
      ),
      // Branch based on user choice
      FlowBranchStepV2(
        id: 'setup-branch',
        label: 'Setup',
        selector: (ctx) {
          final method = ctx.readValue<String>('setupMethod');
          return method ?? 'discovery'; // default to discovery
        },
        branches: {
          'discovery': [
            FlowRouteStepV2(
              id: 'discovery',
              label: 'Discover Server',
              routeBuilder: (ctx) => const OnboardingDiscoveryRouteData(),
            ),
          ],
          'manual': [
            FlowRouteStepV2(
              id: 'manual-entry',
              label: 'Enter Address',
              routeBuilder: (ctx) => const OnboardingManualEntryRouteData(),
            ),
          ],
        },
      ),
      FlowActionStepV2(
        id: 'login',
        label: 'Authenticating',
        showLoading: true,
        loadingMessage: 'Connecting to your Home Assistant...',
        action: (ctx) async {
          final address = ctx.expectValue<String>(_serverAddressKey);
          await ctx.read(authFlowControllerProvider.notifier).login(address);
        },
      ),
    ],
    onFinish: (ctx) async {
      final context = ctx.navigationContext;
      if (context != null) {
        const HomeRouteData().go(context);
      }
    },
  );
}

/// Start onboarding flow with improved API
@Dependencies([AuthFlowController])
Future<void> startOnboardingServerFlowV2(WidgetRef ref) async {
  await ref
      .read(flowControllerV2Provider.notifier)
      .start(onboardingServerFlowV2());
}

/// Start add server flow with improved API
@Dependencies([AuthFlowController])
Future<void> startAddServerFlowV2(WidgetRef ref) async {
  await ref
      .read(flowControllerV2Provider.notifier)
      .start(addServerFlowV2());
}

/// Handle server selection - works with both flow contexts
@Dependencies([AuthFlowController])
Future<void> handleServerSelectionV2(WidgetRef ref, String address) async {
  final flowState = ref.read(flowControllerV2Provider);
  final flowController = ref.read(flowControllerV2Provider.notifier);

  if (flowState is FlowActiveV2) {
    // We're in a flow - complete the current step with the address
    await flowController.completeStep(output: {_serverAddressKey: address});
  } else {
    // Not in a flow - just login directly
    await ref.read(authFlowControllerProvider.notifier).login(address);
  }
}

/// Navigate to manual entry from discovery page
/// Works within the flow context
@Dependencies([AuthFlowController])
Future<void> navigateToManualEntryV2(WidgetRef ref) async {
  final flowState = ref.read(flowControllerV2Provider);

  if (flowState is FlowActiveV2) {
    // We're in a flow - jump to manual-entry step
    await ref.read(flowControllerV2Provider.notifier).jumpTo('manual-entry');
  } else {
    // Not in a flow - use regular navigation
    // This would need the context, so it's better to handle this in the UI layer
    throw StateError('Not in a flow - use regular navigation');
  }
}
