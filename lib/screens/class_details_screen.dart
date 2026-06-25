import 'package:flutter/material.dart';
import '../mock_data/mock_students.dart';
import '../models/class_model.dart';
import '../models/student_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/class_details_app_bar.dart';
import '../widgets/class_stats_card.dart';
import '../widgets/filter_chip_group.dart';
import '../widgets/student_list_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ClassDetailsScreen — Screen 2, "Class Details".
//
// States:
//   • Loading (~1000ms)   → SkeletonLoader
//   • Loaded / filtered   → student rows
//   • Empty filter result → compact EmptyState inside list card
// ─────────────────────────────────────────────────────────────────────────────
class ClassDetailsScreen extends StatefulWidget {
  const ClassDetailsScreen({super.key, required this.classModel});

  final ClassModel classModel;

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  static const _filters = ['All', 'Strong', 'Needs Support'];

  bool _isLoading = true;
  String _selectedFilter = 'All';
  List<StudentModel> _students = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _students = studentsForClass(widget.classModel.id);
        _isLoading = false;
      });
    });
  }

  List<StudentModel> get _filtered {
    switch (_selectedFilter) {
      case 'Strong':
        return _students
            .where((s) => s.band == PerformanceBand.strong)
            .toList();
      case 'Needs Support':
        return _students
            .where((s) => s.band == PerformanceBand.needsSupport)
            .toList();
      default:
        return _students;
    }
  }

  double get _avgPerformance {
    if (_students.isEmpty) return 0;
    return _students.fold<double>(0, (s, e) => s + e.performancePercent) /
        _students.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ClassDetailsAppBar(
        className: widget.classModel.name,
        classSubject: widget.classModel.subject,
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            _sliver(
              ClassStatsCard(
                classModel: widget.classModel,
                isLoading: _isLoading,
                avgPerformance: _avgPerformance,
              ),
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingMarginMobile,
                AppTheme.spacingLg,
                AppTheme.spacingMarginMobile,
                0,
              ),
            ),
            _sliver(
              _buildFilterRow(),
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingMarginMobile,
                AppTheme.spacingLg,
                AppTheme.spacingMarginMobile,
                AppTheme.spacingMd,
              ),
            ),
            _sliver(
              StudentListCard(
                isLoading: _isLoading,
                students: _filtered,
                selectedFilter: _selectedFilter,
              ),
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingMarginMobile,
                0,
                AppTheme.spacingMarginMobile,
                AppTheme.spacingXl,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(centreIcon: Icons.home),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Wraps a widget in a [SliverPadding] + [SliverToBoxAdapter].
  SliverPadding _sliver(Widget child, {required EdgeInsets padding}) {
    return SliverPadding(
      padding: padding,
      sliver: SliverToBoxAdapter(child: child),
    );
  }

  // ── Filter row ────────────────────────────────────────────────────────────
  Widget _buildFilterRow() {
    return Row(
      children: [
        Expanded(
          child: FilterChipGroup(
            filters: _filters,
            selectedFilter: _selectedFilter,
            onFilterChanged: (l) => setState(() => _selectedFilter = l),
          ),
        ),
        const SizedBox(width: AppTheme.spacingMd),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingXs),
            child: Row(
              children: [
                const Icon(Icons.sort, size: 18, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  'Sort',
                  style: AppTextStyles.bodySm(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
