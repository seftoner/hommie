import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import 'flow_navigation.dart';

/// Enhanced flow builder API inspired by iOS/Android navigation patterns
/// Provides better DX with shell-aware navigation and flexible presentation

typedef FlowGuard = FutureOr<bool> Function(FlowContext context);
typedef FlowCallback = FutureOr<void> Function(FlowContext context);
typedef FlowAction = FutureOr<void> Function(FlowContext context);

/// Presentation style for the flow (inspired by iOS UIModalPresentationStyle)
enum FlowPresentationStyle {
  /// Full screen presentation
  fullscreen,

  /// Card/modal presentation with constrained size
  card,

  /// Sheet presentation (bottom sheet on mobile, card on desktop)
  sheet,

  /// Inline presentation within existing navigation hierarchy
  inline,
}

/// Navigation mode for route steps
enum RouteNavigationMode {
  /// Replace current route (go_router's go)
  replace,

  /// Push onto navigation stack (go_router's push)
  push,
}

/// Runtime context shared across the steps of a flow
class FlowContext {
  FlowContext(this.ref, this.navigator, [Map<String, Object?>? initialData])
      : data = {...?initialData};

  final Ref ref;
  final FlowNavigator navigator;
  final Map<String, Object?> data;

  /// Underlying navigation context (null when the widget tree is not ready)
  BuildContext? get navigationContext => navigator.context;

  /// Read a Riverpod provider
  T read<T>(ProviderListenable<T> provider) => ref.read(provider);

  /// Persist arbitrary data for later steps
  void write(String key, Object? value) => data[key] = value;

  /// Persist multiple values at once
  void writeAll(Map<String, Object?> values) => data.addAll(values);

  /// Read a value as a specific type (returns null when missing)
  T? readValue<T>(String key) => data[key] as T?;

  /// Read a value as a specific type or throw a [StateError]
  T expectValue<T>(String key) {
    final value = readValue<T>(key);
    if (value == null) {
      throw StateError('Flow context missing "$key"');
    }
    return value;
  }
}

/// Base class for any flow step
abstract class FlowStepV2 {
  const FlowStepV2({
    required this.id,
    this.label,
    this.canEnter,
    this.onEnter,
    this.onExit,
  });

  /// Unique identifier for this step
  final String id;

  /// Human-readable label for progress tracking
  final String? label;

  /// Optional guard to check if this step can be entered
  final FlowGuard? canEnter;

  /// Optional callback when entering this step
  final FlowCallback? onEnter;

  /// Optional callback when exiting this step
  final FlowCallback? onExit;

  Future<bool> _passesGuard(FlowContext context) async {
    if (canEnter == null) return true;
    return await canEnter!(context);
  }

  Future<void> enter(FlowContext context, FlowNavigator navigator);

  /// Indicates whether this step finishes as soon as [enter] completes
  bool get completesImmediately => false;
}

/// A flow step that navigates to a page
/// Supports both typed routes and dynamic route generation
class FlowRouteStepV2 extends FlowStepV2 {
  const FlowRouteStepV2({
    required super.id,
    super.label,
    this.routeBuilder,
    this.pageBuilder,
    this.mode = RouteNavigationMode.replace,
    super.canEnter,
    super.onEnter,
    super.onExit,
  }) : assert(
          routeBuilder != null || pageBuilder != null,
          'Either routeBuilder or pageBuilder must be provided',
        );

  /// Builder for typed GoRouteData (preferred for type safety)
  final GoRouteData Function(FlowContext context)? routeBuilder;

  /// Builder for inline page definition (useful when you don't want route duplication)
  final Widget Function(BuildContext context, FlowContext flowContext)? pageBuilder;

  /// Navigation mode (replace or push)
  final RouteNavigationMode mode;

  @override
  Future<void> enter(FlowContext context, FlowNavigator navigator) async {
    if (!await _passesGuard(context)) {
      return;
    }
    if (onEnter != null) {
      await onEnter!(context);
    }

    // If we have a page builder, we'll navigate to a dynamic route
    // Otherwise use the typed route
    if (pageBuilder != null) {
      // Dynamic page - the FlowShell will handle rendering
      return;
    }

    final route = routeBuilder!(context);
    switch (mode) {
      case RouteNavigationMode.replace:
        await navigator.goTo(route);
        break;
      case RouteNavigationMode.push:
        await navigator.push(route);
        break;
    }
  }
}

/// A flow step that runs an action without navigation
class FlowActionStepV2 extends FlowStepV2 {
  const FlowActionStepV2({
    required super.id,
    super.label,
    required this.action,
    this.autoComplete = true,
    this.showLoading = false,
    this.loadingMessage,
    super.canEnter,
    super.onEnter,
    super.onExit,
  });

  /// The action to execute
  final FlowAction action;

  /// Whether to automatically advance to the next step after completion
  final bool autoComplete;

  /// Whether to show a loading indicator while the action runs
  final bool showLoading;

  /// Optional message to show in the loading indicator
  final String? loadingMessage;

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

/// A flow step that provides a fork in the flow
/// Useful for conditional navigation
class FlowBranchStepV2 extends FlowStepV2 {
  const FlowBranchStepV2({
    required super.id,
    super.label,
    required this.branches,
    required this.selector,
    super.canEnter,
    super.onEnter,
    super.onExit,
  });

  /// Map of branch IDs to their step sequences
  final Map<String, List<FlowStepV2>> branches;

  /// Function that selects which branch to take
  final String Function(FlowContext context) selector;

  @override
  Future<void> enter(FlowContext context, FlowNavigator navigator) async {
    if (!await _passesGuard(context)) {
      return;
    }
    if (onEnter != null) {
      await onEnter!(context);
    }
    // Branch selection is handled by the flow controller
  }

  @override
  bool get completesImmediately => false;
}

/// Enhanced blueprint describing a complete flow
class FlowBlueprintV2 {
  const FlowBlueprintV2({
    required this.id,
    required this.steps,
    this.description,
    this.presentation = FlowPresentationStyle.fullscreen,
    this.shellPath,
    this.onFinish,
    this.onCancel,
  });

  /// Unique identifier for this flow
  final String id;

  /// List of steps in this flow
  final List<FlowStepV2> steps;

  /// Human-readable description
  final String? description;

  /// How this flow should be presented
  final FlowPresentationStyle presentation;

  /// Optional shell route path (e.g., '/onboarding', '/settings/servers/add')
  /// When provided, routes will be scoped under this path
  final String? shellPath;

  /// Callback when flow completes successfully
  final FlowCallback? onFinish;

  /// Callback when flow is cancelled
  final FlowCallback? onCancel;

  /// Get step by ID
  FlowStepV2? stepById(String id) {
    try {
      return steps.firstWhere((step) => step.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get step index by ID
  int indexOfStep(String id) {
    return steps.indexWhere((step) => step.id == id);
  }

  /// Total number of steps (useful for progress tracking)
  int get totalSteps => steps.length;

  /// Get all step IDs (useful for progress tracking)
  List<String> get stepIds => steps.map((step) => step.id).toList();
}

/// A runtime snapshot of an executing flow
class FlowSnapshotV2 {
  FlowSnapshotV2({
    required this.blueprint,
    required this.context,
    required this.index,
  });

  final FlowBlueprintV2 blueprint;
  final FlowContext context;
  final int index;

  FlowStepV2 get step => blueprint.steps[index];
  bool get isLastStep => index >= blueprint.steps.length - 1;
  bool get isFirstStep => index == 0;

  /// Progress as a percentage (0.0 to 1.0)
  double get progress => (index + 1) / blueprint.steps.length;
}
