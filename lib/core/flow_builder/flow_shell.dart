import 'package:flutter/material.dart';

/// Visual container that can host a flow either fullscreen or inside a framed
/// surface (useful for onboarding modals or other embedded experiences).
enum FlowShellSize {
  fullscreen,
  constrainedCard,
}

class FlowShell extends StatelessWidget {
  const FlowShell({
    super.key,
    required this.child,
    this.size = FlowShellSize.fullscreen,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final FlowShellSize size;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case FlowShellSize.fullscreen:
        return child;
      case FlowShellSize.constrainedCard:
        return Scaffold(
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
          body: SafeArea(
            child: Padding(
              padding: padding,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}
