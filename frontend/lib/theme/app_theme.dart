import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Main Colors
  static const Color primary = Color(0xFF005AB4); // Vibrant Blue
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF0A73E0);
  static const Color onPrimaryContainer = Color(0xFFFEFCFF);
  
  static const Color secondary = Color(0xFF465F88); // Desaturated Blue-Grey
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFB6D0FF);
  static const Color onSecondaryContainer = Color(0xFF3F5881);
  
  static const Color tertiary = Color(0xFF964400); // Deep Warm Orange
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFBD5700);
  static const Color onTertiaryContainer = Color(0xFFFFFBFF);
  
  // Base Neutral Canvas Colors
  static const Color background = Color(0xFFF9F9FF);
  static const Color onBackground = Color(0xFF181C22);
  
  static const Color surface = Color(0xFFF9F9FF);
  static const Color onSurface = Color(0xFF181C22);
  static const Color surfaceVariant = Color(0xFFE0E2EB);
  static const Color onSurfaceVariant = Color(0xFF414753);
  
  // Tonal Layering Containers
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF1F3FC);
  static const Color surfaceContainer = Color(0xFFEBEDF7);
  static const Color surfaceContainerHigh = Color(0xFFE6E8F1);
  static const Color surfaceContainerHighest = Color(0xFFE0E2EB);
  
  // Borders, Outlines, & Errors
  static const Color outline = Color(0xFF717785);
  static const Color outlineVariant = Color(0xFFC1C6D5);
  static const Color error = Color(0xFFBA1A1A);
  
  // Design Specific Filling Colors
  static const Color mintGreenContainer = Color(0xFFF0FDF4); // HTML green bg mapping #f0fdf4
  static const Color lightMintFiller = Color(0xFFF6FBEF);      // Matching UI background
  static const Color activeGreenText = Color(0xFF005008);      // Custom herbal green accent
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: Colors.white,
        background: AppColors.background,
        onBackground: AppColors.onBackground,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceVariant: AppColors.surfaceVariant,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.manrope(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
          height: 1.25,
        ),
        headlineMedium: GoogleFonts.manrope(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
          height: 1.33,
        ),
        titleLarge: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurface,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceVariant,
          height: 1.43,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
          height: 1.14,
          letterSpacing: 0.14,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurfaceVariant,
          height: 1.33,
          letterSpacing: 0.5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurfaceVariant,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.outline,
        ),
      ),
    );
  }
}
