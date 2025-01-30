import 'package:flutter/material.dart';

extension AppereanceThemeExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get fonts => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  Brightness get brightnes => Theme.of(this).brightness;
}
