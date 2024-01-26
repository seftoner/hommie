import "package:flutter/material.dart";

class HommieMaterialTheme {
  final TextTheme textTheme;

  const HommieMaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280247686),
      surfaceTint: Color(4280247686),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4291160063),
      onPrimaryContainer: Color(4278197805),
      secondary: Color(4283326829),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292011508),
      onSecondaryContainer: Color(4278853160),
      tertiary: Color(4284569980),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4293385983),
      onTertiaryContainer: Color(4280096565),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294376190),
      onBackground: Color(4279770143),
      surface: Color(4294376190),
      onSurface: Color(4279770143),
      surfaceVariant: Color(4292731882),
      onSurfaceVariant: Color(4282468429),
      outline: Color(4285626494),
      outlineVariant: Color(4290889678),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inverseOnSurface: Color(4293784054),
      inversePrimary: Color(4287745780),
      primaryFixed: Color(4291160063),
      onPrimaryFixed: Color(4278197805),
      primaryFixedDim: Color(4287745780),
      onPrimaryFixedVariant: Color(4278209642),
      secondaryFixed: Color(4292011508),
      onSecondaryFixed: Color(4278853160),
      secondaryFixedDim: Color(4290169304),
      onSecondaryFixedVariant: Color(4281813333),
      tertiaryFixed: Color(4293385983),
      onTertiaryFixed: Color(4280096565),
      tertiaryFixedDim: Color(4291543529),
      onTertiaryFixedVariant: Color(4282991203),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293257453),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278208613),
      surfaceTint: Color(4280247686),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282088350),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281550161),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284774276),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282728031),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4286082964),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294376190),
      onBackground: Color(4279770143),
      surface: Color(4294376190),
      onSurface: Color(4279770143),
      surfaceVariant: Color(4292731882),
      onSurfaceVariant: Color(4282205257),
      outline: Color(4284047461),
      outlineVariant: Color(4285889665),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inverseOnSurface: Color(4293784054),
      inversePrimary: Color(4287745780),
      primaryFixed: Color(4282088350),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4279984772),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284774276),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283194987),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4286082964),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284438394),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293257453),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278199606),
      surfaceTint: Color(4280247686),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278208613),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279378991),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281550161),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280556860),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282728031),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294376190),
      onBackground: Color(4279770143),
      surface: Color(4294376190),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292731882),
      onSurfaceVariant: Color(4280165674),
      outline: Color(4282205257),
      outlineVariant: Color(4282205257),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4292538367),
      primaryFixed: Color(4278208613),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202437),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281550161),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280102714),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282728031),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281280584),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293257453),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4287745780),
      surfaceTint: Color(4287745780),
      onPrimary: Color(4278203466),
      primaryContainer: Color(4278209642),
      onPrimaryContainer: Color(4291160063),
      secondary: Color(4290169304),
      onSecondary: Color(4280300350),
      secondaryContainer: Color(4281813333),
      onSecondaryContainer: Color(4292011508),
      tertiary: Color(4291543529),
      onTertiary: Color(4281543756),
      tertiaryContainer: Color(4282991203),
      onTertiaryContainer: Color(4293385983),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279178263),
      onBackground: Color(4292862951),
      surface: Color(4279178263),
      onSurface: Color(4292862951),
      surfaceVariant: Color(4282468429),
      onSurfaceVariant: Color(4290889678),
      outline: Color(4287337111),
      outlineVariant: Color(4282468429),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inverseOnSurface: Color(4281086260),
      inversePrimary: Color(4280247686),
      primaryFixed: Color(4291160063),
      onPrimaryFixed: Color(4278197805),
      primaryFixedDim: Color(4287745780),
      onPrimaryFixedVariant: Color(4278209642),
      secondaryFixed: Color(4292011508),
      onSecondaryFixed: Color(4278853160),
      secondaryFixedDim: Color(4290169304),
      onSecondaryFixedVariant: Color(4281813333),
      tertiaryFixed: Color(4293385983),
      onTertiaryFixed: Color(4280096565),
      tertiaryFixedDim: Color(4291543529),
      onTertiaryFixedVariant: Color(4282991203),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279770143),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4288008953),
      surfaceTint: Color(4287745780),
      onPrimary: Color(4278196517),
      primaryContainer: Color(4284127420),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290432476),
      onSecondary: Color(4278523939),
      secondaryContainer: Color(4286616481),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4291806702),
      onTertiary: Color(4279767344),
      tertiaryContainer: Color(4287990705),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279178263),
      onBackground: Color(4292862951),
      surface: Color(4279178263),
      onSurface: Color(4294507519),
      surfaceVariant: Color(4282468429),
      onSurfaceVariant: Color(4291152850),
      outline: Color(4288521386),
      outlineVariant: Color(4286416010),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inverseOnSurface: Color(4280691502),
      inversePrimary: Color(4278209900),
      primaryFixed: Color(4291160063),
      onPrimaryFixed: Color(4278194974),
      primaryFixedDim: Color(4287745780),
      onPrimaryFixedVariant: Color(4278205011),
      secondaryFixed: Color(4292011508),
      onSecondaryFixed: Color(4278260509),
      secondaryFixedDim: Color(4290169304),
      onSecondaryFixedVariant: Color(4280694852),
      tertiaryFixed: Color(4293385983),
      onTertiaryFixed: Color(4279438378),
      tertiaryFixedDim: Color(4291543529),
      onTertiaryFixedVariant: Color(4281938258),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279770143),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294507519),
      surfaceTint: Color(4287745780),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4288008953),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294507519),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290432476),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294900223),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291806702),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279178263),
      onBackground: Color(4292862951),
      surface: Color(4279178263),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282468429),
      onSurfaceVariant: Color(4294507519),
      outline: Color(4291152850),
      outlineVariant: Color(4291152850),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278201921),
      primaryFixed: Color(4291816447),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4288008953),
      onPrimaryFixedVariant: Color(4278196517),
      secondaryFixed: Color(4292274681),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290432476),
      onSecondaryFixedVariant: Color(4278523939),
      tertiaryFixed: Color(4293649407),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4291806702),
      onTertiaryFixedVariant: Color(4279767344),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279770143),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
