import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key, required this.onAvatarTap});

  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: AppTheme.spacingMarginMobile,
      title: Row(
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(9999),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.menu, color: AppColors.primary, size: 24),
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Good Morning,',
                  style: AppTextStyles.headlineLgMobile(
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  'Mrs. Smith',
                  style: AppTextStyles.subtitleMd(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Notification bell with badge
        Stack(
          children: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(9999),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.onSurfaceVariant,
                  size: 24,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 1.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: AppTheme.spacingSm),
        // Avatar
        GestureDetector(
          onTap: onAvatarTap,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: AppTheme.spacingMd),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryContainer,
              border: Border.all(color: AppColors.primaryContainer, width: 2),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: AppColors.onSecondaryContainer,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
