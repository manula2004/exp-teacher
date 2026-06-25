import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SkeletonLoader — hand-rolled shimmer, matches "Class Details - Loading.html".
//
// HTML shimmer spec:
//   @keyframes shimmer {
//     0%   { background-position: -200% 0; }
//     100% { background-position: 200%  0; }
//   }
//   gradient: linear-gradient(90deg, #EFF4FF 25%, #D3E4FE 50%, #EFF4FF 75%)
//   duration:  1.5s infinite linear
//
// Each skeleton row contains (from HTML):
//   - w-12 h-12 rounded-full  → 48×48 circle
//   - Two text bars (varying width fractions)
//   - Right side: w-16 h-6 rounded-full + w-10 h-3 bar
//
// Renders 6 rows by default, matching the HTML reference.
// ─────────────────────────────────────────────────────────────────────────────
class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({super.key, this.rowCount = 6});

  /// Number of skeleton rows to render (default 6, matching HTML).
  final int rowCount;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    // 1.5s infinite linear — matches HTML animation duration exactly.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _shimmer = Tween<double>(
      begin: -1,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Varying name-bar widths across rows — mirrors the HTML reference's
    // varying widths: 3/4, 2/3, 4/5, 1/2, 3/5, 2/3.
    const List<double> nameBarFractions = [0.75, 0.67, 0.80, 0.50, 0.60, 0.67];
    const List<double> idBarFractions = [0.50, 0.33, 0.25, 0.50, 0.33, 0.50];

    return Column(
      children: List.generate(widget.rowCount, (i) {
        final nameFrac = nameBarFractions[i % nameBarFractions.length];
        final idFrac = idBarFractions[i % idBarFractions.length];

        return Container(
          decoration: i < widget.rowCount - 1
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.outlineVariant.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                )
              : null,
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: AnimatedBuilder(
            animation: _shimmer,
            builder: (context, _) {
              return Row(
                children: [
                  // ── Avatar circle: w-12 h-12 ──
                  _ShimmerBlock(
                    width: 48,
                    height: 48,
                    borderRadius: 9999,
                    shimmerValue: _shimmer.value,
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  // ── Name + ID bars ──
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutBuilder(
                          builder: (ctx, constraints) {
                            return _ShimmerBlock(
                              width: constraints.maxWidth * nameFrac,
                              height: 20,
                              borderRadius: AppTheme.radiusDefault,
                              shimmerValue: _shimmer.value,
                            );
                          },
                        ),
                        const SizedBox(height: AppTheme.spacingXs),
                        LayoutBuilder(
                          builder: (ctx, constraints) {
                            return _ShimmerBlock(
                              width: constraints.maxWidth * idFrac,
                              height: 16,
                              borderRadius: AppTheme.radiusDefault,
                              shimmerValue: _shimmer.value,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  // ── Right: % block + small bar ──
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _ShimmerBlock(
                        width: 64,
                        height: 24,
                        borderRadius: 9999,
                        shimmerValue: _shimmer.value,
                      ),
                      const SizedBox(height: AppTheme.spacingXs),
                      _ShimmerBlock(
                        width: 40,
                        height: 12,
                        borderRadius: AppTheme.radiusDefault,
                        shimmerValue: _shimmer.value,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}

// ── Shimmer block ─────────────────────────────────────────────────────────────
/// A single shimmer-animated rounded rectangle.
/// [shimmerValue] runs from -1 → 2 linearly (produced by the controller).
class _ShimmerBlock extends StatelessWidget {
  const _ShimmerBlock({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.shimmerValue,
  });

  final double width;
  final double height;
  final double borderRadius;
  final double shimmerValue;

  @override
  Widget build(BuildContext context) {
    // Gradient sweep: base → highlight → base, sweeping left-to-right.
    // shimmerValue in [-1, 2] maps the gradient across the block width.
    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: const [
        AppColors.shimmerBase, // #EFF4FF  25%
        AppColors.shimmerHighlight, // #D3E4FE  50%
        AppColors.shimmerBase, // #EFF4FF  75%
      ],
      stops: [
        math.max(0, shimmerValue - 0.5),
        shimmerValue.clamp(0.0, 1.0),
        math.min(1, shimmerValue + 0.5),
      ],
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
