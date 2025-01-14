import 'package:flutter/material.dart';

/// Defines corner radius values used throughout the app
class Corners {
  static const double none = 0;

  static const double extraSmall = 4;

  static const double small = 8;

  static const double medium = 12;

  static const double large = 16;

  static const double extraLarge = 28;

  static const double full = 1000;

  const Corners._();

  static const Corners instance = Corners._();

  /// Creates a BorderRadius with the given corner radius
  BorderRadius radius(double value) => BorderRadius.circular(value);

  /// Creates a RoundedRectangleBorder with the given corner radius
  RoundedRectangleBorder shape(double value) => RoundedRectangleBorder(
        borderRadius: radius(value),
      );
}

final corners = Corners.instance;
