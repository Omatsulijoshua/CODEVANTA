import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'codevanta_colors.dart';

class CodeVantaTypography {
  static TextStyle displayLarge(bool isDark) => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
        color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
      );

  static TextStyle titleLarge(bool isDark) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
      );

  static TextStyle bodyMedium(bool isDark) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
      );

  static TextStyle codeMono(bool isDark) => GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
      );

  static TextStyle labelSmall(bool isDark) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
      );
}
