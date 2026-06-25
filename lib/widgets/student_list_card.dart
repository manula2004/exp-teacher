import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import 'app_card.dart';
import 'empty_state.dart';
import 'skeleton_loader.dart';
import 'student_row.dart';

class StudentListCard extends StatelessWidget {
  const StudentListCard({
    super.key,
    required this.isLoading,
    required this.students,
    required this.selectedFilter,
  });

  final bool isLoading;
  final List<StudentModel> students;
  final String selectedFilter;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          // Column header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd,
              vertical: AppTheme.spacingSm + 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceBright,
              border: Border(
                bottom: BorderSide(color: AppColors.outlineVariant, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'STUDENT NAME',
                    style: AppTextStyles.labelCaps(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  'PERFORMANCE',
                  style: AppTextStyles.labelCaps(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Body
          if (isLoading)
            const SkeletonLoader(rowCount: 6)
          else
            _buildStudentListBody(),
        ],
      ),
    );
  }

  Widget _buildStudentListBody() {
    if (students.isEmpty) {
      return EmptyState(
        icon: Icons.filter_list_off_rounded,
        title: 'No students',
        subtitle: selectedFilter == 'Strong'
            ? 'No students with ≥85% performance in this class.'
            : 'No students currently needing support (below 70%).',
        animate: false,
        compact: true,
      );
    }
    return Column(
      children: [
        for (int i = 0; i < students.length; i++)
          StudentRow(student: students[i], isLast: i == students.length - 1),
      ],
    );
  }
}
