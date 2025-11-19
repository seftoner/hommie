import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import 'flow_navigation.dart';

typedef FlowGuard = FutureOr<bool> Function(FlowContext context);
typedef FlowCallback = FutureOr<void> Function(FlowContext context);
typedef FlowAction = FutureOr<void> Function(FlowContext context);
typedef FlowRouteFactory = GoRouteData Function(FlowContext context);

/// Describes the concrete navigation routes that a flow should use for its
/// shared steps (e.g. discovery vs. manual entry).
class FlowRoutePass {
  FlowRoutePass({required this.discoveryRoute, required this.manualEntryRoute});

  final FlowRouteFactory discoveryRoute;
  final FlowRouteFactory manualEntryRoute;
}

enum FlowPresentation { go, push }

/// Runtime context shared across the steps of a flow.
class FlowContext {
  FlowContext(this.ref, this.navigator, [Map<String, Object?>? initialData])
    : data = {...?initialData};

  final Ref ref;
  final FlowNavigator navigator;
  final Map<String, Object?> data;

  /// Underlying navigation context (null when the widget tree is not ready).
  BuildContext? get navigationContext => navigator.context;

  /// Read a Riverpod provider.
  T read<T>(ProviderListenable<T> provider) => ref.read(provider);

  /// Persist arbitrary data for later steps.
  void write(String key, Object? value) => data[key] = value;

  /// Persist multiple values at once.
  void writeAll(Map<String, Object?> values) => data.addAll(values);

  /// Read a value as a specific type (returns null when missing).
  T? readValue<T>(String key) => data[key] as T?;

  /// Read a value as a specific type or throw a [StateError].
  T expectValue<T>(String key) {
    final value = readValue<T>(key);
    if (value == null) {
      throw StateError('Flow context missing "$key"');
    }
    return value;
  }
}

/// Base class for any flow step.
abstract class FlowStep {
  const FlowStep({required this.id, this.canEnter, this.onEnter});

  final String id;
  final FlowGuard? canEnter;
  final FlowCallback? onEnter;

  Future<bool> _passesGuard(FlowContext context) async {
    if (canEnter == null) return true;
    return await canEnter!(context);
  }

  Future<void> enter(FlowContext context, FlowNavigator navigator);

  /// Indicates whether this step finishes as soon as [enter] completes.
  bool get completesImmediately => false;
}

/// A flow step that navigates to a page.
class FlowRouteStep extends FlowStep {
  const FlowRouteStep({
    required super.id,
    required this.routeBuilder,
    this.presentation = FlowPresentation.go,
    super.canEnter,
    super.onEnter,
  });

  final GoRouteData Function(FlowContext context) routeBuilder;
  final FlowPresentation presentation;

  @override
  Future<void> enter(FlowContext context, FlowNavigator navigator) async {
    if (!await _passesGuard(context)) {
      return;
    }
    if (onEnter != null) {
      await onEnter!(context);
    }
    final route = routeBuilder(context);
    switch (presentation) {
      case FlowPresentation.go:
        await navigator.goTo(route);
        break;
      case FlowPresentation.push:
        await navigator.push(route);
        break;
    }
  }
}

/// A flow step that runs an action without navigation.
class FlowActionStep extends FlowStep {
  const FlowActionStep({
    required super.id,
    required this.action,
    this.autoComplete = true,
    super.canEnter,
    super.onEnter,
  });

  final FlowAction action;
  final bool autoComplete;

  @override
  Future<void> enter(FlowContext context, FlowNavigator navigator) async {
    if (!await _passesGuard(context)) {
      return;
    }
    if (onEnter != null) {
      await onEnter!(context);
    }
    await action(context);
  }

  @override
  bool get completesImmediately => autoComplete;
}

/// Blueprint describing a complete flow.
class FlowBlueprint {
  const FlowBlueprint({
    required this.id,
    required this.steps,
    this.description,
    this.onFinish,
    this.onCancel,
  });

  final String id;
  final List<FlowStep> steps;
  final String? description;
  final FlowCallback? onFinish;
  final FlowCallback? onCancel;
}

/// A runtime snapshot of an executing flow.
class FlowSnapshot {
  FlowSnapshot({
    required this.blueprint,
    required this.context,
    required this.index,
  });

  final FlowBlueprint blueprint;
  final FlowContext context;
  final int index;

  FlowStep get step => blueprint.steps[index];
  bool get isLastStep => index >= blueprint.steps.length - 1;
}
