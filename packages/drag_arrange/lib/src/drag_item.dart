import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'drag_notification.dart';

/// A widget that animates its child during drag-and-drop operations.
///
/// The [DragItem] widget animates its child using an implicit animation when
/// the child is dragged. It can be used to provide visual feedback during a drag
/// operation.
///
/// - [child]: The child widget that you want to animate during drag-and-drop.
/// - [duration]: The duration of the animation (default is 200 milliseconds).
/// - [onAnimationStatus]: An optional callback to listen for animation status changes.
///
/// To use this widget, wrap it around the widget you want to animate during drag
/// operations, and the animation will be triggered when necessary.
class DragItem extends ImplicitlyAnimatedWidget {
  const DragItem({
    required this.child,
    Duration? duration,
    this.onAnimationStatus,
    super.key,
  }) : super(duration: duration ?? _animDuration);
  final Widget child;
  final AnimationStatusListener? onAnimationStatus;
  static const Duration _animDuration = Duration(milliseconds: 200);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _DragItemState();
}

class _DragItemState extends AnimatedWidgetBaseState<DragItem> {
  RenderAnimManage renderAnimManage = RenderAnimManage();

  @override
  void initState() {
    super.initState();
    renderAnimManage.controller = controller;
    renderAnimManage.animation = animation;
    if (widget.onAnimationStatus != null) {
      controller.addStatusListener(widget.onAnimationStatus!);
    }
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {}

  void update() {
    controller
      ..value = 0.0
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return _DragAnimRender(
      renderAnimManage,
      animation.value,
      change: () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          update();
        });
      },
      child: widget.child,
    );
  }
}

class _DragAnimRender extends SingleChildRenderObjectWidget {
  const _DragAnimRender(
    this.renderAnimManage,
    this.update, {
    super.child,
    this.change,
  });
  final void Function()? change;
  final RenderAnimManage renderAnimManage;
  final double update;

  bool get isExecute => !DragNotification.isScroll;

  @override
  _AnimRenderObject createRenderObject(BuildContext context) {
    return _AnimRenderObject(renderAnimManage, update, change: change);
  }

  @override
  void updateRenderObject(
      BuildContext context, _AnimRenderObject renderObject) {
    if (isExecute && renderObject.update != update) {
      renderObject.markNeedsLayout();
    }
  }
}

class _AnimRenderObject extends RenderShiftedBox {
  _AnimRenderObject(
    this.renderAnimManage,
    this.update, {
    RenderBox? child,
    this.change,
  }) : super(child);
  final void Function()? change;
  final RenderAnimManage renderAnimManage;
  final double update;

  Offset? lastOffset;

  bool get isExecute => !DragNotification.isScroll;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return constraints.constrain(const Size(0, 0));
    }
    final BoxConstraints innerConstraints =
        constraints.deflate(EdgeInsets.zero);
    final Size childSize = child!.getDryLayout(innerConstraints);
    return constraints.constrain(Size(childSize.width, childSize.height));
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    if (child == null) {
      size = constraints.constrain(const Size(0, 0));
      return;
    }
    final BoxConstraints innerConstraints =
        constraints.deflate(EdgeInsets.zero);
    child!.layout(innerConstraints, parentUsesSize: true);
    final BoxParentData childParentData = child!.parentData! as BoxParentData;
    childParentData.offset = const Offset(0, 0);
    size = constraints.constrain(Size(
      child!.size.width,
      child!.size.height,
    ));
  }

  void setStart(EdgeInsetsGeometry? begin, EdgeInsetsGeometry? end) {
    renderAnimManage.tweenOffset =
        EdgeInsetsGeometryTween(begin: begin, end: end);
    change?.call();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      final Offset position = childParentData.offset + offset;
      renderAnimManage.currentOffset ??=
          EdgeInsets.only(left: position.dx, top: position.dy);
      if (renderAnimManage.controller.isAnimating &&
          renderAnimManage.tweenOffset != null) {
        final EdgeInsets geometry = renderAnimManage.tweenOffset!
            .evaluate(renderAnimManage.animation) as EdgeInsets;
        context.paintChild(child!, Offset(geometry.left, geometry.top));
        if (renderAnimManage.currentOffset!.left != position.dx ||
            renderAnimManage.currentOffset!.top != position.dy) {
          setStart(
              geometry, EdgeInsets.only(left: position.dx, top: position.dy));
        }
        renderAnimManage.currentOffset =
            EdgeInsets.only(left: position.dx, top: position.dy);
      } else {
        if (isExecute &&
            renderAnimManage.currentOffset != null &&
            (renderAnimManage.currentOffset!.left != position.dx ||
                renderAnimManage.currentOffset!.top != position.dy)) {
          context.paintChild(
              child!,
              Offset(renderAnimManage.currentOffset!.left,
                  renderAnimManage.currentOffset!.top));
          setStart(renderAnimManage.currentOffset,
              EdgeInsets.only(left: position.dx, top: position.dy));
          renderAnimManage.currentOffset =
              EdgeInsets.only(left: position.dx, top: position.dy);
        } else {
          renderAnimManage.currentOffset =
              EdgeInsets.only(left: position.dx, top: position.dy);

          context.paintChild(child!, position);
        }
      }
    }
  }
}

/// A class that manages animation and state for [DragItem].
class RenderAnimManage {
  RenderAnimManage();
  EdgeInsetsGeometryTween? tweenOffset;
  EdgeInsets? currentOffset;
  late AnimationController controller;
  late Animation<double> animation;
}
