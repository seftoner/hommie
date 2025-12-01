import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'shake_constant.dart';

class ShakeRange {
  final double min;
  final double max;
  final int points;

  const ShakeRange({
    required this.min,
    required this.max,
    this.points = 20,
  });

  @override
  String toString() => '$min-$max';
}

class RandomShakeConstant implements ShakeConstant {
  final ShakeRange offsetX;
  final ShakeRange offsetY;
  final ShakeRange rotation;
  final math.Random _random;

  late final List<Offset> _generatedTranslate;
  late final List<double> _generatedRotate;

  RandomShakeConstant({
    this.offsetX = const ShakeRange(min: -1.5, max: 2.5),
    this.offsetY = const ShakeRange(min: -1.5, max: 2.5),
    this.rotation = const ShakeRange(min: -0.5, max: 1.5),
    math.Random? random,
  }) : _random = random ?? math.Random() {
    _generatedTranslate = _generateTranslations();
    _generatedRotate = _generateRotations();
  }

  List<Offset> _generateTranslations() {
    final points = math.max(offsetX.points, offsetY.points);
    final List<Offset> translations = [const Offset(0, 0)];

    for (int i = 0; i < points; i++) {
      final dx =
          _random.nextDouble() * (offsetX.max - offsetX.min) + offsetX.min;
      final dy =
          _random.nextDouble() * (offsetY.max - offsetY.min) + offsetY.min;
      translations.add(Offset(dx, dy));
    }

    translations.add(const Offset(0, 0)); // End where we started
    return translations;
  }

  List<double> _generateRotations() {
    final List<double> rotations = [0.0];

    for (int i = 0; i < rotation.points; i++) {
      final angle =
          _random.nextDouble() * (rotation.max - rotation.min) + rotation.min;
      rotations.add(angle);
    }

    rotations.add(0.0); // End at 0 rotation
    return rotations;
  }

  @override
  List<int> get interval => [2, 10, 30, 45, 50, 100];

  @override
  List<double> get opacity => const [];

  @override
  List<Offset> get translate => _generatedTranslate;

  @override
  List<double> get rotate => _generatedRotate;

  @override
  Duration get duration => const Duration(milliseconds: 2500);
}
