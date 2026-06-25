import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../models/class_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ClassCard — matches the card component from "My Classes - Dashboard.html".
//
// Design details extracted from HTML:
//   bg:          surface-container-lowest (#FFFFFF)
//   border:      1px solid outline-variant (#BBCABF)
//   border-radius: xl = 12px
//   shadow:      0 4px 12px rgba(15,27,45,0.04)
//   left accent: 4px wide accent strip (cornflower blue, visible on press)
//   "Manage Class" button: bg = surface-container, text = primary
// ─────────────────────────────────────────────────────────────────────────────
class ClassCard extends StatefulWidget {
  const ClassCard({super.key, required this.classModel, required this.onTap});

  final ClassModel classModel;
  final VoidCallback onTap;

  @override
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _hovered = true),
      onTapUp: (_) {
        setState(() => _hovered = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          border: Border.all(
            color: _hovered ? AppColors.primary : AppColors.outlineVariant,
            width: 1,
          ),
          boxShadow: AppTheme.cardShadow,
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent strip (4px wide emerald, only visible on hover)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 4,
                color: _hovered
                    ? AppColors.primaryContainer
                    : Colors.transparent,
              ),
              // Card content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Header row: name + more-vert icon ──
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.classModel.name,
                                  style: AppTextStyles.headlineMd(
                                    color: _hovered
                                        ? AppColors.primary
                                        : AppColors.onBackground,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.classModel.subject,
                                  style: AppTextStyles.bodySm(
                                    color: AppColors.onSecondaryContainer,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingXs),
                          Icon(
                            Icons.more_vert,
                            color: _hovered
                                ? AppColors.primary
                                : AppColors.outlineVariant,
                            size: 20,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppTheme.spacingMd),

                      // ── Meta row: student count + exam date ──
                      Row(
                        children: [
                          _MetaChip(
                            icon: Icons.group_outlined,
                            label: '${widget.classModel.studentCount} Students',
                          ),
                          const SizedBox(width: AppTheme.spacingLg),
                          Flexible(
                            child: _MetaChip(
                              icon: Icons.calendar_month_outlined,
                              label:
                                  'Next Exam: ${widget.classModel.nextExamDate}',
                            ),
                          ),
                        ],
                      ),

                      // ── Divider + action button ──
                      Padding(
                        padding: const EdgeInsets.only(top: AppTheme.spacingMd),
                        child: Divider(
                          height: 1,
                          color: AppColors.outlineVariant.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _ManageButton(hovered: _hovered),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Internal widgets ─────────────────────────────────────────────────────────

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.bodySm(color: AppColors.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class _ManageButton extends StatelessWidget {
  const _ManageButton({required this.hovered});

  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      decoration: BoxDecoration(
        color: hovered
            ? AppColors.primaryContainer.withValues(alpha: 0.15)
            : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Text(
        'Manage Class',
        style: AppTextStyles.subtitleMd(color: AppColors.primary),
      ),
    );
  }
}
