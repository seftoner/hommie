// river_flow.dart
library river_flow;

import 'package:flutter/material.dart';

/// Signature for a builder that creates a page Widget for a given step.
///
/// You get:
/// - [BuildContext]
/// - [PageBuilder<T>] so you can call goTo/back/complete, etc.
typedef PageBuilder<T> =
    Widget Function(BuildContext context, FlowController<T> flow);

/// One logical step in the flow.
///
/// [T] is the type of the step id:
/// - String: 'welcome', 'permissions'
/// - enum: OnboardingStep.welcome, etc.
class FlowStep<T> {
  const FlowStep({required this.id, required this.builder, this.pageKey});

  /// Logical id of the step (string, enum, etc.).
  final T id;

  /// Builds the page widget for this step.
  final PageBuilder<T> builder;

  /// Optional key for the underlying Page.
  final LocalKey? pageKey;
}

/// Controller which operates on a *stack of step ids*.
///
/// Public API:
/// - [current] – current step id
/// - [stack] – read-only view of the whole stack
/// - [goTo] – push new step
/// - [back] – pop step
/// - [replaceCurrent] – change current step in place
/// - [resetTo] – drop everything, start from given step
/// - [complete] – mark flow as completed (RiverFlow will pop itself).
class FlowController<T> extends ChangeNotifier {
  FlowController(T initialStep) : _stack = <T>[initialStep];

  final List<T> _stack;

  /// Read-only stack of step ids.
  List<T> get stack => List.unmodifiable(_stack);

  /// Current step id (top of the stack).
  T get current => _stack.last;

  bool get canPop => _stack.length > 1;

  bool _completed = false;

  /// Whether the current flow has been completed.
  bool get completed => _completed;

  /// Push a new step onto the stack.
  void goTo(T step) {
    _stack.add(step);
    notifyListeners();
  }

  /// Pop one step (if possible).
  void back() {
    if (!canPop) {
      return;
    }
    _stack.removeLast();
    notifyListeners();
  }

  /// Internal: used by Navigator.onPopPage.
  void backFromNavigator() {
    if (!canPop) {
      return;
    }
    _stack.removeLast();
    notifyListeners();
  }

  /// Replace the current step without changing stack depth.
  void replaceCurrent(T step) {
    _stack[_stack.length - 1] = step;
    notifyListeners();
  }

  /// Drop everything and start again from [step].
  void resetTo(T step) {
    _stack
      ..clear()
      ..add(step);
    notifyListeners();
  }

  /// Complete the flow. Optionally transform the final step.
  ///
  /// Example:
  ///   flow.complete((current) => OnboardingStep.done);
  void complete([T Function(T current)? transform]) {
    _completed = true;
    if (transform != null) {
      final next = transform(current);
      _stack
        ..clear()
        ..add(next);
    }
    notifyListeners();
  }

  @mustCallSuper
  @override
  void addListener(VoidCallback listener) => super.addListener(listener);

  @mustCallSuper
  @override
  void removeListener(VoidCallback listener) => super.removeListener(listener);
}

/// A smart wrapper around [Navigator] that lets you think in terms of
/// logical steps instead of managing a list of Pages.
///
/// You declare:
///
/// ```dart
/// RiverFlow<OnboardingStep>(
///   initialStep: OnboardingStep.welcome,
///   steps: [
///     FlowStep(
///       id: OnboardingStep.welcome,
///       builder: (ctx, flow) => WelcomePage(
///         onContinue: () => flow.goTo(OnboardingStep.permissions),
///       ),
///     ),
///     FlowStep(
///       id: OnboardingStep.permissions,
///       builder: (ctx, flow) => PermissionsPage(
///         onBack: flow.back,
///         onContinue: () => flow.goTo(OnboardingStep.addServer),
///       ),
///     ),
///     FlowStep(
///       id: OnboardingStep.addServer,
///       builder: (ctx, flow) => AddServerFlow(
///         onDone: () => flow.complete(),
///       ),
///     ),
///   ],
///   onComplete: (finalStep) {
///     // e.g. go to main app
///   },
/// )
/// ```
///
/// Internally, it maintains a stack of step ids in [FlowController]
/// and maps that stack to [Navigator.pages].
class RiverFlow<T> extends StatefulWidget {
  const RiverFlow({
    super.key,
    required this.initialStep,
    required this.steps,
    this.controller,
    this.onComplete,
    this.observers = const <NavigatorObserver>[],
    this.clipBehavior = Clip.hardEdge,
  });

