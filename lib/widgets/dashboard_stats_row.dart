import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

class DashboardStatsRow extends StatelessWidget {
  const DashboardStatsRow({super.key, required this.activeClassCount});

  final int activeClassCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Teaching status card (flex 2)
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              border: Border.all(
                color: AppColors.primaryContainer.withValues(alpha: 0.20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TEACHING STATUS',
                        style: AppTextStyles.labelCaps(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$activeClassCount Classes Active Today',
                        style: AppTextStyles.headlineMd(
                          color: AppColors.onPrimaryContainer,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                  child: const Icon(
                    Icons.analytics_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacingMd),
        // Avg attendance card (flex 1)
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Avg Attendance',
                  style: AppTextStyles.bodySm(
                    color: AppColors.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '94%',
                    style: AppTextStyles.headlineLg(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
