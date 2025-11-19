import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'flow_blueprint_v2.dart';
import 'flow_controller_v2.dart';

/// Enhanced visual container for flows with support for different presentation styles
class FlowShellV2 extends ConsumerWidget {
  const FlowShellV2({
    super.key,
    required this.child,
    this.presentation = FlowPresentationStyle.fullscreen,
    this.padding = const EdgeInsets.all(24),
    this.showProgress = false,
    this.showBackButton = false,
    this.onBackPressed,
  });

  final Widget child;
  final FlowPresentationStyle presentation;
  final EdgeInsetsGeometry padding;
  final bool showProgress;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowState = ref.watch(flowControllerV2Provider);

    // Show loading overlay if needed
    Widget content = child;
    if (flowState is FlowActiveV2 && flowState.isLoading) {
      content = Stack(
        children: [
          child,
          _buildLoadingOverlay(context, flowState.loadingMessage),
        ],
      );
    }

    // Add progress indicator if enabled
    if (showProgress && flowState is FlowActiveV2) {
      content = Column(
        children: [
          _buildProgressIndicator(context, flowState.snapshot),
          Expanded(child: content),
        ],
      );
    }

    // Apply presentation style
    return switch (presentation) {
      FlowPresentationStyle.fullscreen => _buildFullscreen(context, content),
      FlowPresentationStyle.card => _buildCard(context, content),
      FlowPresentationStyle.sheet => _buildSheet(context, content),
      FlowPresentationStyle.inline => content,
    };
  }

  Widget _buildFullscreen(BuildContext context, Widget content) {
    return Scaffold(
      appBar: showBackButton ? _buildAppBar(context) : null,
      body: content,
    );
  }

  Widget _buildCard(BuildContext context, Widget content) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showBackButton) _buildCardBackButton(context),
                  Flexible(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        child: content,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSheet(BuildContext context, Widget content) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return isWide ? _buildCard(context, content) : _buildBottomSheet(context, content);
  }

  Widget _buildBottomSheet(BuildContext context, Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSheetHandle(context),
          if (showBackButton) _buildSheetBackButton(context),
          Flexible(child: content),
        ],
      ),
    );
  }

  Widget _buildSheetHandle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed,
      ),
      elevation: 0,
    );
  }

  Widget _buildCardBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
      ),
    );
  }

  Widget _buildSheetBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBackPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, FlowSnapshotV2 snapshot) {
    final progress = snapshot.progress;
    final stepLabel = snapshot.step.label ?? snapshot.step.id;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${snapshot.index + 1}/${snapshot.blueprint.totalSteps}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            stepLabel,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay(BuildContext context, String? message) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget that listens to flow state and renders appropriate UI
class FlowStateBuilder extends ConsumerWidget {
  const FlowStateBuilder({
    super.key,
    required this.onIdle,
    required this.onActive,
    this.onCompleted,
    this.onFailed,
  });

  final Widget Function() onIdle;
  final Widget Function(FlowSnapshotV2 snapshot, bool isLoading) onActive;
  final Widget Function(FlowBlueprintV2 blueprint)? onCompleted;
  final Widget Function(Object error, StackTrace stackTrace)? onFailed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowState = ref.watch(flowControllerV2Provider);

    return switch (flowState) {
      FlowIdleV2() => onIdle(),
      FlowActiveV2(:final snapshot, :final isLoading) => 
        onActive(snapshot, isLoading),
      FlowCompletedV2(:final blueprint) =>
        onCompleted?.call(blueprint) ?? onIdle(),
      FlowFailedV2(:final error, :final stackTrace) =>
        onFailed?.call(error, stackTrace) ?? 
        _buildErrorWidget(context, error, stackTrace),
    };
  }

  Widget _buildErrorWidget(BuildContext context, Object error, StackTrace stackTrace) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Flow Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