  /// First logical step id.
  final T initialStep;

  /// All possible steps in this flow.
  final List<FlowStep<T>> steps;

  /// Optional external controller.
  /// If null, RiverFlow creates and owns a controller internally.
  final FlowController<T>? controller;

  /// Called when flow is completed (controller.complete()).
  ///
  /// If null, RiverFlow will call:
  ///   Navigator.of(context).pop'<'T'>'(finalStep);
  final ValueChanged<T>? onComplete;

  final List<NavigatorObserver> observers;
  final Clip clipBehavior;

  @override
  State<RiverFlow<T>> createState() => _RiverFlowState<T>();
}

class _RiverFlowState<T> extends State<RiverFlow<T>> {
  late FlowController<T> _controller;
  late final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  FlowController<T> get _effectiveController => _controller;

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FlowController<T>(widget.initialStep);
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant RiverFlow<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      // Detach from old controller
      _controller.removeListener(_onControllerChanged);
      if (oldWidget.controller == null) {
        // We owned previous controller, dispose it.
        _controller.dispose();
      }

      // Attach to new controller or create a fresh one
      _controller = widget.controller ?? FlowController<T>(widget.initialStep);
      _controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (widget.controller == null) {
      // Only dispose if we own it
      _controller.dispose();
    }
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) {
      return;
    }

    if (_controller.completed) {
      _controller.removeListener(_onControllerChanged);
      final finalStep = _controller.current;

      if (widget.onComplete != null) {
        widget.onComplete!(finalStep);
      } else {
        Navigator.of(context).pop<T>(finalStep);
      }
      return;
    }

    setState(() {
      // pages will be rebuilt from updated stack
    });
  }

  FlowStep<T> _findStep(T id) {
    try {
      return widget.steps.firstWhere((s) => s.id == id);
    } catch (_) {
      throw FlutterError('No FlowStep found for id: $id');
    }
  }

  List<Page<dynamic>> _buildPages() {
    final stack = _controller.stack;
    return <Page<dynamic>>[
      for (final stepId in stack)
        MaterialPage<dynamic>(
          key: _findStep(stepId).pageKey ?? ValueKey(stepId),
          child: _findStep(stepId).builder(context, _controller),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();
    final canPopInsideFlow = _controller.canPop;

    return _RiverFlowScope<T>(
      controller: _effectiveController,
      child: _ConditionalPopScope(
        condition: canPopInsideFlow,
        child: Navigator(
          key: _navigatorKey,
          pages: pages,
          observers: widget.observers,
          clipBehavior: widget.clipBehavior,
          onDidRemovePage: (page) {
            _controller.backFromNavigator();
          },
        ),
      ),
    );
  }
}

/// Inherited widget for exposing the [FlowController] down the tree.
class _RiverFlowScope<T> extends InheritedWidget {
  const _RiverFlowScope({
    required this.controller,
    required super.child,
    super.key,
  });

  final FlowController<T> controller;

  static FlowController<T> of<T>(BuildContext context) {
    final inherited =
        context
                .getElementForInheritedWidgetOfExactType<_RiverFlowScope<T>>()
                ?.widget
            as _RiverFlowScope<T>?;

    if (inherited == null) {
      throw FlutterError(
        'context.riverFlow<$T>() called with a context that does not contain a RiverFlow<$T>.\n'
        'The context used was: $context',
      );
    }

    return inherited.controller;
  }

  @override
  bool updateShouldNotify(_RiverFlowScope<T> oldWidget) =>
      oldWidget.controller != controller;
}

/// Extension on [BuildContext] for easy access to the [FlowController].
extension RiverFlowX on BuildContext {
  FlowController<T> riverFlow<T>() => _RiverFlowScope.of<T>(this);
}

/// Simple helper around [PopScope] to prevent popping the parent route
/// when there are still inner flow pages to pop.
class _ConditionalPopScope extends StatelessWidget {
  const _ConditionalPopScope({required this.condition, required this.child});

  final bool condition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // When condition is true, we say "don't pop me (parent route),
    // let inner Navigator handle pops instead".
    return condition ? PopScope(canPop: false, child: child) : child;
  }
}
