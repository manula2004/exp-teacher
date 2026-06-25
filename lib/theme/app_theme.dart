import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppTheme — assembles the MaterialTheme from extracted HTML design tokens.
// ─────────────────────────────────────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  static const double radiusDefault = 4.0;
  static const double radiusLg = 8.0;
  static const double radiusXl = 12.0;

  // Spacing scale (matches HTML: xs=4, sm=8, md=16, lg=24, xl=32, gutter=12)
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingGutter = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingMarginMobile = 16.0;

  // Shadow definitions (from HTML .custom-shadow and .fab-shadow)
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0xFF0F1B2D).withValues(alpha: 0.04),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get fabShadow => [
    BoxShadow(
      color: const Color(0xFF2563EB).withValues(alpha: 0.25),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme(
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
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      inversePrimary: AppColors.inversePrimary,
      surfaceTint: AppColors.surfaceTint,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
