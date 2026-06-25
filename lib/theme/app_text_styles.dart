import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Typography scale extracted from HTML fontSize / fontFamily declarations.
//
// Fonts used:
//   - Hanken Grotesk: body-sm, body-md, subtitle-md, headline-md, headline-lg
//   - Work Sans:      label-caps
//
// All values match the HTML spec exactly.
// ─────────────────────────────────────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  // ── body-sm: 12px / 16px / w400 ──
  static TextStyle bodySm({Color color = AppColors.onSurface}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        color: color,
      );

  // ── body-md: 14px / 20px / w400 ──
  static TextStyle bodyMd({Color color = AppColors.onSurface}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  // ── subtitle-md: 16px / 20px / w500 ──
  static TextStyle subtitleMd({Color color = AppColors.onSurface}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 16,
        height: 20 / 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  // ── headline-md: 18px / 24px / w700 ──
  static TextStyle headlineMd({Color color = AppColors.onSurface}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 18,
        height: 24 / 18,
        fontWeight: FontWeight.w700,
        color: color,
      );

  // ── headline-lg: 24px / 32px / w700 / ls -0.02em ──
  static TextStyle headlineLg({Color color = AppColors.onSurface}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 24,
        height: 32 / 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02 * 24, // -0.02em expressed in logical pixels
        color: color,
      );

  // ── headline-lg-mobile: 20px / 28px / w700 / ls -0.01em ──
  static TextStyle headlineLgMobile({Color color = AppColors.onSurface}) =>
      GoogleFonts.hankenGrotesk(
        fontSize: 20,
        height: 28 / 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.01 * 20,
        color: color,
      );

  // ── label-caps: 11px / 12px / w600 / ls +0.05em (Work Sans) ──
  static TextStyle labelCaps({Color color = AppColors.onSurfaceVariant}) =>
      GoogleFonts.workSans(
        fontSize: 11,
        height: 12 / 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05 * 11,
        color: color,
      );
}
