import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flow_definition.dart';
import 'toast_service.dart';

part 'flow_runner.g.dart';

/// Public abstraction for controlling a linear flow.
abstract interface class FlowRunner {
  /// Start a new flow. Throws [StateError] if already running.
  /// [initialData] seeds the context key/value store.
  /// [startAt] overrides the definition's `startAt` if provided.
  Future<void> start(
    FlowDefinition def, {
    Map<String, Object?>? initialData,
    StepId? startAt,
  });

  /// Move to the next step if validation passes; on final step triggers success.
  Future<void> next();

  /// Navigate back one step; from index 0 => cancel (idle + pop router).
  Future<void> back();

  /// Explicitly cancel the current flow without success callback.
  Future<void> cancel();

  /// Active definition (null when idle).
  FlowDefinition? get definition;

  /// Current step index or null when idle.
  int? get currentIndex;

  /// Current flow state value.
  FlowState get state;
}

@Riverpod(keepAlive: true)
class FlowRunnerNotifier extends _$FlowRunnerNotifier implements FlowRunner {
  late final GoRouter _router;
  FlowDefinition? _def;
  int? _idx;
  late FlowContext _ctx;
  bool _transitioning = false; // reentrancy / race guard

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
    Map<String, Object?>? initialData,
    StepId? startAt,
  }) async {
    if (_def != null) {
      throw StateError(
        'A flow is already running. Cancel before starting a new one.',
      );
    }
    if (def.steps.isEmpty) {
      throw ArgumentError('FlowDefinition "${def.name}" has no steps');
    }
    _def = def;
    _ctx = FlowContext(ref, initialData);
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
    try {
      if (step.onEnter != null) {
        await step.onEnter!(_ctx);
      }
      // go_router_builder integration: navigate via typed route's `location`
      final data = step.toRoute(_ctx);
      _router.go(data.location);
    } catch (e, st) {
      // Expose error state; do not overwrite immediately.
      ref.read(toastServiceProvider).show('Step error: $e');
      state = FlowError(step.id, e, st);
    }
  }

  @override
  Future<void> next() async {
    if (_def == null || _idx == null) return; // idle
    if (_transitioning) return;
    _transitioning = true;
    final i = _idx!;
    final step = _def!.steps[i];
    try {
      final ok = await (step.canProceed?.call(_ctx) ?? Future.value(true));
      if (!ok) {
        ref.read(toastServiceProvider).show('Cannot proceed yet');
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
    } finally {
      _transitioning = false;
    }
  }

  @override
  Future<void> back() async {
    if (_def == null || _idx == null) return; // idle
    if (_transitioning) return;
    _transitioning = true;
    try {
      final i = _idx!;
      if (i == 0) {
        await cancel(pop: true);
        return;
      }
      _idx = i - 1;
      await _enterCurrentStep();
    } finally {
      _transitioning = false;
    }
  }

  @override
  Future<void> cancel({bool pop = false}) async {
    if (_def == null) return;
    _def = null;
    _idx = null;
    state = const FlowIdle();
    if (pop) {
      try {
        _router.pop();
      } catch (_) {
        // ignore if nothing to pop (e.g., tests)
      }
    }
  }
}
