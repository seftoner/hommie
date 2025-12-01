import 'package:flutter/material.dart';

class ColorBadge extends StatelessWidget {
  final Color color;
  final double radius;

  const ColorBadge({
    super.key,
    required this.color,
    this.radius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
