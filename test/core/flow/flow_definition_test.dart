import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow/flow_definition.dart';
import 'package:hommie/core/flow/toast_service.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

class FakeToastService implements ToastService {
  final List<String> messages = [];

  @override
  void show(String message) {
    messages.add(message);
  }
}

void main() {
  group('Flow Framework Core Tests', () {
    late ProviderContainer container;
    late FakeToastService fakeToast;

    setUp(() {
      fakeToast = FakeToastService();
      container = ProviderContainer(
        overrides: [toastServiceProvider.overrideWithValue(fakeToast)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('FlowDefinition', () {
      test('should create flow with steps', () {
        final testFlow = createTestFlow();

        expect(testFlow.name, equals('test'));
        expect(testFlow.steps.length, equals(2));
        expect(testFlow.steps[0].id, equals('step1'));
        expect(testFlow.steps[1].id, equals('step2'));
      });

      test('should find step by id', () {
        final testFlow = createTestFlow();

        expect(testFlow.steps.indexWhere((s) => s.id == 'step1'), equals(0));
        expect(testFlow.steps.indexWhere((s) => s.id == 'step2'), equals(1));
        expect(
          testFlow.steps.indexWhere((s) => s.id == 'nonexistent'),
          equals(-1),
        );
      });
    });

    group('FlowState hierarchy', () {
      test('should create different flow states', () {
        const idle = FlowIdle();
        const inStep = FlowInStep('step1', 0);
        const done = FlowDone();
        final error = FlowError('step1', Exception('test'), StackTrace.current);

        expect(idle, isA<FlowIdle>());
        expect(inStep, isA<FlowInStep>());
        expect(inStep.stepId, equals('step1'));
        expect(inStep.index, equals(0));
        expect(done, isA<FlowDone>());
        expect(error, isA<FlowError>());
        expect(error.stepId, equals('step1'));
        expect(error.error, isA<Exception>());
      });

      test('should have proper equality for states', () {
        const idle1 = FlowIdle();
        const idle2 = FlowIdle();
        const inStep1 = FlowInStep('step1', 0);
        const inStep2 = FlowInStep('step1', 0);
        const inStep3 = FlowInStep('step2', 1);

        expect(idle1, equals(idle2));
        expect(inStep1, equals(inStep2));
        expect(inStep1, isNot(equals(inStep3)));
      });
    });

    group('RouteStep', () {
      test('should create route step with required fields', () {
        final step = RouteStep<TestRoute1>(
          id: 'test_step',
          toRoute: (ctx) => const TestRoute1(),
        );

        expect(step.id, equals('test_step'));
        expect(step.canProceed, isNull);
        expect(step.onEnter, isNull);
      });

      test('should generate route from toRoute function', () {
        final step = RouteStep<TestRoute1>(
          id: 'test_step',
          toRoute: (ctx) => const TestRoute1(),
        );

        // We'll test the route generation without full context
        // by testing that the toRoute function returns the correct type
        expect(step.toRoute, isA<TestRoute1 Function(FlowContext)>());
        expect(step.id, equals('test_step'));
      });

      test('should handle canProceed callback', () async {
        bool canProceedCalled = false;
        final step = RouteStep<TestRoute1>(
          id: 'test_step',
          toRoute: (ctx) => const TestRoute1(),
          canProceed: (ctx) {
            canProceedCalled = true;
            return true;
          },
        );

        // Test that canProceed callback exists
        expect(step.canProceed, isNotNull);
        expect(canProceedCalled, isFalse); // Not called yet
      });

      test('should handle onEnter callback', () async {
        bool onEnterCalled = false;
        final step = RouteStep<TestRoute1>(
          id: 'test_step',
          toRoute: (ctx) => const TestRoute1(),
          onEnter: (ctx) async {
            onEnterCalled = true;
          },
        );

        // Test that onEnter callback exists
        expect(step.onEnter, isNotNull);
        expect(onEnterCalled, isFalse); // Not called yet
      });
    });

    group('Toast Service', () {
      test('debug toast service should work', () {
        const debugToast = DebugToastService();
        // Should not throw
        debugToast.show('Test message');
      });

      test('fake toast service should capture messages', () {
        fakeToast.show('Test message 1');
        fakeToast.show('Test message 2');

        expect(
          fakeToast.messages,
          equals(['Test message 1', 'Test message 2']),
        );
      });
    });
  });
}

// Helper function to create test flow
FlowDefinition createTestFlow() {
  return FlowDefinition(
    name: 'test',
    steps: [
      RouteStep<TestRoute1>(id: 'step1', toRoute: (ctx) => const TestRoute1()),
      RouteStep<TestRoute2>(id: 'step2', toRoute: (ctx) => const TestRoute2()),
    ],
  );
}
