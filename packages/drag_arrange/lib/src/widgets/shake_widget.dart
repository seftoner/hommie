import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'shakeConstant/shake_constant.dart';

class ShakeWidget extends StatefulWidget {
  /// animate widget
  final Widget child;

  /// shake_xxxx_constant
  final ShakeConstant shakeConstant;

  /// animate duration
  final Duration? duration;

  /// true: start false:stop, default is false
  final bool enabled;

  /// AnimationController can help if  want to control by yourself
  final Function(AnimationController controller)? onController;

  const ShakeWidget({
    super.key,
    required this.child,
    required this.shakeConstant,
    this.duration,
    this.enabled = false,
    this.onController,
  });

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _translateAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? widget.shakeConstant.duration,
    );

    _translateAnimation = _createAnimation(
      values: widget.shakeConstant.translate,
      createTween: (begin, end) => Tween(begin: begin, end: end),
      defaultValue: Offset.zero,
    );

    _rotateAnimation = _createAnimation(
      values: widget.shakeConstant.rotate,
      createTween: (begin, end) =>
          Tween(begin: math.pi / 180 * begin, end: math.pi / 180 * end),
      defaultValue: 0.0,
    );

    if (widget.enabled) {
      _controller.repeat(reverse: true);
    }

    widget.onController?.call(_controller);
  }

  double _calculateWeight(int index, List values) {
    if (widget.shakeConstant.interval.length == 1) {
      return widget.shakeConstant.interval.first * 1.0;
    }

    if (widget.shakeConstant.interval.length > 1 &&
        widget.shakeConstant.interval.length == values.length) {
      final beginWeight = widget.shakeConstant.interval[index];
      final endWeight = widget.shakeConstant.interval[index + 1];
      return (endWeight - beginWeight) * 1.0;
    }

    return 100 / math.max((widget.shakeConstant.translate.length - 1), 1);
  }

  Animation<T> _createAnimation<T>({
    required List<T> values,
    required Tween<T> Function(T begin, T end) createTween,
    required T defaultValue,
  }) {
    if (values.isEmpty) {
      return ConstantTween<T>(defaultValue).animate(_controller);
    }

    if (values.length == 1) {
      return ConstantTween<T>(values.first).animate(_controller);
    }

    return TweenSequence<T>(
      List.generate(values.length - 1, (index) {
        return TweenSequenceItem(
          tween: createTween(values[index], values[index + 1]),
          weight: _calculateWeight(index, values),
        );
      }),
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant ShakeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use RepaintBoundary to isolate shake animation from layout
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        // Only build the transform part, not the entire subtree
        builder: (BuildContext context, Widget? child) {
          return Transform(
            alignment: Alignment.center,
            // Apply transformations in local space only
            transformHitTests: false, // Don't affect hit testing
            transform: Matrix4.identity()
              ..translateByDouble(
                _translateAnimation.value.dx,
                _translateAnimation.value.dy,
                0.0,
                1.0,
              )
              ..rotateZ(_rotateAnimation.value),
            child: child,

            /*
            * Comment this code as it works previously, but translate method is
            * deprecated now. I can't test this functionality by now, but I need to pass analyze checks. 
            
            Matrix4.identity()
              ..translate(
                  _translateAnimation.value.dx, _translateAnimation.value.dy)
              ..rotateZ(_rotateAnimation.value),
             */
          );
        },

        child: widget.child,
      ),
    );
  }
}
