import 'package:flutter/material.dart';
import 'codevanta_colors.dart';

class CodeVantaTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CodeVantaColors.darkGraphite,
      colorScheme: const ColorScheme.dark(
        primary: CodeVantaColors.electricViolet,
        secondary: CodeVantaColors.cyanAccent,
        surface: CodeVantaColors.darkSurfaceCard,
        onSurface: CodeVantaColors.textDarkPrimary,
        error: CodeVantaColors.errorRed,
      ),
      cardTheme: CardThemeData(
        color: CodeVantaColors.darkSurfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: CodeVantaColors.darkSurfaceBorder, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CodeVantaColors.darkGraphite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: CodeVantaColors.textDarkPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: CodeVantaColors.lightGraphite,
      colorScheme: const ColorScheme.light(
        primary: CodeVantaColors.electricViolet,
        secondary: CodeVantaColors.cyanAccent,
        surface: CodeVantaColors.lightSurfaceCard,
        onSurface: CodeVantaColors.textLightPrimary,
        error: CodeVantaColors.errorRed,
      ),
      cardTheme: CardThemeData(
        color: CodeVantaColors.lightSurfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: CodeVantaColors.lightSurfaceBorder, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CodeVantaColors.lightGraphite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: CodeVantaColors.textLightPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
