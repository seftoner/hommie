import 'dart:async';

import 'package:flutter/material.dart';

import 'drag_callbacks.dart';
import 'drag_item.dart';
import 'drag_notification.dart';
import 'models.dart';
import 'render_box_size.dart';
import 'widgets/shakeConstant/shake_default_constant.dart';
import 'widgets/shake_widget.dart';

typedef DraggableWidget = Widget Function(Widget child);
typedef DragTargetOn<T> = Widget Function(T? moveData, T data);

/// A widget that allows for drag-and-drop functionality within a list of items.
///
/// The [DragContainer] widget is designed to manage drag-and-drop interactions
/// between a list of items and provide callbacks for various drag-related events.
///
/// - [buildItems]: A function that takes a list of child widgets and builds the
///   main list of draggable items.
/// - [items]: A function that defines the draggable items using the provided data
///   and a drag handle.
/// - [dataList]: A list of data items that correspond to the draggable widgets.
/// - [isLongPressDraggable]: Whether dragging is initiated by a long press.
/// - [axis]: The primary axis along which the items should be arranged.
/// - [onAccept]: A callback function that is called when a draggable item is
///   accepted in a drop target.
/// - [onWillAccept]: A callback function that determines if a drop target will
///   accept a draggable item.
/// - [onLeave]: A callback function that is called when a draggable item leaves
///   a drop target.
/// - [onMove]: A callback function that is called when a draggable item is moved
///   within the drop target.
/// - [scrollDirection]: The direction of scrolling, either vertical or horizontal.
/// - [hitTestBehavior]: The hit test behavior used to determine the target of
///   a drag event.
/// - [onDragStarted]: A callback function called when a drag operation starts.
/// - [onDragUpdate]: A callback function called when a draggable item is being
///   updated during a drag operation.
/// - [onDraggableCanceled]: A callback function called when a draggable item is
///   canceled during a drag operation.
/// - [onDragEnd]: A callback function called when a drag operation ends.
/// - [onDragCompleted]: A callback function called when a draggable item has
///   completed its drag operation.
/// - [scrollController]: The controller for the scrollable view, if applicable.
/// - [isDragNotification]: A boolean indicating whether to use drag notification
///   to detect scroll actions.
/// - [draggingWidgetOpacity]: The opacity of the draggable item while it's being
///   dragged.
/// - [edgeScroll]: The proportion of the screen size used for edge scrolling.
/// - [edgeScrollSpeedMilliseconds]: The duration of edge scrolling in milliseconds.
/// - [isDrag]: A boolean indicating whether drag-and-drop functionality is enabled.
/// - [isNotDragList]: A list of items that should not be draggable.
///
/// To enable drag-and-drop functionality, wrap the list of items with [DragContainer]
/// and provide the necessary callbacks for managing the drag-and-drop operations.
class DragContainer<T extends DragListItem> extends StatefulWidget {
  final Widget Function(List<Widget> children) buildItems;
  final Widget Function(T data, DraggableWidget draggableWidget) items;
  final List<T> dataList;
  final Widget Function(T data, Widget child, Size size)? buildFeedback;
  final bool isLongPressDraggable;
  final Axis? axis;
  final Axis scrollDirection;
  final HitTestBehavior hitTestBehavior;
  final ScrollController? scrollController;
  final bool isDragNotification;
  final double draggingWidgetOpacity;
  final double edgeScroll;
  final int edgeScrollSpeedMilliseconds;
  final bool isDrag;
  final List<T>? isNotDragList;
  final BoxDecoration? dragChildBoxDecoration;
  final bool enableShakeAnimation;
  final DragCallbacks<T> dragCallbacks;

  const DragContainer({
    required this.buildItems,
    required this.dataList,
    required this.items,
    this.isLongPressDraggable = true,
    this.buildFeedback,
    this.axis,
    this.hitTestBehavior = HitTestBehavior.translucent,
    this.scrollDirection = Axis.vertical,
    this.scrollController,
    this.isDragNotification = false,
    this.draggingWidgetOpacity = 0.5,
    this.edgeScroll = 0.1,
    this.edgeScrollSpeedMilliseconds = 100,
    this.isDrag = true,
    this.isNotDragList,
    this.dragChildBoxDecoration,
    this.enableShakeAnimation = false,
    this.dragCallbacks = const DragCallbacks(),
    super.key,
  });

