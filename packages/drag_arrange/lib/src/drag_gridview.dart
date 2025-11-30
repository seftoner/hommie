import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'drag_container.dart';
import 'drag_notification.dart';
import 'models.dart';
import 'drag_scrollview_base.dart';

/// Grid view implementation
class DragGridView extends DragScrollViewBase {
  final int crossAxisCount;
  final AxisDirection? axisDirection;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final bool enableShakeAnimation;

  const DragGridView({
    super.key,
    super.enableReordering = false,
    required List<DragGridItem> super.children,
    required this.crossAxisCount,
    this.axisDirection,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    super.isLongPressDraggable = true,
    super.buildFeedback,
    super.axis,
    super.dragCallbacks,
    super.hitTestBehavior = HitTestBehavior.translucent,
    super.scrollController,
    super.isDragNotification = false,
    super.draggingWidgetOpacity = 0.5,
    super.edgeScroll = 0.1,
    super.edgeScrollSpeedMilliseconds = 500,
    super.isNotDragList,
    this.enableShakeAnimation = false,
    super.dragChildBoxDecoration,
    super.scrollViewOptions,
  });

  @override
  State<DragGridView> createState() => _ReorderableGridViewState();
}

class _ReorderableGridViewState extends State<DragGridView> {
  List<DragListItem> _children = const [];

  @override
  void initState() {
    super.initState();
    _children = widget.children;
  }

  @override
  void didUpdateWidget(DragGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children != oldWidget.children) {
      setState(() {
        _children = widget.children;
      });
    }
  }

  Widget buildContainer({
    required Widget Function(List<Widget>) buildItems,
  }) {
    return DragContainer(
      isDrag: widget.enableReordering,
      scrollDirection: widget.scrollViewOptions.scrollDirection,
      isLongPressDraggable: widget.isLongPressDraggable,
      buildItems: buildItems,
      buildFeedback: widget.buildFeedback,
      axis: widget.axis,
      dragChildBoxDecoration: widget.dragChildBoxDecoration,
      dragCallbacks: widget.dragCallbacks,
      hitTestBehavior: widget.hitTestBehavior,
      scrollController: widget.scrollController,
      isDragNotification: widget.isDragNotification,
      draggingWidgetOpacity: widget.draggingWidgetOpacity,
      edgeScroll: widget.edgeScroll,
      edgeScrollSpeedMilliseconds: widget.edgeScrollSpeedMilliseconds,
      isNotDragList: widget.isNotDragList,
      enableShakeAnimation: widget.enableShakeAnimation,
      items: (DragListItem element, DraggableWidget draggableWidget) {
        if (element is DragGridCountItem) {
          return StaggeredGridTile.count(
            key: ValueKey(element.key.toString()),
            mainAxisCellCount: element.mainAxisCellCount,
            crossAxisCellCount: element.crossAxisCellCount,
            child: draggableWidget(element.widget),
          );
        } else if (element is DragGridExtentItem) {
          return StaggeredGridTile.extent(
            key: ValueKey(element.key.toString()),
            mainAxisExtent: element.mainAxisExtent,
            crossAxisCellCount: element.crossAxisCellCount,
            child: draggableWidget(element.widget),
          );
        } else {
          throw FlutterError(
              'Item should be one of GridItem or GridExtentItem but it was ${element.runtimeType}');
        }
      },
      dataList: _children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragNotification(
      child: SingleChildScrollView(
        scrollDirection: widget.scrollViewOptions.scrollDirection,
        reverse: widget.scrollViewOptions.reverse,
        controller: widget.scrollViewOptions.controller,
        primary: widget.scrollViewOptions.primary,
        physics: widget.scrollViewOptions.physics,
        padding: widget.scrollViewOptions.padding,
        dragStartBehavior: widget.scrollViewOptions.dragStartBehavior,
        keyboardDismissBehavior:
            widget.scrollViewOptions.keyboardDismissBehavior,
        restorationId: widget.scrollViewOptions.restorationId,
        clipBehavior: widget.scrollViewOptions.clipBehavior,
        child: buildContainer(
          buildItems: (List<Widget> children) {
            return StaggeredGrid.count(
              crossAxisCount: widget.crossAxisCount,
              axisDirection: widget.axisDirection,
              mainAxisSpacing: widget.mainAxisSpacing,
              crossAxisSpacing: widget.crossAxisSpacing,
              children: children,
            );
          },
        ),
      ),
    );
  }
}
