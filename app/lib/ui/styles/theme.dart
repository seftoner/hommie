import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class HommieMaterialTheme {
  final TextTheme textTheme;

  const HommieMaterialTheme(this.textTheme);

  factory HommieMaterialTheme.platform() {
    final platform = defaultTargetPlatform;
    final typography = switch (platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => Typography.material2021(
          platform: platform,
          black: Typography.blackCupertino,
          white: Typography.whiteCupertino,
        ),
      _ => Typography.material2021(
          platform: platform,
          black: Typography.blackMountainView,
          white: Typography.whiteMountainView,
        ),
    };
    return HommieMaterialTheme(typography.black);
  }

  factory HommieMaterialTheme.platformDark() {
    final platform = defaultTargetPlatform;
    final typography = switch (platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => Typography.material2021(
          platform: platform,
          black: Typography.blackCupertino,
          white: Typography.whiteCupertino,
        ),
      _ => Typography.material2021(
          platform: platform,
          black: Typography.blackMountainView,
          white: Typography.whiteMountainView,
        ),
    };
    return HommieMaterialTheme(typography.white);
  }

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 0, 101, 142),
      surfaceTint: Color.fromRGBO(0, 101, 142, 1),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xFF3CBCFC),
      onPrimaryContainer: Color(0xFF00293C),
      secondary: Color(0xFF3C637B),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color.fromRGBO(208, 234, 255, 1),
      onSecondaryContainer: Color(0xff344d5e),
      tertiary: Color(0xff613974),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff885d9b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color.fromRGBO(186, 26, 26, 1),
      onError: Color.fromRGBO(255, 255, 255, 1),
      errorContainer: Color.fromRGBO(255, 218, 214, 1),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff7f9fd),
      onBackground: Color(0xff191c1f),
      surface: Color.fromRGBO(246, 250, 255, 1),
      onSurface: Color(0xff191c1f),
      surfaceVariant: Color(0xffdce3eb),
      onSurfaceVariant: Color(0xff40484e),
      outline: Color(0xff70787f),
      outlineVariant: Color(0xffbfc7cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3134),
      inverseOnSurface: Color(0xffeff1f4),
      inversePrimary: Color(0xff88cffd),
      primaryFixed: Color(0xffc7e7ff),
      onPrimaryFixed: Color(0xff001e2e),
      primaryFixedDim: Color(0xff88cffd),
      onPrimaryFixedVariant: Color(0xff004c6c),
      secondaryFixed: Color(0xffcce6fb),
      onSecondaryFixed: Color(0xff021e2d),
      secondaryFixedDim: Color(0xffb0cade),
      onSecondaryFixedVariant: Color(0xff314a5a),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff2f0642),
      tertiaryFixedDim: Color(0xffe6b5fa),
      onTertiaryFixedVariant: Color(0xff5e3671),
      surfaceDim: Color(0xffd8dade),
      surfaceBright: Color.fromRGBO(246, 250, 255, 1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f7),
      surfaceContainer: Color.fromRGBO(234, 238, 244, 1),
      surfaceContainerHigh: Color(0xffe6e8ec),
      surfaceContainerHighest: Color(0xffe0e3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004866),
      surfaceTint: Color(0xff00658e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff23759e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2d4656),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f788a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5a326d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff885d9b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7f9fd),
      onBackground: Color(0xff191c1f),
      surface: Color(0xfff7f9fd),
      onSurface: Color(0xff191c1f),
      surfaceVariant: Color(0xffdce3eb),
      onSurfaceVariant: Color(0xff3c444a),
      outline: Color(0xff586067),
      outlineVariant: Color(0xff747c83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3134),
      inverseOnSurface: Color(0xffeff1f4),
      inversePrimary: Color(0xff88cffd),
      primaryFixed: Color(0xff2d7ca6),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00628a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5f788a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff465f70),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8f64a3),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff754b88),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dade),
      surfaceBright: Color(0xfff7f9fd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f7),
      surfaceContainer:
          Color.from(alpha: 1, red: 0.925, green: 0.933, blue: 0.949),
      surfaceContainerHigh: Color(0xffe6e8ec),
      surfaceContainerHighest: Color(0xffe0e3e6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002537),
      surfaceTint: Color(0xff00658e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004866),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff092534),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2d4656),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff360e4a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5a326d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7f9fd),
      onBackground: Color(0xff191c1f),
      surface: Color(0xfff7f9fd),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdce3eb),
      onSurfaceVariant: Color(0xff1d252b),
      outline: Color(0xff3c444a),
      outlineVariant: Color(0xff3c444a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3134),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffdbefff),
      primaryFixed: Color(0xff004866),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003046),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2d4656),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff152f3f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5a326d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff421b55),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dade),
      surfaceBright: Color(0xfff7f9fd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f7),
      surfaceContainer: Color(0xFFECEEF2),
      surfaceContainerHigh: Color(0xffe6e8ec),
      surfaceContainerHighest: Color(0xffe0e3e6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(132, 207, 255, 1),
      surfaceTint: Color(0xff88cffd),
      onPrimary: Color.fromRGBO(0, 52, 76, 1),
      primaryContainer: Color(0xff005a80),
      onPrimaryContainer: Color(0xfff3f8ff),
      secondary: Color(0xffb0cade),
      onSecondary: Color(0xff193343),
      secondaryContainer: Color(0xff2a4253),
      onSecondaryContainer: Color(0xffbed8ec),
      tertiary: Color(0xffe6b5fa),
      onTertiary: Color(0xff461f59),
      tertiaryContainer: Color(0xff6e4581),
      onTertiaryContainer: Color(0xfffff8fb),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff101416),
      onBackground: Color(0xffe0e3e6),
      surface: Color(0xff101416),
      onSurface: Color(0xffe0e3e6),
      surfaceVariant: Color(0xff40484e),
      onSurfaceVariant: Color(0xffbfc7cf),
      outline: Color(0xff8a9299),
      outlineVariant: Color(0xff40484e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e6),
      inverseOnSurface: Color(0xff2d3134),
      inversePrimary: Color(0xff00658e),
      primaryFixed: Color(0xffc7e7ff),
      onPrimaryFixed: Color(0xff001e2e),
      primaryFixedDim: Color(0xff88cffd),
      onPrimaryFixedVariant: Color(0xff004c6c),
      secondaryFixed: Color(0xffcce6fb),
      onSecondaryFixed: Color(0xff021e2d),
      secondaryFixedDim: Color(0xffb0cade),
      onSecondaryFixedVariant: Color(0xff314a5a),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff2f0642),
      tertiaryFixedDim: Color(0xffe6b5fa),
      onTertiaryFixedVariant: Color(0xff5e3671),
      surfaceDim: Color(0xff101416),
      surfaceBright: Color(0xff363a3d),
      surfaceContainerLowest: Color(0xff0b0f11),
      surfaceContainerLow: Color(0xff191c1f),
      surfaceContainer: Color.fromRGBO(27, 32, 36, 1),
      surfaceContainerHigh: Color(0xff272a2d),
      surfaceContainerHighest: Color(0xff323538),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8fd3ff),
      surfaceTint: Color(0xff88cffd),
      onPrimary: Color(0xff001826),
      primaryContainer: Color(0xff4f98c4),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb4cee2),
      onSecondary: Color(0xff001826),
      secondaryContainer: Color(0xff7b94a7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffebb9fe),
      onTertiary: Color(0xff29003d),
      tertiaryContainer: Color(0xffad80c1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101416),
      onBackground: Color(0xffe0e3e6),
      surface: Color(0xff101416),
      onSurface: Color(0xfff9fbfe),
      surfaceVariant: Color(0xff40484e),
      onSurfaceVariant: Color(0xffc4ccd3),
      outline: Color(0xff9ca4ab),
      outlineVariant: Color(0xff7c848b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e6),
      inverseOnSurface: Color(0xff272a2d),
      inversePrimary: Color(0xff004d6e),
      primaryFixed: Color(0xffc7e7ff),
      onPrimaryFixed: Color(0xff00131f),
      primaryFixedDim: Color(0xff88cffd),
      onPrimaryFixedVariant: Color(0xff003a54),
      secondaryFixed: Color(0xffcce6fb),
      onSecondaryFixed: Color(0xff00131f),
      secondaryFixedDim: Color(0xffb0cade),
      onSecondaryFixedVariant: Color(0xff203949),
      tertiaryFixed: Color(0xfff7d8ff),
      onTertiaryFixed: Color(0xff210032),
      tertiaryFixedDim: Color(0xffe6b5fa),
      onTertiaryFixedVariant: Color(0xff4c255f),
      surfaceDim: Color(0xff101416),
      surfaceBright: Color(0xff363a3d),
      surfaceContainerLowest: Color(0xff0b0f11),
      surfaceContainerLow: Color(0xff191c1f),
      surfaceContainer: Color(0xff1d2023),
      surfaceContainerHigh: Color(0xff272a2d),
      surfaceContainerHighest: Color(0xff323538),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff8fbff),
      surfaceTint: Color(0xff88cffd),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8fd3ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff8fbff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb4cee2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffebb9fe),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101416),
      onBackground: Color(0xffe0e3e6),
      surface: Color(0xff101416),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff40484e),
      onSurfaceVariant: Color(0xfff8fbff),
      outline: Color(0xffc4ccd3),
      outlineVariant: Color(0xffc4ccd3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e6),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002d43),
      primaryFixed: Color(0xffd0eaff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8fd3ff),
      onPrimaryFixedVariant: Color(0xff001826),
      secondaryFixed: Color(0xffd0eaff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb4cee2),
      onSecondaryFixedVariant: Color(0xff001826),
      tertiaryFixed: Color(0xfff9deff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffebb9fe),
      onTertiaryFixedVariant: Color(0xff29003d),
      surfaceDim: Color(0xff101416),
      surfaceBright: Color(0xff363a3d),
      surfaceContainerLowest: Color(0xff0b0f11),
      surfaceContainerLow: Color(0xff191c1f),
      surfaceContainer: Color(0xff1d2023),
      surfaceContainerHigh: Color(0xff272a2d),
      surfaceContainerHighest: Color(0xff323538),
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
        scaffoldBackgroundColor: colorScheme.surface,
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
        surface: surface,
        surfaceTint: surfaceTint,
        onSurface: onSurface,
        surfaceContainerHighest: surfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        shadow: shadow,
        scrim: scrim,
        inverseSurface: inverseSurface,
        onInverseSurface: inverseOnSurface,
        inversePrimary: inversePrimary,
        surfaceContainer: surfaceContainer,
        surfaceDim: surfaceDim,
        surfaceBright: surfaceBright,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainerLowest: surfaceContainerLowest);
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
