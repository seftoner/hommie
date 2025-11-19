import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

import 'flow_blueprint_v2.dart';
import 'flow_navigation.dart';

final flowNavigatorV2Provider = Provider<FlowNavigator>((ref) {
  return FlowNavigator();
});

final flowControllerV2Provider = NotifierProvider<FlowControllerV2, FlowStatusV2>(
  FlowControllerV2.new,
);

@immutable
sealed class FlowStatusV2 {
  const FlowStatusV2();
}

class FlowIdleV2 extends FlowStatusV2 {
  const FlowIdleV2();
}

class FlowActiveV2 extends FlowStatusV2 {
  const FlowActiveV2(this.snapshot, {this.isLoading = false, this.loadingMessage});

  final FlowSnapshotV2 snapshot;
  final bool isLoading;
  final String? loadingMessage;

  FlowActiveV2 copyWith({
    FlowSnapshotV2? snapshot,
    bool? isLoading,
    String? loadingMessage,
  }) {
    return FlowActiveV2(
      snapshot ?? this.snapshot,
      isLoading: isLoading ?? this.isLoading,
      loadingMessage: loadingMessage ?? this.loadingMessage,
    );
  }
}

class FlowCompletedV2 extends FlowStatusV2 {
  const FlowCompletedV2(this.blueprint, this.context);

  final FlowBlueprintV2 blueprint;
  final FlowContext context;
}

class FlowFailedV2 extends FlowStatusV2 {
  const FlowFailedV2(this.snapshot, this.error, this.stackTrace);

  final FlowSnapshotV2 snapshot;
  final Object error;
  final StackTrace stackTrace;
}

class FlowControllerV2 extends Notifier<FlowStatusV2> {
  FlowControllerV2();

  late final FlowNavigator _navigator = ref.read(flowNavigatorV2Provider);

  @override
  FlowStatusV2 build() {
    return const FlowIdleV2();
  }

  FlowSnapshotV2? get current =>
      state is FlowActiveV2 ? (state as FlowActiveV2).snapshot : null;

  bool get isRunning => state is FlowActiveV2;

  bool get isLoading =>
      state is FlowActiveV2 && (state as FlowActiveV2).isLoading;

  /// Start a flow from the beginning or from a specific step
  Future<void> start(
    FlowBlueprintV2 blueprint, {
    Map<String, Object?> initialData = const {},
    String? startAtStep,
  }) async {
    if (blueprint.steps.isEmpty) {
      throw ArgumentError('Flow "${blueprint.id}" must contain steps.');
    }

    final context = FlowContext(ref, _navigator, initialData);
    
    // Find starting index
    int startIndex = 0;
    if (startAtStep != null) {
      startIndex = blueprint.indexOfStep(startAtStep);
      if (startIndex < 0) {
        throw ArgumentError('Step "$startAtStep" not found in flow "${blueprint.id}"');
      }
    }

    final snapshot = FlowSnapshotV2(
      blueprint: blueprint,
      context: context,
      index: startIndex,
    );
    state = FlowActiveV2(snapshot);
    await _runStep(snapshot);
  }

  /// Complete the current step and advance to the next
  Future<void> completeStep({Map<String, Object?> output = const {}}) async {
    final snapshot = _requireActive();
    
    // Call onExit if defined
    if (snapshot.step.onExit != null) {
      await snapshot.step.onExit!(snapshot.context);
    }
    
    snapshot.context.writeAll(output);
    await _advance(snapshot);
  }

  /// Go back to the previous step
  Future<void> back() async {
    final snapshot = _requireActive();
    if (snapshot.index <= 0) {
      throw StateError('Cannot go back from the first step');
    }

    // Call onExit if defined
    if (snapshot.step.onExit != null) {
      await snapshot.step.onExit!(snapshot.context);
    }

    final previous = FlowSnapshotV2(
      blueprint: snapshot.blueprint,
      context: snapshot.context,
      index: snapshot.index - 1,
    );
    state = FlowActiveV2(previous);
    await _runStep(previous);
  }

  /// Cancel the current flow
  Future<void> cancel([Map<String, Object?> data = const {}]) async {
    final snapshot = current;
    state = const FlowIdleV2();
    if (snapshot != null) {
      snapshot.context.writeAll(data);
      await snapshot.blueprint.onCancel?.call(snapshot.context);
    }
  }

  /// Jump to a specific step by ID
  Future<void> jumpTo(String stepId) async {
    final snapshot = _requireActive();
    final targetIndex = snapshot.blueprint.indexOfStep(stepId);
    
    if (targetIndex < 0) {
      throw ArgumentError('Step "$stepId" not found in current flow');
    }

    // Call onExit if defined
    if (snapshot.step.onExit != null) {
      await snapshot.step.onExit!(snapshot.context);
    }

    final target = FlowSnapshotV2(
      blueprint: snapshot.blueprint,
      context: snapshot.context,
      index: targetIndex,
    );
    state = FlowActiveV2(target);
    await _runStep(target);
  }

  Future<void> _runStep(FlowSnapshotV2 snapshot) async {
    try {
      // Show loading for action steps if configured
      if (snapshot.step is FlowActionStepV2) {
        final actionStep = snapshot.step as FlowActionStepV2;
        if (actionStep.showLoading) {
          state = FlowActiveV2(
            snapshot,
            isLoading: true,
            loadingMessage: actionStep.loadingMessage,
          );
        }
      }

      await snapshot.step.enter(snapshot.context, _navigator);

      // Handle branching
      if (snapshot.step is FlowBranchStepV2) {
        final branchStep = snapshot.step as FlowBranchStepV2;
        final selectedBranch = branchStep.selector(snapshot.context);
        final branchSteps = branchStep.branches[selectedBranch];
        
        if (branchSteps == null) {
          throw StateError('Branch "$selectedBranch" not found in step "${branchStep.id}"');
        }

        // Create a sub-flow for the branch
        // For now, we'll just advance to the next step after the branch
        // In a full implementation, we'd need to handle branch execution
        await _advance(snapshot);
        return;
      }

      // Clear loading state
      if (state is FlowActiveV2 && (state as FlowActiveV2).isLoading) {
        state = FlowActiveV2(snapshot);
      }

      if (snapshot.step.completesImmediately) {
        await _advance(snapshot);
      }
    } catch (err, st) {
      state = FlowFailedV2(snapshot, err, st);
    }
  }

  Future<void> _advance(FlowSnapshotV2 snapshot) async {
    final nextIndex = snapshot.index + 1;
    if (nextIndex >= snapshot.blueprint.steps.length) {
      state = FlowCompletedV2(snapshot.blueprint, snapshot.context);
      await snapshot.blueprint.onFinish?.call(snapshot.context);
      return;
    }
    final next = FlowSnapshotV2(
      blueprint: snapshot.blueprint,
      context: snapshot.context,
      index: nextIndex,
    );
    state = FlowActiveV2(next);
    await _runStep(next);
  }

  FlowSnapshotV2 _requireActive() {
    final snapshot = current;
    if (snapshot == null) {
      throw StateError('Flow is not running. Call start() first.');
    }
    return snapshot;
  }
}