  @override
  State<DragContainer> createState() => _DragContainerState();
}

class _DragContainerState<T extends DragListItem> extends State<DragContainer> {
  Timer? _timer;
  Timer? _scrollableTimer;
  ScrollableState? _scrollable;
  AnimationStatus status = AnimationStatus.completed;
  bool isDragStart = false;
  T? dragData;
  Map<T, Size> mapSize = <T, Size>{};
  AcceptDetails? acceptDetails;
  int? originalindex;

  void endWillAccept() {
    _timer?.cancel();
    acceptDetails = null;
  }

  void setDragStart({bool isDragStart = true}) {
    if (this.isDragStart != isDragStart) {
      setState(() {
        this.isDragStart = isDragStart;
        if (!this.isDragStart) {
          dragData = null;
        } else {
          if (dragData != null) {
            originalindex = widget.dataList.indexOf(dragData!);
          }
          endWillAccept();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.dataList.map((e) => setDraggable(e as T)).toList();
    if (widget.isDragNotification) {
      return DragNotification(
        child: widget.buildItems(items),
      );
    } else {
      return widget.buildItems(items);
    }
  }

  @override
  void didUpdateWidget(DragContainer<DragListItem> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final List<T> delete = <T>[];
    mapSize.forEach((T key, Size value) {
      if (!widget.dataList.contains(key)) {
        delete.add(key);
      }
    });
    mapSize.removeWhere((T key, Size value) => delete.contains(key));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.scrollController == null) {
      try {
        _scrollable = Scrollable.of(context);
      } catch (e, s) {
        debugPrint('No scrollController found!, $e \n $s');
      }
    }
  }

  void setWillAccept(T? moveData, T data, {bool isFront = true}) {
    if (moveData == data) {
      return;
    }
    if (status == AnimationStatus.completed) {
      endWillAccept();
      _timer = Timer(const Duration(milliseconds: 200), () {
        if (!DragNotification.isScroll) {
          if (widget.dragCallbacks.onWillAccept != null) {
            widget.dragCallbacks.onWillAccept
                ?.call(moveData, data, isFront, acceptDetails: acceptDetails);
          } else if (moveData != null) {
            final int oldIndex = widget.dataList.indexOf(moveData);
            int newIndex = widget.dataList.indexOf(data);
            setState(() {
              if (isFront) {
                widget.dataList.removeAt(oldIndex);
                widget.dataList.insert(newIndex, moveData);
              } else {
                widget.dataList.removeAt(oldIndex);
                if (newIndex + 1 < widget.dataList.length) {
                  newIndex += 1;
                  widget.dataList.insert(newIndex, moveData);
                } else {
                  widget.dataList.insert(newIndex, moveData);
                }
              }
            });
            acceptDetails =
                AcceptDetails(oldIndex: originalindex!, newIndex: newIndex);
          }
        }
      });
    }
  }

  bool isContains(T data) {
    if (widget.isNotDragList?.toList() != null) {
      return widget.isNotDragList!.toList().contains(data);
    }
    return false;
  }

  Size getRenderBoxSize(T? date) {
    return mapSize[date] ?? Size.zero;
  }

  Widget getSizedBox(T data, Widget child) {
    final Size size = getRenderBoxSize(data);
    return SizedBox(
      width: size.width / (widget.scrollDirection == Axis.horizontal ? 2 : 1),
      height: size.height / (widget.scrollDirection == Axis.vertical ? 2 : 1),
      child: child,
    );
  }

  Widget setDragScope(T data, Widget child) {
    final Widget keyWidget = child;
    return DragItem(
        child: Stack(
          children: [
            if (isDragStart &&
                dragData == data &&
                widget.draggingWidgetOpacity > 0)
              AnimatedOpacity(
                opacity: widget.draggingWidgetOpacity,
                duration: const Duration(milliseconds: 300),
                child: keyWidget,
              )
            else
              Visibility(
                maintainState: true,
                visible: dragData != data,
                child: widget.enableShakeAnimation && widget.isDrag
                    ? ShakeWidget(
                        shakeConstant: RandomShakeConstant(
                          offsetX: const ShakeRange(min: -1.5, max: 1.5),
                          offsetY: const ShakeRange(min: -1.5, max: 1.5),
                          rotation: const ShakeRange(min: -0.3, max: 1.5),
                        ),
                        enabled: true,
                        child: keyWidget,
                      )
                    : keyWidget,
              ),
            if (isDragStart && !isContains(data))
              Flex(
                direction: widget.scrollDirection,
                children: <Widget>[
                  getSizedBox(
                    data,
                    DragTarget<T>(
                        onWillAcceptWithDetails:
                            (DragTargetDetails<T> details) {
                          setWillAccept(details.data, data);
                          return true;
                        },
                        onAcceptWithDetails: widget.dragCallbacks.onAccept == null
                            ? null
                            : (DragTargetDetails<T> details) => widget
                                .dragCallbacks.onAccept
                                ?.call(details.data, data, true,
                                    acceptDetails: acceptDetails),
                        onLeave: widget.dragCallbacks.onLeave == null
                            ? null
                            : (T? moveData) => widget.dragCallbacks.onLeave
                                ?.call(moveData, data, true),
                        onMove: widget.dragCallbacks.onMove == null
                            ? null
                            : (DragTargetDetails<T> details) => widget
                                .dragCallbacks.onMove
                                ?.call(data, details, true),
                        hitTestBehavior: widget.hitTestBehavior,
                        builder: (BuildContext context, List<T?> candidateData,
                            List<dynamic> rejectedData) {
                          return Container(color: Colors.transparent);
                        }),
                  ),
                  getSizedBox(
                    data,
                    DragTarget<T>(
                        onWillAcceptWithDetails:
                            (DragTargetDetails<T> details) {
                          setWillAccept(details.data, data, isFront: false);
                          return true;
                        },
                        onAcceptWithDetails: widget.dragCallbacks.onAccept == null
                            ? null
                            : (DragTargetDetails<T> details) => widget
                                .dragCallbacks.onAccept
                                ?.call(details.data, data, false,
                                    acceptDetails: acceptDetails),
                        onLeave: widget.dragCallbacks.onLeave == null
                            ? null
                            : (T? moveData) => widget.dragCallbacks.onLeave
                                ?.call(moveData, data, false),
                        onMove: widget.dragCallbacks.onMove == null
                            ? null
                            : (DragTargetDetails<T> details) => widget
                                .dragCallbacks.onMove
                                ?.call(data, details, false),
                        hitTestBehavior: widget.hitTestBehavior,
                        builder: (BuildContext context, List<T?> candidateData,
                            List<dynamic> rejectedData) {
                          return Container(color: Colors.transparent);
                        }),
                  ),
                ],
              ),
          ],
        ),
        onAnimationStatus: (AnimationStatus status) => this.status = status);
  }

  Widget setDraggable(T data) {
    final Widget draggable = widget.items(data, (Widget father) {
      Widget child = setDragScope(data, father);

      // Then apply drag functionality
      if (widget.isDrag && !isContains(data)) {
        if (widget.isLongPressDraggable) {
          child = LongPressDraggable<T>(
            feedback: setFeedback(data, father),
            axis: widget.axis,
            data: data,
            onDragStarted: () {
              dragData = data;
              setDragStart();
              widget.dragCallbacks.onDragStarted?.call(data);
            },
            onDragUpdate: (DragUpdateDetails details) {
              _autoScrollIfNecessary(details.globalPosition, father);
              widget.dragCallbacks.onDragUpdate?.call(details, data);
            },
            onDraggableCanceled: (Velocity velocity, Offset offset) {
              setDragStart(isDragStart: false);
              endAnimation();
              widget.dragCallbacks.onDraggableCanceled
                  ?.call(velocity, offset, data);
            },
            onDragEnd: (details) {
              setDragStart(isDragStart: false);
              widget.dragCallbacks.onDragEnd?.call(details, data);
            },
            onDragCompleted: () {
              setDragStart(isDragStart: false);
              endAnimation();
              widget.dragCallbacks.onDragCompleted?.call(data);
            },
            child: child,
          );
        } else {
          child = Draggable<T>(
            feedback: setFeedback(data, father),
            axis: widget.axis,
            data: data,
            onDragStarted: () {
              dragData = data;
              setDragStart();
              widget.dragCallbacks.onDragStarted?.call(data);
            },
            onDragUpdate: (DragUpdateDetails details) {
              _autoScrollIfNecessary(details.globalPosition, father);
              widget.dragCallbacks.onDragUpdate?.call(details, data);
            },
            onDraggableCanceled: (Velocity velocity, Offset offset) {
              setDragStart(isDragStart: false);
              endAnimation();
              widget.dragCallbacks.onDraggableCanceled
                  ?.call(velocity, offset, data);
            },
            onDragEnd: (DraggableDetails details) {
              setDragStart(isDragStart: false);
              widget.dragCallbacks.onDragEnd?.call(details, data);
            },
            onDragCompleted: () {
              setDragStart(isDragStart: false);
              endAnimation();
              widget.dragCallbacks.onDragCompleted?.call(data);
            },
            child: child,
          );
        }
      }
      return child;
    });

    return RenderBoxSize(
      draggable,
      (Size size) {
        mapSize[data] = size;
        if (mapSize.length == widget.dataList.length) {
          setState(() {});
        }
      },
      key: ValueKey<T>(data),
    );
  }

  Widget setFeedback(T data, Widget e) {
    final Size size = getRenderBoxSize(data);
    final Widget child = Container(
      width: size.width,
      height: size.height,
      decoration: widget.dragChildBoxDecoration,
      child: e,
    );
    return widget.buildFeedback?.call(data, child, size) ?? child;
  }

  void _autoScrollIfNecessary(Offset details, Widget father) {
    if (status != AnimationStatus.completed) {
      return;
    }
    if (_scrollable == null && widget.scrollController == null) {
      debugPrint('_scrollable == null && widget.scrollController == null');
      return;
    }
    final RenderBox scrollRenderBox;
    if (_scrollable != null) {
      scrollRenderBox = _scrollable!.context.findRenderObject()! as RenderBox;
    } else {
      scrollRenderBox = context.findRenderObject()! as RenderBox;
    }
    final Offset scrollOrigin = scrollRenderBox.localToGlobal(Offset.zero);
    final double scrollStart =
        _offsetExtent(scrollOrigin, widget.scrollDirection);
    final double scrollEnd =
        scrollStart + _sizeExtent(scrollRenderBox.size, widget.scrollDirection);
    final double currentOffset = _offsetExtent(details, widget.scrollDirection);
    final double mediaQuery =
        _sizeExtent(MediaQuery.of(context).size, widget.scrollDirection) *
            widget.edgeScroll;
    if (currentOffset < (scrollStart + mediaQuery)) {
      animateTo(mediaQuery, isNext: false);
    } else if (currentOffset > (scrollEnd - mediaQuery)) {
      animateTo(mediaQuery);
    } else {
      endAnimation();
    }
  }

  void animateTo(double mediaQuery, {bool isNext = true}) {
    final ScrollPosition position =
        _scrollable?.position ?? widget.scrollController!.position;
    endAnimation();
    if (isNext && position.pixels >= position.maxScrollExtent) {
      return;
    } else if (!isNext && position.pixels <= position.minScrollExtent) {
      return;
    }
    DragNotification.isScroll = true;
    _scrollableTimer = Timer.periodic(
        Duration(milliseconds: widget.edgeScrollSpeedMilliseconds),
        (Timer timer) {
      if (isNext && position.pixels >= position.maxScrollExtent) {
        endAnimation();
      } else if (!isNext && position.pixels <= position.minScrollExtent) {
        endAnimation();
      } else {
        endWillAccept();
        position.animateTo(
          position.pixels + (isNext ? mediaQuery : -mediaQuery),
          duration: Duration(milliseconds: widget.edgeScrollSpeedMilliseconds),
          curve: Curves.linear,
        );
      }
    });
  }

  void endAnimation() {
    DragNotification.isScroll = false;
    _scrollableTimer?.cancel();
  }

  double _offsetExtent(Offset offset, Axis scrollDirection) {
    switch (scrollDirection) {
      case Axis.horizontal:
        return offset.dx;
      case Axis.vertical:
        return offset.dy;
    }
  }

  double _sizeExtent(Size size, Axis scrollDirection) {
    switch (scrollDirection) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  @override
  void dispose() {
    endWillAccept();
    endAnimation();
    endWillAccept();
    super.dispose();
  }
}
