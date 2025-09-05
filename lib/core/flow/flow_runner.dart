import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flow_definition.dart';
import 'toast_service.dart';

part 'flow_runner.g.dart';

abstract interface class FlowRunner {
  Future<void> start(
    FlowDefinition def, {
    Object? initialInput,
    StepId? startAt,
  });
  Future<void> next();
  Future<void> back(); // back from first step => exit (pop)
  FlowDefinition? get definition;
  int? get currentIndex;
  FlowState get state;
}

@Riverpod(keepAlive: true)
class FlowRunnerNotifier extends _$FlowRunnerNotifier implements FlowRunner {
  late final GoRouter _router;
  FlowDefinition? _def;
  int? _idx;
  late FlowContext _ctx;

  @override
  FlowState build(GoRouter router) {
    _router = router;
    return const FlowIdle();
  }

  @override
  FlowDefinition? get definition => _def;

  @override
  int? get currentIndex => _idx;

  @override
  Future<void> start(
    FlowDefinition def, {
    Object? initialInput,
    StepId? startAt,
  }) async {
    _def = def;
    _ctx = FlowContext(ref, initialInput as Map<String, Object?>?);
    final steps = def.steps;
    _idx = _resolveStartIndex(steps, def.startAt ?? startAt);
    await _enterCurrentStep();
  }

  int _resolveStartIndex(List<RouteStep> steps, StepId? startAt) {
    if (startAt == null) {
      return 0;
    }
    final i = steps.indexWhere((s) => s.id == startAt);
    return i < 0 ? 0 : i;
    // Tip: if deep link opens a step externally, caller can pass startAt matching that step's id.
  }

  Future<void> _enterCurrentStep() async {
    final i = _idx!;
    final step = _def!.steps[i];
    state = FlowInStep(step.id, i);
    if (step.onEnter != null) {
      await step.onEnter!(_ctx);
    }

    // go_router_builder integration: navigate via typed route's `location`
    final data = step.toRoute(_ctx);
    _router.go(data.location);
  }

  @override
  Future<void> next() async {
    final i = _idx!;
    final step = _def!.steps[i];
    try {
      final ok = await (step.canProceed?.call(_ctx) ?? Future.value(true));
      if (!ok) {
        return;
      }
      if (i + 1 >= _def!.steps.length) {
        state = const FlowDone();
        await _def!.onSuccess?.call(_ctx);
        return; // caller decides what to do (e.g., pop)
      }
      _idx = i + 1;
      await _enterCurrentStep();
    } catch (e, st) {
      ref.read(toastServiceProvider).show('Error: $e');
      state = FlowError(step.id, e, st);
      state = FlowInStep(step.id, i);
    }
  }

  @override
  Future<void> back() async {
    final i = _idx!;
    if (i == 0) {
      _def = null;
      _idx = null;
      state = const FlowIdle();
      _router.pop();
      return;
    }
    _idx = i - 1;
    await _enterCurrentStep();
  }
}
