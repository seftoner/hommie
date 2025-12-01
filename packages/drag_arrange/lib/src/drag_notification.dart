import 'dart:async';

import 'package:flutter/material.dart';

/// A widget that listens to scroll notifications and provides a static property
/// to check whether a scroll action is in progress.
///
/// This widget is designed to be used as a wrapper around another widget to
/// detect scroll actions and set a static `isScroll` property to `true` during
/// scrolling and then back to `false` after a delay.
class DragNotification extends StatefulWidget {
  /// Creates a [DragNotification] widget.
  ///
  /// The [child] is the widget that you want to wrap with scroll detection.
  const DragNotification({required this.child, super.key});

  /// The child widget that will be wrapped by the [DragNotification].
  final Widget child;

  /// A boolean property indicating whether a scroll action is in progress.
  ///
  /// This property is `true` during scrolling and will automatically revert to
  /// `false` after a short delay once the scroll action ends.
  static bool isScroll = false;

  @override
  State<DragNotification> createState() => _DragNotificationState();
}

class _DragNotificationState extends State<DragNotification> {
  Timer? _timer;

  /// Sets the `isScroll` property to `true` and starts a timer to reset it to
  /// `false` after a short delay.
  void setScroll() {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 100), () {
      DragNotification.isScroll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          _timer?.cancel();
          DragNotification.isScroll = true;
        } else if (notification is ScrollUpdateNotification) {
          _timer?.cancel();
          DragNotification.isScroll = true;
        } else if (notification is ScrollEndNotification) {
          setScroll();
        }
        return false;
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
