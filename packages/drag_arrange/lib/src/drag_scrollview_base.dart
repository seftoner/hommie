import 'package:flutter/widgets.dart';
import 'models.dart';
import 'drag_callbacks.dart';
import 'scroll_view_options.dart';

/// Base class for reorderable scroll views
abstract class DragScrollViewBase extends StatefulWidget {
  final bool enableReordering;
  final List<DragListItem> children;
  final bool isLongPressDraggable;
  final Widget Function(DragListItem, Widget, Size)? buildFeedback;
  final Axis? axis;
  final DragCallbacks<DragListItem> dragCallbacks;
  final HitTestBehavior hitTestBehavior;
  final ScrollController? scrollController;
  final bool isDragNotification;
  final double draggingWidgetOpacity;
  final double edgeScroll;
  final int edgeScrollSpeedMilliseconds;
  final List<DragListItem>? isNotDragList;
  final BoxDecoration? dragChildBoxDecoration;
  final ScrollViewOptions scrollViewOptions;

  const DragScrollViewBase({
    super.key,
    this.enableReordering = false,
    required this.children,
    required this.isLongPressDraggable,
    this.buildFeedback,
    this.axis,
    this.dragCallbacks = const DragCallbacks(),
    this.hitTestBehavior = HitTestBehavior.translucent,
    this.scrollController,
    this.isDragNotification = false,
    this.draggingWidgetOpacity = 0.5,
    this.edgeScroll = 0.1,
    this.edgeScrollSpeedMilliseconds = 100,
    this.isNotDragList,
    this.dragChildBoxDecoration,
    this.scrollViewOptions = const ScrollViewOptions(),
  });
}
