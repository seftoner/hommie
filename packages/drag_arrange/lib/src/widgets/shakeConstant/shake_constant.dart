import 'package:flutter/widgets.dart';

abstract class ShakeConstant {
  /// range: 0 - 100, when only have one element,represents the same interval
  final List<int> interval;

  /// Offset(double dx, double dy)
  final List<Offset> translate;

  /// eg: 45deg = pi / 4, []:0 = [45]: rotate 45deg
  final List<double> rotate;

  /// range: 0 - 1.0, []:1.0 = [1.0]
  final List<double> opacity;

  final Duration duration;

  ShakeConstant(
      {required this.interval,
      required this.translate,
      required this.rotate,
      required this.opacity,
      this.duration = const Duration(milliseconds: 100)})
      : assert(interval.isEmpty || interval.length == 1 || interval.length > 1),
        assert(rotate.isEmpty || rotate.length == 1 || rotate.length > 1),
        assert(opacity.isEmpty || opacity.length == 1 || opacity.length > 1),
        assert(
            translate.isEmpty || translate.length == 1 || translate.length > 1);
}
