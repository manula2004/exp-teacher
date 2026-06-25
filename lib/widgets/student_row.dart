import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// StudentRow — matches the student list rows in "Class Details - Students.html".
//
// Layout (from HTML):
//   Left:  40px avatar circle (initials placeholder) + name + ID
//   Right: performance % text, color-coded by band
//
// Avatar: initials-based, background color derived from name hash (consistent
//   per student, no flicker on re-render).
// Bottom border between rows; last row has none (handled by ListView separator).
// ─────────────────────────────────────────────────────────────────────────────
class StudentRow extends StatelessWidget {
  const StudentRow({
    super.key,
    required this.student,
    this.isLast = false,
  });

  final StudentModel student;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final Color perfColor = _performanceColor(student.band);
    final String initials = _initials(student.name);
    final Color avatarBg = _avatarColor(student.name);

    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // placeholder — no student detail screen in scope
          hoverColor: AppColors.surfaceContainerLow.withValues(alpha: 0.6),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Row(
              children: [
                // ── Avatar ──
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: avatarBg,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.outlineVariant,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initials,
                    style: AppTextStyles.labelCaps(
                      color: Colors.white,
                    ).copyWith(fontSize: 13, letterSpacing: 0.5),
                  ),
                ),

                const SizedBox(width: AppTheme.spacingMd),

                // ── Name + ID ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: AppTextStyles.subtitleMd(
                          color: AppColors.onBackground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ID: ${student.id}',
                        style: AppTextStyles.bodySm(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppTheme.spacingMd),

                // ── Performance % ──
                Text(
                  '${student.performancePercent.toStringAsFixed(0)}%',
                  style: AppTextStyles.headlineMd(color: perfColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// Color-code performance text exactly as the HTML does:
  ///   Strong (≥85%)       → emerald (#10B981)
  ///   Mid    (70–84%)     → muted neutral (#576378)
  ///   Needs Support (<70%) → error red (#BA1A1A)
  static Color _performanceColor(PerformanceBand band) {
    switch (band) {
      case PerformanceBand.strong:
        return AppColors.performanceStrong;
      case PerformanceBand.mid:
        return AppColors.performanceMid;
      case PerformanceBand.needsSupport:
        return AppColors.performanceNeedsSupport;
    }
  }

  /// First letter of first name + first letter of last name.
  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first.substring(0, parts.first.length.clamp(1, 2)).toUpperCase();
  }

  /// Deterministic avatar background derived from name hash.
  static const List<Color> _avatarPalette = [
    Color(0xFF006C49), // primary
    Color(0xFF10B981), // emerald
    Color(0xFF005AC2), // tertiary
    Color(0xFF535F74), // secondary
    Color(0xFF3C4A42), // on-surface-variant
    Color(0xFF00422B), // on-primary-container
    Color(0xFF004395), // on-tertiary-fixed-variant
  ];

  static Color _avatarColor(String name) {
    int hash = 0;
    for (final c in name.codeUnits) {
      hash = (hash * 31 + c) & 0x7FFFFFFF;
    }
    return _avatarPalette[hash % _avatarPalette.length];
  }
}
