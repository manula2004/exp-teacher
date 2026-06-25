import 'package:flutter/material.dart';
import '../mock_data/mock_students.dart';
import '../models/class_model.dart';
import '../models/student_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/filter_chip_group.dart';
import '../widgets/skeleton_loader.dart';
import '../widgets/student_row.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ClassDetailsScreen — Screen 2, "Class Details".
//
// References:
//   "Class Details - Students.html"      → loaded state
//   "Class Details - Loading State.html" → skeleton/loading state
//
// States:
//   • Loading (800–1200ms):  SkeletonLoader shown, matches loading HTML exactly.
//   • Loaded + filter "All": full student list.
//   • Loaded + filter "Strong" / "Needs Support": filtered list.
//   • Empty filter result:   inline compact EmptyState within the list card.
//
// Performance banding (from spec, confirmed against HTML row colours):
//   Strong       → ≥ 85%   → emerald (#10B981)
//   Mid          → 70–84%  → neutral (#576378) — only shown under "All"
//   Needs Support → < 70%  → red    (#BA1A1A)
// ─────────────────────────────────────────────────────────────────────────────
class ClassDetailsScreen extends StatefulWidget {
  const ClassDetailsScreen({super.key, required this.classModel});

  final ClassModel classModel;

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  static const List<String> _filterLabels = ['All', 'Strong', 'Needs Support'];

  bool _isLoading = true;
  String _selectedFilter = 'All';
  List<StudentModel> _students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  // Simulates a real async load with a mock 800–1200ms delay.
  Future<void> _loadStudents() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      _students = studentsForClass(widget.classModel.id);
      _isLoading = false;
    });
  }

  List<StudentModel> get _filteredStudents {
    switch (_selectedFilter) {
      case 'Strong':
        return _students
            .where((s) => s.band == PerformanceBand.strong)
            .toList();
      case 'Needs Support':
        return _students
            .where((s) => s.band == PerformanceBand.needsSupport)
            .toList();
      default: // 'All'
        return _students;
    }
  }

  double get _averagePerformance {
    if (_students.isEmpty) return 0;
    final total = _students.fold<double>(
      0,
      (sum, s) => sum + s.performancePercent,
    );
    return total / _students.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            // ── Stats card ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingMarginMobile,
                AppTheme.spacingLg,
                AppTheme.spacingMarginMobile,
                0,
              ),
              sliver: SliverToBoxAdapter(child: _buildStatsCard()),
            ),

            // ── Filter chips ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingMarginMobile,
                AppTheme.spacingLg,
                AppTheme.spacingMarginMobile,
                AppTheme.spacingMd,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: FilterChipGroup(
                        filters: _filterLabels,
                        selectedFilter: _selectedFilter,
                        onFilterChanged: (label) =>
                            setState(() => _selectedFilter = label),
                      ),
                    ),
                    // Sort button (right side, matches HTML)
                    const SizedBox(width: AppTheme.spacingMd),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingXs,
                          vertical: AppTheme.spacingXs,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sort,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Sort',
                              style: AppTextStyles.bodySm(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Student list card ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingMarginMobile,
                0,
                AppTheme.spacingMarginMobile,
                AppTheme.spacingXl,
              ),
              sliver: SliverToBoxAdapter(child: _buildStudentListCard()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
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
            widget.classModel.name,
            style: AppTextStyles.headlineMd(color: AppColors.onSurface),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.classModel.subject,
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

  // ── Stats card (emerald top stripe) ──────────────────────────────────────
  Widget _buildStatsCard() {
    // From HTML: .emerald-stripe { border-top: 4px solid #10B981; }
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: AppTheme.cardShadow,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          // Emerald top stripe (4px, full width)
          Container(height: 4, color: AppColors.primaryContainer),
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Row(
              children: [
                Expanded(
                  child: _StatCell(
                    label: 'SCHEDULE',
                    value: widget.classModel.schedule,
                    isLarge: false,
                  ),
                ),
                Expanded(
                  child: _StatCell(
                    label: 'TOTAL STUDENTS',
                    value: '${widget.classModel.studentCount}',
                    isLarge: true,
                  ),
                ),
                Expanded(
                  child: _StatCell(
                    label: 'AVG PERFORMANCE',
                    value: _isLoading
                        ? '—'
                        : '${_averagePerformance.toStringAsFixed(1)}%',
                    isLarge: false,
                  ),
                ),
                Expanded(
                  child: _StatCell(
                    label: 'ROOM',
                    value: widget.classModel.room,
                    isLarge: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Student list card ─────────────────────────────────────────────────────
  Widget _buildStudentListCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: AppTheme.cardShadow,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          // ── List header row (STUDENT NAME / PERFORMANCE) ──
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

          // ── Body: skeleton / students / inline empty ──
          if (_isLoading)
            const SkeletonLoader(rowCount: 6)
          else
            _buildStudentListBody(),
        ],
      ),
    );
  }

  Widget _buildStudentListBody() {
    final students = _filteredStudents;

    if (students.isEmpty) {
      return EmptyState(
        icon: Icons.filter_list_off_rounded,
        title: 'No students',
        subtitle: _selectedFilter == 'Strong'
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

  // ── Bottom nav ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
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
          _DetailsNavItem(icon: Icons.grid_view_outlined, label: 'DASHBOARD'),
          // ── Active centre pill ──
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
              child: const Icon(Icons.home, color: Colors.white, size: 24),
            ),
          ),
          _DetailsNavItem(
            icon: Icons.calendar_today_outlined,
            label: 'SCHEDULE',
          ),
        ],
      ),
    );
  }
}

// ── Stat cell widget ──────────────────────────────────────────────────────────
class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.label,
    required this.value,
    required this.isLarge,
  });

  final String label;
  final String value;

  /// If true, renders the value in headline-lg (primary colour) — used for
  /// Total Students in the HTML: `font-headline-lg text-primary`.
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
        isLarge
            ? Text(
                value,
                style: AppTextStyles.headlineLg(color: AppColors.primary),
              )
            : Text(
                value,
                style: AppTextStyles.subtitleMd(color: AppColors.onBackground),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }
}

// ── Bottom nav item (details screen variant) ──────────────────────────────────
class _DetailsNavItem extends StatelessWidget {
  const _DetailsNavItem({required this.icon, required this.label});

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
            Icon(icon, color: AppColors.onSecondaryContainer, size: 22),
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
