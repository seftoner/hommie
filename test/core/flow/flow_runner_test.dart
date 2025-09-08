import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hommie/core/flow/flow_definition.dart';
import 'package:hommie/core/flow/flow_providers.dart';
import 'package:hommie/core/flow/flow_runner.dart';
import 'package:hommie/core/flow/toast_service.dart';
import 'package:hommie/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeToastService implements ToastService {
  final List<String> messages = [];
  @override
  void show(String message) => messages.add(message);
}

class DummyRouteData extends GoRouteData {
  final String path;
  DummyRouteData(this.path);
  @override
  String get location => path;
}

// no custom router subclass needed in widget tests

void main() {
  group('FlowRunner behaviour', () {
    late ProviderContainer container;
    late FakeToastService toast;
    late GoRouter router;
    late FlowRunner runner;

    RouteStep<T> step<T extends GoRouteData>(
      String id,
      T Function(FlowContext) toRoute, {
      FutureOr<bool> Function(FlowContext ctx)? canProceed,
      Future<void> Function(FlowContext ctx)? onEnter,
    }) => RouteStep<T>(
      id: id,
      toRoute: toRoute,
      canProceed: canProceed,
      onEnter: onEnter,
    );

    setUp(() {
      toast = FakeToastService();
      router = GoRouter(
        routes: [GoRoute(path: '/', builder: (_, __) => const SizedBox())],
      );
      container = ProviderContainer(
        overrides: [
          toastServiceProvider.overrideWithValue(toast),
          goRouterProvider.overrideWithValue(router),
        ],
      );
      runner = container.read(flowRunnerProvider);
    });

    tearDown(() => container.dispose());

    testWidgets('start basic flow', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      final def = FlowDefinition(
        name: 'basic',
        steps: [
          step('one', (_) => DummyRouteData('/one')),
          step('two', (_) => DummyRouteData('/two')),
        ],
      );
      await runner.start(def);
      await tester.pump();
      expect(runner.definition, def);
      expect(runner.currentIndex, 0);
      expect(runner.state, isA<FlowInStep>());
    });

    testWidgets('deep link invalid id falls back to 0', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      final def = FlowDefinition(
        name: 'deep',
        steps: [
          step('one', (_) => DummyRouteData('/one')),
          step('two', (_) => DummyRouteData('/two')),
        ],
      );
      await runner.start(def, startAt: 'missing');
      await tester.pump();
      expect(runner.currentIndex, 0);
    });

    testWidgets('guard prevents advance and shows toast', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      bool allow = false;
      final def = FlowDefinition(
        name: 'guard',
        steps: [
          step('one', (_) => DummyRouteData('/one'), canProceed: (_) => allow),
          step('two', (_) => DummyRouteData('/two')),
        ],
      );
      await runner.start(def);
      await tester.pump();
      await runner.next();
      await tester.pump();
      expect(runner.currentIndex, 0);
      expect(toast.messages.any((m) => m.contains('Cannot proceed')), isTrue);
      allow = true;
      await runner.next();
      await tester.pump();
      expect(runner.currentIndex, 1);
    });

    testWidgets('onEnter error produces FlowError state', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      final def = FlowDefinition(
        name: 'err',
        steps: [
          step(
            'one',
            (_) => DummyRouteData('/one'),
            onEnter: (_) async {
              throw Exception('boom');
            },
          ),
        ],
      );
      await runner.start(def);
      await tester.pump();
      expect(runner.state, isA<FlowError>());
      expect(toast.messages.any((m) => m.contains('Step error')), isTrue);
    });

    testWidgets('success path triggers FlowDone and onSuccess', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      bool successCalled = false;
      final def = FlowDefinition(
        name: 'success',
        steps: [step('one', (_) => DummyRouteData('/one'))],
        onSuccess: (_) async {
          successCalled = true;
        },
      );
      await runner.start(def);
      await tester.pump();
      await runner.next();
      await tester.pump();
      expect(runner.state, isA<FlowDone>());
      expect(successCalled, isTrue);
    });

    testWidgets('back navigates to previous step', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      final def = FlowDefinition(
        name: 'back',
        steps: [
          step('one', (_) => DummyRouteData('/one')),
          step('two', (_) => DummyRouteData('/two')),
        ],
      );
      await runner.start(def);
      await tester.pump();
      await runner.back();
      await tester.pump();
      expect(runner.definition, isNull);
      expect(runner.state, isA<FlowIdle>());
    });

    testWidgets('reentrancy guard prevents double next', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      int enterCount = 0;
      final def = FlowDefinition(
        name: 're',
        steps: [
          step(
            'one',
            (_) => DummyRouteData('/one'),
            onEnter: (_) async {
              enterCount++;
            },
          ),
          step('two', (_) => DummyRouteData('/two')),
        ],
      );
      await runner.start(def);
      await tester.pump();
      await Future.wait([runner.next(), runner.next()]);
      await tester.pump();
      // Should only have advanced once
      expect(runner.currentIndex, 1);
      expect(enterCount, 1);
    });

    testWidgets('cancel resets state without success or pop side effects', (
      tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      final def = FlowDefinition(
        name: 'cancel',
        steps: [step('one', (_) => DummyRouteData('/one'))],
      );
      await runner.start(def);
      await tester.pump();
      await runner.cancel();
      await tester.pump();
      expect(runner.definition, isNull);
      expect(runner.state, isA<FlowIdle>());
    });
  });
}
