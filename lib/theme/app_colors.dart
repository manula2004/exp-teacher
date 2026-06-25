import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Extracted 1-to-1 from all four HTML reference files (Tailwind config block).
// These are the canonical design tokens for the entire app.
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  // Background & Surface scale
  static const Color background = Color(0xFFF8F9FF);
  static const Color surface = Color(0xFFF8F9FF);
  static const Color surfaceBright = Color(0xFFF8F9FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEFF4FF);
  static const Color surfaceContainer = Color(0xFFE5EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDCE9FF);
  static const Color surfaceContainerHighest = Color(0xFFD3E4FE);
  static const Color surfaceVariant = Color(0xFFD3E4FE);
  static const Color surfaceDim = Color(0xFFCBDBF5);

  // On-surface / text
  static const Color onBackground = Color(0xFF0B1C30);
  static const Color onSurface = Color(0xFF0B1C30);
  static const Color onSurfaceVariant = Color(0xFF3C4A42);
  static const Color onSecondaryContainer = Color(0xFF576378);

  // Primary (dark green) — used for back-button, links, "View All" text
  static const Color primary = Color(0xFF006C49);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Primary Container (emerald) — FAB, active chip, strong-performance text
  static const Color primaryContainer = Color(0xFF10B981);
  static const Color onPrimaryContainer = Color(0xFF00422B);

  // Primary fixed shades
  static const Color primaryFixed = Color(0xFF6FFBBE);
  static const Color primaryFixedDim = Color(0xFF4EDEA3);
  static const Color onPrimaryFixed = Color(0xFF002113);
  static const Color onPrimaryFixedVariant = Color(0xFF005236);

  // Secondary
  static const Color secondary = Color(0xFF535F74);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFD4E0F9);
  static const Color secondaryFixed = Color(0xFFD7E3FC);
  static const Color secondaryFixedDim = Color(0xFFBBC7DF);
  static const Color onSecondaryFixed = Color(0xFF101C2E);
  static const Color onSecondaryFixedVariant = Color(0xFF3C475B);

  // Tertiary
  static const Color tertiary = Color(0xFF005AC2);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF71A1FF);
  static const Color tertiaryFixed = Color(0xFFD8E2FF);
  static const Color tertiaryFixedDim = Color(0xFFADC6FF);
  static const Color onTertiaryFixed = Color(0xFF001A42);
  static const Color onTertiaryFixedVariant = Color(0xFF004395);
  static const Color onTertiaryContainer = Color(0xFF00367A);

  // Outline
  static const Color outline = Color(0xFF6C7A71);
  static const Color outlineVariant = Color(0xFFBBCABF);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Surface tint
  static const Color surfaceTint = Color(0xFF006C49);

  // Inverse
  static const Color inverseSurface = Color(0xFF213145);
  static const Color inverseOnSurface = Color(0xFFEAF1FF);
  static const Color inversePrimary = Color(0xFF4EDEA3);

  // ── Semantic aliases used for performance colouring ──
  /// Strong performance (≥85%) — emerald
  static const Color performanceStrong = primaryContainer;

  /// Mid performance (70–84%) — muted neutral
  static const Color performanceMid = onSecondaryContainer;

  /// Needs-support performance (<70%) — red
  static const Color performanceNeedsSupport = error;

  // ── Skeleton shimmer gradient colours ──
  static const Color shimmerBase = surfaceContainerLow;   // #EFF4FF
  static const Color shimmerHighlight = surfaceVariant;    // #D3E4FE
}
