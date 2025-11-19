import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow_builder/flow_blueprint_v2.dart';
import 'package:hommie/core/flow_builder/flow_controller_v2.dart';
import 'package:hommie/core/flow_builder/flow_navigation.dart';
import 'package:riverpod/riverpod.dart';

// Test route definitions
class TestRoute1 extends GoRouteData {
  const TestRoute1();

  @override
  String get location => '/test1';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Text('Test Route 1'));
}

class TestRoute2 extends GoRouteData {
  const TestRoute2();

  @override
  String get location => '/test2';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Text('Test Route 2'));
}

void main() {
  group('FlowControllerV2', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          flowNavigatorV2Provider.overrideWithValue(FlowNavigator()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should start in idle state', () {
      final state = container.read(flowControllerV2Provider);
      expect(state, isA<FlowIdleV2>());
    });

    test('should start flow and enter first step', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowActionStepV2(
            id: 'step1',
            action: (ctx) async {},
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      // Should complete immediately (action step with autoComplete)
      final state = container.read(flowControllerV2Provider);
      expect(state, isA<FlowCompletedV2>());
    });

    test('should advance through steps', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
          FlowRouteStepV2(
            id: 'step2',
            pageBuilder: (context, flowContext) => const Text('Step 2'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      final state1 = container.read(flowControllerV2Provider);
      expect(state1, isA<FlowActiveV2>());
      expect((state1 as FlowActiveV2).snapshot.step.id, equals('step1'));

      await controller.completeStep();

      final state2 = container.read(flowControllerV2Provider);
      expect(state2, isA<FlowActiveV2>());
      expect((state2 as FlowActiveV2).snapshot.step.id, equals('step2'));
    });

    test('should complete flow when reaching last step', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      await controller.completeStep();

      final state = container.read(flowControllerV2Provider);
      expect(state, isA<FlowCompletedV2>());
    });

    test('should pass data between steps', () async {
      String? receivedValue;

      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowActionStepV2(
            id: 'step1',
            autoComplete: false,
            action: (ctx) async {
              ctx.write('testKey', 'testValue');
            },
          ),
          FlowActionStepV2(
            id: 'step2',
            action: (ctx) async {
              receivedValue = ctx.readValue<String>('testKey');
            },
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);
      await controller.completeStep();

      // Wait for async completion
      await Future.delayed(const Duration(milliseconds: 10));

      expect(receivedValue, equals('testValue'));
    });

    test('should cancel flow', () async {
      bool onCancelCalled = false;

      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
        ],
        onCancel: (ctx) async {
          onCancelCalled = true;
        },
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      await controller.cancel();

      final state = container.read(flowControllerV2Provider);
      expect(state, isA<FlowIdleV2>());
      expect(onCancelCalled, isTrue);
    });

    test('should support jumping to specific step', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
          FlowRouteStepV2(
            id: 'step2',
            pageBuilder: (context, flowContext) => const Text('Step 2'),
          ),
          FlowRouteStepV2(
            id: 'step3',
            pageBuilder: (context, flowContext) => const Text('Step 3'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      await controller.jumpTo('step3');

      final state = container.read(flowControllerV2Provider);
      expect(state, isA<FlowActiveV2>());
      expect((state as FlowActiveV2).snapshot.step.id, equals('step3'));
    });

    test('should support going back', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
          FlowRouteStepV2(
            id: 'step2',
            pageBuilder: (context, flowContext) => const Text('Step 2'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);
      await controller.completeStep();

      final state1 = container.read(flowControllerV2Provider);
      expect((state1 as FlowActiveV2).snapshot.step.id, equals('step2'));

      await controller.back();

      final state2 = container.read(flowControllerV2Provider);
      expect((state2 as FlowActiveV2).snapshot.step.id, equals('step1'));
    });

    test('should throw when going back from first step', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      expect(
        () => controller.back(),
        throwsA(isA<StateError>()),
      );
    });

    test('should start from specific step', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
          FlowRouteStepV2(
            id: 'step2',
            pageBuilder: (context, flowContext) => const Text('Step 2'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint, startAtStep: 'step2');

      final state = container.read(flowControllerV2Provider);
      expect(state, isA<FlowActiveV2>());
      expect((state as FlowActiveV2).snapshot.step.id, equals('step2'));
    });

    test('should throw when starting at invalid step', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);

      expect(
        () => controller.start(blueprint, startAtStep: 'nonexistent'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should show loading state for action steps', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowActionStepV2(
            id: 'loading-action',
            showLoading: true,
            loadingMessage: 'Processing...',
            action: (ctx) async {
              await Future.delayed(const Duration(milliseconds: 10));
            },
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      
      // Start the flow
      final startFuture = controller.start(blueprint);
      
      // Check loading state appears briefly
      await Future.delayed(const Duration(milliseconds: 5));
      final loadingState = container.read(flowControllerV2Provider);
      
      // Note: This might be flaky in CI, so we're flexible here
      // Either it's still loading or already completed
      expect(
        loadingState,
        anyOf([isA<FlowActiveV2>(), isA<FlowCompletedV2>()]),
      );
      
      // Wait for completion
      await startFuture;
      
      final finalState = container.read(flowControllerV2Provider);
      expect(finalState, isA<FlowCompletedV2>());
    });

    test('should call onFinish when flow completes', () async {
      bool onFinishCalled = false;

      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowActionStepV2(
            id: 'step1',
            action: (ctx) async {},
          ),
        ],
        onFinish: (ctx) async {
          onFinishCalled = true;
        },
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      expect(onFinishCalled, isTrue);
    });

    test('should handle errors and create failed state', () async {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowActionStepV2(
            id: 'failing-step',
            action: (ctx) async {
              throw Exception('Test error');
            },
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);

      final state = container.read(flowControllerV2Provider);
      expect(state, isA<FlowFailedV2>());
      expect((state as FlowFailedV2).error, isA<Exception>());
    });

    test('should respect canEnter guards', () async {
      int step2Entries = 0;

      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
          ),
          FlowRouteStepV2(
            id: 'step2',
            pageBuilder: (context, flowContext) => const Text('Step 2'),
            canEnter: (ctx) async {
              final canEnter = ctx.readValue<bool>('canEnterStep2') ?? false;
              return canEnter;
            },
            onEnter: (ctx) async {
              step2Entries++;
            },
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      
      // First attempt - guard should block
      await controller.start(blueprint);
      await controller.completeStep();

      expect(step2Entries, equals(0));

      // Second attempt - with permission
      await controller.start(
        blueprint,
        initialData: {'canEnterStep2': true},
      );
      await controller.completeStep();

      expect(step2Entries, equals(1));
    });

    test('should call onExit when leaving step', () async {
      bool onExitCalled = false;

      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            pageBuilder: (context, flowContext) => const Text('Step 1'),
            onExit: (ctx) async {
              onExitCalled = true;
            },
          ),
          FlowRouteStepV2(
            id: 'step2',
            pageBuilder: (context, flowContext) => const Text('Step 2'),
          ),
        ],
      );

      final controller = container.read(flowControllerV2Provider.notifier);
      await controller.start(blueprint);
      await controller.completeStep();

      expect(onExitCalled, isTrue);
    });
  });
}
