import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow/flow_definition.dart';
import 'package:hommie/core/flow/flow_providers.dart';
import 'package:hommie/core/flow/sample_flow_routes.dart';
import 'package:hommie/router/routes.dart';

/// Example demonstrating how to use the flow builder with existing routes
///
/// This example shows how to create an onboarding flow using the
/// existing routes in the Hommie app.

class FlowExample {
  /// Sample flow definition for server onboarding
  static final addServerFlow = FlowDefinition(
    name: 'onboarding_add_server',
    steps: [
      RouteStep<DiscoveryRoute>(
        id: 'choose_mode',
        toRoute: (ctx) => const DiscoveryRoute(),
        onEnter: (ctx) async {
          // Initialize discovery process
          ctx.put('discovery_started', true);
        },
      ),
      RouteStep<DiscoveryRoute>(
        id: 'discover',
        toRoute: (ctx) => const DiscoveryRoute(),
        canProceed: (ctx) => (ctx.get<List>('hosts')?.isNotEmpty ?? false),
        onEnter: (ctx) async {
          // Start server discovery
          ctx.put('hosts', <String>[]);
        },
      ),
      RouteStep<EnterAddressRoute>(
        id: 'enter_manual',
        toRoute: (ctx) => const EnterAddressRoute(),
        canProceed: (ctx) async {
          final address = ctx.get<String>('server_address');
          return address != null && address.isNotEmpty;
        },
      ),
      RouteStep<AddServerRouteData>(
        id: 'summary',
        toRoute: (ctx) => const AddServerRouteData(),
        onEnter: (ctx) async {
          // Prepare summary data
          final address = ctx.get<String>('server_address');
          ctx.put('summary_data', {'address': address});
        },
      ),
    ],
    onSuccess: (ctx) async {
      // Save the server configuration
      final address = ctx.get<String>('server_address');
      if (address != null) {
        // Here you would typically save to the server repository
        // await ctx.read(serverRepoProvider).save(server);
        debugPrint('Server saved: $address');
      }
    },
  );

  /// Sample onboarding flow using the sample routes with correct go_router_builder pattern
  static final sampleOnboardingFlow = FlowDefinition(
    name: 'sample_onboarding',
    steps: [
      RouteStep<ChooseModeRoute>(
        id: 'choose_mode',
        toRoute: (ctx) => const ChooseModeRoute(),
        onEnter: (ctx) async {
          // Initialize onboarding
          ctx.put('onboarding_started', DateTime.now().toIso8601String());
        },
      ),
      RouteStep<DiscoverRoute>(
        id: 'discover',
        toRoute: (ctx) => const DiscoverRoute(seed: 'auto'),
        canProceed: (ctx) =>
            (ctx.get<List>('discovered_servers')?.isNotEmpty ?? false),
        onEnter: (ctx) async {
          // Start auto-discovery
          ctx.put('discovered_servers', <String>[]);
        },
      ),
      RouteStep<EnterManualRoute>(
        id: 'enter_manual',
        toRoute: (ctx) => const EnterManualRoute(),
        canProceed: (ctx) async {
          final address = ctx.get<String>('manual_address');
          return address != null && address.isNotEmpty;
        },
      ),
      RouteStep<SummaryRoute>(
        id: 'summary',
        toRoute: (ctx) => const SummaryRoute(),
        onEnter: (ctx) async {
          // Prepare final configuration
          final mode = ctx.get<String>('connection_mode') ?? 'auto';
          final address = ctx.get<String>('server_address');
          ctx.put('final_config', {'mode': mode, 'address': address});
        },
      ),
    ],
    onSuccess: (ctx) async {
      // Complete onboarding
      final config = ctx.get<Map>('final_config');
      debugPrint('Onboarding completed with config: $config');
    },
  );
}

/// Example page that uses the flow builder
class FlowExamplePage extends ConsumerWidget {
  const FlowExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runner = ref.read(flowRunnerProvider);
    final flowState = ref.watch(flowStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Flow Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Flow State: ${flowState.runtimeType}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            switch (flowState) {
              FlowIdle() => Column(
                children: [
                  const Text('Flow is idle'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => runner.start(FlowExample.addServerFlow),
                    child: const Text('Start Add Server Flow'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () =>
                        runner.start(FlowExample.sampleOnboardingFlow),
                    child: const Text('Start Sample Onboarding Flow'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => runner.start(
                      FlowExample.addServerFlow,
                      startAt: 'enter_manual',
                    ),
                    child: const Text('Start at Manual Entry'),
                  ),
                ],
              ),
              FlowInStep(:final stepId, :final index) => Column(
                children: [
                  Text(
                    'In step: $stepId (${index + 1}/${runner.definition?.steps.length})',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => runner.back(),
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: () => runner.next(),
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
              FlowDone() => Column(
                children: [
                  const Text('Flow completed successfully!'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    child: const Text('Done'),
                  ),
                ],
              ),
              FlowError(:final stepId, :final error) => Column(
                children: [
                  Text('Error in step $stepId: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => runner.next(), // Retry
                    child: const Text('Retry'),
                  ),
                ],
              ),
            },
          ],
        ),
      ),
    );
  }
}

/// Example of a page within the flow that uses the flow runner
class FlowAwarePage extends ConsumerWidget {
  const FlowAwarePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runner = ref.read(flowRunnerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => runner.back()),
        title: const Text('Flow Step'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is a step in the flow'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => runner.next(),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
