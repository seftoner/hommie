import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow_builder/flow_blueprint_v2.dart';
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
  group('FlowBlueprintV2', () {
    late ProviderContainer container;
    late FlowNavigator navigator;

    setUp(() {
      container = ProviderContainer();
      navigator = FlowNavigator();
    });

    tearDown(() {
      container.dispose();
    });

    test('should create blueprint with steps', () {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        description: 'Test flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            label: 'Step 1',
            routeBuilder: (ctx) => const TestRoute1(),
          ),
          FlowRouteStepV2(
            id: 'step2',
            label: 'Step 2',
            routeBuilder: (ctx) => const TestRoute2(),
          ),
        ],
      );

      expect(blueprint.id, equals('test-flow'));
      expect(blueprint.description, equals('Test flow'));
      expect(blueprint.steps.length, equals(2));
      expect(blueprint.totalSteps, equals(2));
      expect(blueprint.presentation, equals(FlowPresentationStyle.fullscreen));
    });

    test('should find step by id', () {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            routeBuilder: (ctx) => const TestRoute1(),
          ),
          FlowRouteStepV2(
            id: 'step2',
            routeBuilder: (ctx) => const TestRoute2(),
          ),
        ],
      );

      final step1 = blueprint.stepById('step1');
      expect(step1, isNotNull);
      expect(step1!.id, equals('step1'));

      final nonExistent = blueprint.stepById('nonexistent');
      expect(nonExistent, isNull);
    });

    test('should get step index by id', () {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            routeBuilder: (ctx) => const TestRoute1(),
          ),
          FlowRouteStepV2(
            id: 'step2',
            routeBuilder: (ctx) => const TestRoute2(),
          ),
        ],
      );

      expect(blueprint.indexOfStep('step1'), equals(0));
      expect(blueprint.indexOfStep('step2'), equals(1));
      expect(blueprint.indexOfStep('nonexistent'), equals(-1));
    });

    test('should get all step IDs', () {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            routeBuilder: (ctx) => const TestRoute1(),
          ),
          FlowRouteStepV2(
            id: 'step2',
            routeBuilder: (ctx) => const TestRoute2(),
          ),
        ],
      );

      expect(blueprint.stepIds, equals(['step1', 'step2']));
    });

    test('should support different presentation styles', () {
      final blueprints = [
        FlowBlueprintV2(
          id: 'fullscreen',
          presentation: FlowPresentationStyle.fullscreen,
          steps: [],
        ),
        FlowBlueprintV2(
          id: 'card',
          presentation: FlowPresentationStyle.card,
          steps: [],
        ),
        FlowBlueprintV2(
          id: 'sheet',
          presentation: FlowPresentationStyle.sheet,
          steps: [],
        ),
        FlowBlueprintV2(
          id: 'inline',
          presentation: FlowPresentationStyle.inline,
          steps: [],
        ),
      ];

      expect(
        blueprints[0].presentation,
        equals(FlowPresentationStyle.fullscreen),
      );
      expect(blueprints[1].presentation, equals(FlowPresentationStyle.card));
      expect(blueprints[2].presentation, equals(FlowPresentationStyle.sheet));
      expect(blueprints[3].presentation, equals(FlowPresentationStyle.inline));
    });
  });

  group('FlowRouteStepV2', () {
    test('should create route step with routeBuilder', () {
      final step = FlowRouteStepV2(
        id: 'test-step',
        label: 'Test Step',
        routeBuilder: (ctx) => const TestRoute1(),
        mode: RouteNavigationMode.push,
      );

      expect(step.id, equals('test-step'));
      expect(step.label, equals('Test Step'));
      expect(step.mode, equals(RouteNavigationMode.push));
      expect(step.completesImmediately, isFalse);
    });

    test('should create route step with pageBuilder', () {
      final step = FlowRouteStepV2(
        id: 'test-step',
        label: 'Test Step',
        pageBuilder: (context, flowContext) => const Text('Test Page'),
      );

      expect(step.id, equals('test-step'));
      expect(step.pageBuilder, isNotNull);
      expect(step.routeBuilder, isNull);
    });

    test('should require either routeBuilder or pageBuilder', () {
      expect(
        () => FlowRouteStepV2(
          id: 'invalid',
          // Neither routeBuilder nor pageBuilder provided
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should support lifecycle hooks', () {
      bool onEnterCalled = false;
      bool onExitCalled = false;

      final step = FlowRouteStepV2(
        id: 'test-step',
        routeBuilder: (ctx) => const TestRoute1(),
        onEnter: (ctx) async {
          onEnterCalled = true;
        },
        onExit: (ctx) async {
          onExitCalled = true;
        },
      );

      expect(step.onEnter, isNotNull);
      expect(step.onExit, isNotNull);
      expect(onEnterCalled, isFalse);
      expect(onExitCalled, isFalse);
    });

    test('should support guards', () {
      final step = FlowRouteStepV2(
        id: 'test-step',
        routeBuilder: (ctx) => const TestRoute1(),
        canEnter: (ctx) async => false,
      );

      expect(step.canEnter, isNotNull);
    });
  });

  group('FlowActionStepV2', () {
    test('should create action step', () {
      bool actionCalled = false;
      final step = FlowActionStepV2(
        id: 'test-action',
        label: 'Test Action',
        action: (ctx) async {
          actionCalled = true;
        },
      );

      expect(step.id, equals('test-action'));
      expect(step.label, equals('Test Action'));
      expect(step.autoComplete, isTrue);
      expect(step.showLoading, isFalse);
      expect(step.completesImmediately, isTrue);
      expect(actionCalled, isFalse);
    });

    test('should support loading state', () {
      final step = FlowActionStepV2(
        id: 'test-action',
        action: (ctx) async {},
        showLoading: true,
        loadingMessage: 'Processing...',
      );

      expect(step.showLoading, isTrue);
      expect(step.loadingMessage, equals('Processing...'));
    });

    test('should support manual completion', () {
      final step = FlowActionStepV2(
        id: 'test-action',
        action: (ctx) async {},
        autoComplete: false,
      );

      expect(step.autoComplete, isFalse);
      expect(step.completesImmediately, isFalse);
    });
  });

  group('FlowBranchStepV2', () {
    test('should create branch step', () {
      final step = FlowBranchStepV2(
        id: 'test-branch',
        label: 'Test Branch',
        branches: {
          'path1': [
            FlowRouteStepV2(
              id: 'path1-step',
              routeBuilder: (ctx) => const TestRoute1(),
            ),
          ],
          'path2': [
            FlowRouteStepV2(
              id: 'path2-step',
              routeBuilder: (ctx) => const TestRoute2(),
            ),
          ],
        },
        selector: (ctx) => 'path1',
      );

      expect(step.id, equals('test-branch'));
      expect(step.label, equals('Test Branch'));
      expect(step.branches.keys, contains('path1'));
      expect(step.branches.keys, contains('path2'));
      expect(step.completesImmediately, isFalse);
    });
  });

  group('FlowContext', () {
    late ProviderContainer container;
    late FlowNavigator navigator;

    setUp(() {
      container = ProviderContainer();
      navigator = FlowNavigator();
    });

    tearDown(() {
      container.dispose();
    });

    test('should store and retrieve data', () {
      final context = FlowContext(container, navigator);

      context.write('key1', 'value1');
      context.write('key2', 42);

      expect(context.readValue<String>('key1'), equals('value1'));
      expect(context.readValue<int>('key2'), equals(42));
      expect(context.readValue<String>('nonexistent'), isNull);
    });

    test('should write all data at once', () {
      final context = FlowContext(container, navigator);

      context.writeAll({'key1': 'value1', 'key2': 42});

      expect(context.readValue<String>('key1'), equals('value1'));
      expect(context.readValue<int>('key2'), equals(42));
    });

    test('should expect value or throw', () {
      final context = FlowContext(container, navigator);

      context.write('key1', 'value1');

      expect(context.expectValue<String>('key1'), equals('value1'));
      expect(
        () => context.expectValue<String>('nonexistent'),
        throwsA(isA<StateError>()),
      );
    });

    test('should support initial data', () {
      final context = FlowContext(
        container,
        navigator,
        {'initial': 'data'},
      );

      expect(context.readValue<String>('initial'), equals('data'));
    });
  });

  group('FlowSnapshotV2', () {
    late ProviderContainer container;
    late FlowNavigator navigator;

    setUp(() {
      container = ProviderContainer();
      navigator = FlowNavigator();
    });

    tearDown(() {
      container.dispose();
    });

    test('should track current step', () {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            routeBuilder: (ctx) => const TestRoute1(),
          ),
          FlowRouteStepV2(
            id: 'step2',
            routeBuilder: (ctx) => const TestRoute2(),
          ),
        ],
      );

      final context = FlowContext(container, navigator);
      final snapshot = FlowSnapshotV2(
        blueprint: blueprint,
        context: context,
        index: 0,
      );

      expect(snapshot.step.id, equals('step1'));
      expect(snapshot.index, equals(0));
      expect(snapshot.isFirstStep, isTrue);
      expect(snapshot.isLastStep, isFalse);
      expect(snapshot.progress, equals(0.5));
    });

    test('should calculate progress correctly', () {
      final blueprint = FlowBlueprintV2(
        id: 'test-flow',
        steps: [
          FlowRouteStepV2(
            id: 'step1',
            routeBuilder: (ctx) => const TestRoute1(),
          ),
          FlowRouteStepV2(
            id: 'step2',
            routeBuilder: (ctx) => const TestRoute2(),
          ),
          FlowActionStepV2(
            id: 'step3',
            action: (ctx) async {},
          ),
        ],
      );

      final context = FlowContext(container, navigator);

      // First step: 1/3 = 0.33...
      final snapshot1 = FlowSnapshotV2(
        blueprint: blueprint,
        context: context,
        index: 0,
      );
      expect(snapshot1.progress, closeTo(0.333, 0.01));

      // Last step: 3/3 = 1.0
      final snapshot3 = FlowSnapshotV2(
        blueprint: blueprint,
        context: context,
        index: 2,
      );
      expect(snapshot3.progress, equals(1.0));
      expect(snapshot3.isLastStep, isTrue);
    });
  });
}
