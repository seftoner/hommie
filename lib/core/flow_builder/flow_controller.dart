import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

import 'flow_blueprint.dart';
import 'flow_navigation.dart';

final flowNavigatorProvider = Provider<FlowNavigator>((ref) {
  return FlowNavigator();
});

final flowControllerProvider = NotifierProvider<FlowController, FlowStatus>(
  FlowController.new,
);

@immutable
sealed class FlowStatus {
  const FlowStatus();
}

class FlowIdle extends FlowStatus {
  const FlowIdle();
}

class FlowActive extends FlowStatus {
  const FlowActive(this.snapshot);

  final FlowSnapshot snapshot;
}

class FlowCompleted extends FlowStatus {
  const FlowCompleted(this.blueprint, this.context);

  final FlowBlueprint blueprint;
  final FlowContext context;
}

class FlowFailed extends FlowStatus {
  const FlowFailed(this.snapshot, this.error, this.stackTrace);

  final FlowSnapshot snapshot;
  final Object error;
  final StackTrace stackTrace;
}

class FlowController extends Notifier<FlowStatus> {
  FlowController();

  late final FlowNavigator _navigator = ref.read(flowNavigatorProvider);

  @override
  FlowStatus build() {
    return const FlowIdle();
  }

  FlowSnapshot? get current =>
      state is FlowActive ? (state as FlowActive).snapshot : null;

  bool get isRunning => state is FlowActive;

  Future<void> start(
    FlowBlueprint blueprint, {
    Map<String, Object?> initialData = const {},
  }) async {
    if (blueprint.steps.isEmpty) {
      throw ArgumentError('Flow "${blueprint.id}" must contain steps.');
    }
    final context = FlowContext(ref, _navigator, initialData);
    final snapshot = FlowSnapshot(
      blueprint: blueprint,
      context: context,
      index: 0,
    );
    state = FlowActive(snapshot);
    await _runStep(snapshot);
  }

  Future<void> completeStep({Map<String, Object?> output = const {}}) async {
    final snapshot = _requireActive();
    snapshot.context.writeAll(output);
    await _advance(snapshot);
  }

  Future<void> cancel([Map<String, Object?> data = const {}]) async {
    final snapshot = current;
    state = const FlowIdle();
    if (snapshot != null) {
      snapshot.context.writeAll(data);
      await snapshot.blueprint.onCancel?.call(snapshot.context);
    }
  }

  Future<void> _runStep(FlowSnapshot snapshot) async {
    try {
      await snapshot.step.enter(snapshot.context, _navigator);
      if (snapshot.step.completesImmediately) {
        await _advance(snapshot);
      }
    } catch (err, st) {
      state = FlowFailed(snapshot, err, st);
    }
  }

  Future<void> _advance(FlowSnapshot snapshot) async {
    final nextIndex = snapshot.index + 1;
    if (nextIndex >= snapshot.blueprint.steps.length) {
      state = FlowCompleted(snapshot.blueprint, snapshot.context);
      await snapshot.blueprint.onFinish?.call(snapshot.context);
      return;
    }
    final next = FlowSnapshot(
      blueprint: snapshot.blueprint,
      context: snapshot.context,
      index: nextIndex,
    );
    state = FlowActive(next);
    await _runStep(next);
  }

  FlowSnapshot _requireActive() {
    final snapshot = current;
    if (snapshot == null) {
      throw StateError('Flow is not running. Call start() first.');
    }
    return snapshot;
  }
}
