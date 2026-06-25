import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppBottomNav — shared bottom navigation bar used by both screens.
//
// Renders two flanking nav items with an elevated centre pill.
// [centreIcon] defaults to Icons.school on Screen 1; Icons.home on Screen 2.
// ─────────────────────────────────────────────────────────────────────────────
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, this.centreIcon = Icons.school});

  final IconData centreIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.onBackground.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppNavItem(icon: Icons.grid_view_outlined, label: 'DASHBOARD'),
          // ── Floating centre pill ──
          Transform.translate(
            offset: const Offset(0, -16),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryContainer.withValues(alpha: 0.30),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(centreIcon, color: Colors.white, size: 24),
            ),
          ),
          const AppNavItem(
            icon: Icons.calendar_today_outlined,
            label: 'SCHEDULE',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppNavItem — a single icon + label nav item used inside AppBottomNav.
// ─────────────────────────────────────────────────────────────────────────────
class AppNavItem extends StatelessWidget {
  const AppNavItem({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingXs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.onSecondaryContainer, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.labelCaps(
                color: AppColors.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
