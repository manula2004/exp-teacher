import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FilterChipGroup — single-select chip row from "Class Details - Students.html".
//
// Active chip  (from HTML):
//   bg:     primary-container = #10B981 (emerald)
//   text:   on-primary-container = #00422B
//   shadow: shadow-sm
//   border: none
//
// Inactive chip (from HTML):
//   bg:     transparent
//   border: 1px solid outline-variant = #BBCABF
//   text:   on-surface-variant = #3C4A42
//
// border-radius: xl = 12px (rounded-xl in HTML)
// padding: px-md py-sm = 16px horizontal, 8px vertical
// font:    label-caps (Work Sans 11px/600/+0.05em)
//
// The widget is fully configurable — labels passed in, no hardcoded chip names.
// ─────────────────────────────────────────────────────────────────────────────
class FilterChipGroup extends StatelessWidget {
  const FilterChipGroup({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  /// Ordered list of filter label strings, e.g. ['All', 'Strong', 'Needs Support'].
  final List<String> filters;

  /// The currently active filter label.
  final String selectedFilter;

  /// Called with the new label whenever the user taps a chip.
  final ValueChanged<String> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((label) {
          final bool isActive = label == selectedFilter;
          return Padding(
            padding: EdgeInsets.only(
              right: label == filters.last ? 0 : AppTheme.spacingSm,
            ),
            child: _FilterChip(
              label: label,
              isActive: isActive,
              onTap: () => onFilterChanged(label),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Internal chip widget ──────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: isActive
            ? null
            : Border.all(color: AppColors.outlineVariant, width: 1),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primaryContainer.withValues(alpha: 0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd,
              vertical: AppTheme.spacingSm,
            ),
            child: Text(
              label,
              style: AppTextStyles.labelCaps(
                color: isActive
                    ? AppColors.onPrimaryContainer
                    : AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
