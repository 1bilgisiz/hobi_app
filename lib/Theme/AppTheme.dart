import 'package:flutter/material.dart';

class AppTheme {
  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal();

  static ThemeData theme = ThemeData(
    fontFamily: "Poppins",
    colorScheme: AppColorsScheme.lightColorScheme,
  );
}

class AppColorsScheme {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFC00100),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDAD4),
    onPrimaryContainer: Color(0xFF410000),
    secondary: Color(0xFF006688),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFC2E8FF),
    onSecondaryContainer: Color(0xFF001E2B),
    tertiary: Color(0xFF006492),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC9E6FF),
    onTertiaryContainer: Color(0xFF001E2F),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF3E0021),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF3E0021),
    surfaceVariant: Color(0xFFF5DDDA),
    onSurfaceVariant: Color(0xFF534341),
    outline: Color(0xFF857370),
    onInverseSurface: Color(0xFFFFECF0),
    inverseSurface: Color(0xFF5D1137),
    inversePrimary: Color(0xFFFFB4A8),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFC00100),
    outlineVariant: Color(0xFFD8C2BE),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB4A8),
    onPrimary: Color(0xFF690100),
    primaryContainer: Color(0xFF930100),
    onPrimaryContainer: Color(0xFFFFDAD4),
    secondary: Color(0xFF75D1FF),
    onSecondary: Color(0xFF003548),
    secondaryContainer: Color(0xFF004D67),
    onSecondaryContainer: Color(0xFFC2E8FF),
    tertiary: Color(0xFF8BCEFF),
    onTertiary: Color(0xFF00344E),
    tertiaryContainer: Color(0xFF004B6F),
    onTertiaryContainer: Color(0xFFC9E6FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF3E0021),
    onBackground: Color(0xFFFFD9E4),
    surface: Color(0xFF3E0021),
    onSurface: Color(0xFFFFD9E4),
    surfaceVariant: Color(0xFF534341),
    onSurfaceVariant: Color(0xFFD8C2BE),
    outline: Color(0xFFA08C89),
    onInverseSurface: Color(0xFF3E0021),
    inverseSurface: Color(0xFFFFD9E4),
    inversePrimary: Color(0xFFC00100),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFFB4A8),
    outlineVariant: Color(0xFF534341),
    scrim: Color(0xFF000000),
  );
}
