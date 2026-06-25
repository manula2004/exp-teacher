import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// EmptyState — configurable empty-state widget used in two contexts:
//
//   1. No classes at all (full-screen, triggered by empty mock list or toggle).
//   2. No search results (full-screen, within class list area).
//   3. No filter results (inline, within student list).
//
// From "My Classes - Empty State.html":
//   Icon circle:  w-24 h-24 = 96px, bg = surface-container (#E5EEFF)
//   Icon:         school, 48px, on-surface-variant (#3C4A42)
//   Title:        headline-lg, on-background
//   Subtitle:     body-md, on-surface-variant, max-w-xs centered
//
// The fade+translateY entrance animation (0.6s cubic) is replicated via
// Flutter's AnimationController + CurvedAnimation.
// ─────────────────────────────────────────────────────────────────────────────
class EmptyState extends StatefulWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.animate = true,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  /// If true, plays the entrance fade+slide animation on first build.
  final bool animate;

  /// If true, uses a more compact layout suitable for inline use (filter empty).
  final bool compact;

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Matches HTML: cubic-bezier(0.16, 1, 0.3, 1) ≈ Curves.easeOutExpo
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(curve);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05), // translateY(10px) ≈ 5% of widget height
      end: Offset.zero,
    ).animate(curve);

    if (widget.animate) {
      // 100ms delay matching the HTML setTimeout
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double iconCircle = widget.compact ? 64 : 96;
    final double iconSize = widget.compact ? 32 : 48;

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.compact ? AppTheme.spacingLg : AppTheme.spacingXl,
              horizontal: AppTheme.spacingLg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Icon circle ──
                Container(
                  width: iconCircle,
                  height: iconCircle,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: iconSize,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: widget.compact ? AppTheme.spacingMd : AppTheme.spacingLg),

                // ── Title ──
                Text(
                  widget.title,
                  style: widget.compact
                      ? AppTextStyles.headlineMd(color: AppColors.onBackground)
                      : AppTextStyles.headlineLg(color: AppColors.onBackground),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppTheme.spacingSm),

                // ── Subtitle ──
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Text(
                    widget.subtitle,
                    style: AppTextStyles.bodyMd(
                      color: AppColors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                if (!widget.compact) ...[
                  SizedBox(height: AppTheme.spacingXl),
                  // Decorative bars (from HTML: opacity-20)
                  Opacity(
                    opacity: 0.20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 128,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.outlineVariant,
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusLg),
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Container(
                          width: 80,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.outlineVariant,
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusLg),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
