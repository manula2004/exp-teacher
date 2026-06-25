import 'package:flutter/material.dart';
import '../models/class_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import 'app_card.dart';

class ClassStatsCard extends StatelessWidget {
  const ClassStatsCard({
    super.key,
    required this.classModel,
    required this.isLoading,
    required this.avgPerformance,
  });

  final ClassModel classModel;
  final bool isLoading;
  final double avgPerformance;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Container(height: 4, color: AppColors.primaryContainer),
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatCell(
                        label: 'SCHEDULE',
                        value: classModel.schedule,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Expanded(
                      child: _StatCell(
                        label: 'TOTAL STUDENTS',
                        value: '${classModel.studentCount}',
                        isLarge: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Row(
                  children: [
                    Expanded(
                      child: _StatCell(
                        label: 'AVG PERFORMANCE',
                        value: isLoading
                            ? '—'
                            : '${avgPerformance.toStringAsFixed(1)}%',
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Expanded(
                      child: _StatCell(label: 'ROOM', value: classModel.room),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat cell ─────────────────────────────────────────────────────────────────
class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.label,
    required this.value,
    this.isLarge = false,
  });

  final String label;
  final String value;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelCaps(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        if (isLarge)
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: AppTextStyles.headlineLg(color: AppColors.primary),
            ),
          )
        else
          Text(
            value,
            style: AppTextStyles.subtitleMd(color: AppColors.onBackground),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
