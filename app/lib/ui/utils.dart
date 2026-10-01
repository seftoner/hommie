import 'package:material_ui/material_ui.dart';

extension ThemeExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get fonts => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  Brightness get brightnes => Theme.of(this).brightness;
}
