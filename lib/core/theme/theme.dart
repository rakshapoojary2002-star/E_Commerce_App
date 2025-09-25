import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff31628d),
      surfaceTint: Color(0xff31628d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffcfe5ff),
      onPrimaryContainer: Color(0xff124a73),
      secondary: Color(0xff6c5e0f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff7e388),
      onSecondaryContainer: Color(0xff524600),
      tertiary: Color(0xff2c6a46),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffaff1c3),
      onTertiaryContainer: Color(0xff0d5130),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff1a1b21),
      onSurfaceVariant: Color(0xff504539),
      outline: Color(0xff827568),
      outlineVariant: Color(0xffd4c4b5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xff9dcbfb),
      primaryFixed: Color(0xffcfe5ff),
      onPrimaryFixed: Color(0xff001d34),
      primaryFixedDim: Color(0xff9dcbfb),
      onPrimaryFixedVariant: Color(0xff124a73),
      secondaryFixed: Color(0xfff7e388),
      onSecondaryFixed: Color(0xff211b00),
      secondaryFixedDim: Color(0xffd9c76f),
      onSecondaryFixedVariant: Color(0xff524600),
      tertiaryFixed: Color(0xffaff1c3),
      onTertiaryFixed: Color(0xff00210f),
      tertiaryFixedDim: Color(0xff94d5a8),
      onTertiaryFixedVariant: Color(0xff0d5130),
      surfaceDim: Color(0xffdad9e0),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3fa),
      surfaceContainer: Color(0xffeeedf4),
      surfaceContainerHigh: Color(0xffe8e7ef),
      surfaceContainerHighest: Color(0xffe3e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00395e),
      surfaceTint: Color(0xff31628d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff42719c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3f3600),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7c6d1f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003f22),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3b7953),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff101116),
      onSurfaceVariant: Color(0xff3e342a),
      outline: Color(0xff5c5145),
      outlineVariant: Color(0xff776b5e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xff9dcbfb),
      primaryFixed: Color(0xff42719c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff265882),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7c6d1f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff625404),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3b7953),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff21603d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6c6cd),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3fa),
      surfaceContainer: Color(0xffe8e7ef),
      surfaceContainerHigh: Color(0xffdddce3),
      surfaceContainerHighest: Color(0xffd2d1d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002e4e),
      surfaceTint: Color(0xff31628d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff164c76),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff342c00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff554900),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00341b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff115432),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff342b20),
      outlineVariant: Color(0xff52473c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xff9dcbfb),
      primaryFixed: Color(0xff164c76),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003558),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff554900),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3b3200),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff115432),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003b20),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb9b8bf),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f0f7),
      surfaceContainer: Color(0xffe3e2e9),
      surfaceContainerHigh: Color(0xffd5d3db),
      surfaceContainerHighest: Color(0xffc6c6cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9dcbfb),
      surfaceTint: Color(0xff9dcbfb),
      onPrimary: Color(0xff003355),
      primaryContainer: Color(0xff124a73),
      onPrimaryContainer: Color(0xffcfe5ff),
      secondary: Color(0xffd9c76f),
      onSecondary: Color(0xff393000),
      secondaryContainer: Color(0xff524600),
      onSecondaryContainer: Color(0xfff7e388),
      tertiary: Color(0xff94d5a8),
      onTertiary: Color(0xff00391e),
      tertiaryContainer: Color(0xff0d5130),
      onTertiaryContainer: Color(0xffaff1c3),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff121318),
      onSurface: Color(0xffe3e2e9),
      onSurfaceVariant: Color(0xffd4c4b5),
      outline: Color(0xff9c8e80),
      outlineVariant: Color(0xff504539),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e9),
      inversePrimary: Color(0xff31628d),
      primaryFixed: Color(0xffcfe5ff),
      onPrimaryFixed: Color(0xff001d34),
      primaryFixedDim: Color(0xff9dcbfb),
      onPrimaryFixedVariant: Color(0xff124a73),
      secondaryFixed: Color(0xfff7e388),
      onSecondaryFixed: Color(0xff211b00),
      secondaryFixedDim: Color(0xffd9c76f),
      onSecondaryFixedVariant: Color(0xff524600),
      tertiaryFixed: Color(0xffaff1c3),
      onTertiaryFixed: Color(0xff00210f),
      tertiaryFixedDim: Color(0xff94d5a8),
      onTertiaryFixedVariant: Color(0xff0d5130),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff38393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1a1b21),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff292a2f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc4dfff),
      surfaceTint: Color(0xff9dcbfb),
      onPrimary: Color(0xff002844),
      primaryContainer: Color(0xff6795c2),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff0dd82),
      onSecondary: Color(0xff2d2500),
      secondaryContainer: Color(0xffa1913f),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa9ebbd),
      onTertiary: Color(0xff002c16),
      tertiaryContainer: Color(0xff5f9e75),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffeadaca),
      outline: Color(0xffbfafa1),
      outlineVariant: Color(0xff9c8e80),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e9),
      inversePrimary: Color(0xff144b75),
      primaryFixed: Color(0xffcfe5ff),
      onPrimaryFixed: Color(0xff001223),
      primaryFixedDim: Color(0xff9dcbfb),
      onPrimaryFixedVariant: Color(0xff00395e),
      secondaryFixed: Color(0xfff7e388),
      onSecondaryFixed: Color(0xff151100),
      secondaryFixedDim: Color(0xffd9c76f),
      onSecondaryFixedVariant: Color(0xff3f3600),
      tertiaryFixed: Color(0xffaff1c3),
      onTertiaryFixed: Color(0xff001508),
      tertiaryFixedDim: Color(0xff94d5a8),
      onTertiaryFixedVariant: Color(0xff003f22),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff43444a),
      surfaceContainerLowest: Color(0xff06070c),
      surfaceContainerLow: Color(0xff1c1d23),
      surfaceContainer: Color(0xff27282d),
      surfaceContainerHigh: Color(0xff313238),
      surfaceContainerHighest: Color(0xff3c3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe7f1ff),
      surfaceTint: Color(0xff9dcbfb),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff99c7f7),
      onPrimaryContainer: Color(0xff000c1a),
      secondary: Color(0xfffff0b4),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd5c36c),
      onSecondaryContainer: Color(0xff0f0b00),
      tertiary: Color(0xffbeffd1),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff90d1a5),
      onTertiaryContainer: Color(0xff000f05),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff121318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfffeeddd),
      outlineVariant: Color(0xffd0c0b1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e9),
      inversePrimary: Color(0xff144b75),
      primaryFixed: Color(0xffcfe5ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9dcbfb),
      onPrimaryFixedVariant: Color(0xff001223),
      secondaryFixed: Color(0xfff7e388),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd9c76f),
      onSecondaryFixedVariant: Color(0xff151100),
      tertiaryFixed: Color(0xffaff1c3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff94d5a8),
      onTertiaryFixedVariant: Color(0xff001508),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff4f5056),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1e1f25),
      surfaceContainer: Color(0xff2f3036),
      surfaceContainerHigh: Color(0xff3a3b41),
      surfaceContainerHighest: Color(0xff46464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
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
