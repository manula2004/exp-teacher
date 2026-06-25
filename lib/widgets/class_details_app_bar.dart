import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

class ClassDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ClassDetailsAppBar({
    super.key,
    required this.className,
    required this.classSubject,
  });

  final String className;
  final String classSubject;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Navigator.pop(context),
        tooltip: 'Back',
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            className,
            style: AppTextStyles.headlineMd(color: AppColors.onSurface),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            classSubject,
            style: AppTextStyles.bodySm(color: AppColors.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        const Icon(
          Icons.notifications_none_outlined,
          color: AppColors.onSurfaceVariant,
          size: 22,
        ),
        const SizedBox(width: AppTheme.spacingSm),
        Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.only(right: AppTheme.spacingMd),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondaryContainer,
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: const Center(
            child: Icon(
              Icons.person,
              color: AppColors.onSecondaryContainer,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
