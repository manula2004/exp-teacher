import 'package:flutter/material.dart';
import '../mock_data/mock_classes.dart';
import '../models/class_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/class_card.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/dashboard_stats_row.dart';
import '../widgets/empty_state.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/section_header.dart';
import 'class_details_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MyClassesScreen — Screen 1, "My Classes / Dashboard".
//
// States:
//   • Normal:        mockClasses list as ClassCard widgets.
//   • Search active: live case-insensitive filter on name + subject.
//   • No results:    "No results found" EmptyState.
//   • No classes:    "No classes yet" EmptyState (avatar tap = debug toggle).
// ─────────────────────────────────────────────────────────────────────────────
class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({super.key});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _forceEmpty = false; // debug toggle for empty-state preview

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ClassModel> get _filtered {
    if (_forceEmpty) return [];
    if (_searchQuery.isEmpty) return mockClasses;
    final q = _searchQuery.toLowerCase();
    return mockClasses
        .where(
          (c) =>
              c.name.toLowerCase().contains(q) ||
              c.subject.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final bool hasClasses = mockClasses.isNotEmpty && !_forceEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardAppBar(
        onAvatarTap: () => setState(() => _forceEmpty = !_forceEmpty),
      ),
      body: SafeArea(
        top: false,
        child: hasClasses
            ? _buildLoadedBody(filtered)
            : EmptyState(
                icon: Icons.school_outlined,
                title: 'No classes yet',
                subtitle: 'Tap the + button below to add your first class.',
                animate: true,
              ),
      ),
      floatingActionButton: _buildFab(),
      bottomNavigationBar: const AppBottomNav(centreIcon: Icons.school),
    );
  }

  // ── Loaded body ───────────────────────────────────────────────────────────
  Widget _buildLoadedBody(List<ClassModel> filtered) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMarginMobile,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: AppTheme.spacingLg),
              SearchBarWidget(
                controller: _searchController,
                onChanged: (q) => setState(() => _searchQuery = q),
              ),
              const SizedBox(height: AppTheme.spacingLg),
              DashboardStatsRow(activeClassCount: mockClasses.length),
              const SizedBox(height: AppTheme.spacingXl),
              SectionHeader(title: 'Your Classes', onViewAll: () {}),
              const SizedBox(height: AppTheme.spacingMd),
            ]),
          ),
        ),
        filtered.isEmpty
            ? SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.search_off_rounded,
                  title: 'No results found',
                  subtitle: 'No classes match "$_searchQuery".',
                  animate: true,
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacingMarginMobile,
                  0,
                  AppTheme.spacingMarginMobile,
                  AppTheme.spacingXl,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => Padding(
                      padding: EdgeInsets.only(
                        bottom: i < filtered.length - 1
                            ? AppTheme.spacingMd
                            : 0,
                      ),
                      child: ClassCard(
                        classModel: filtered[i],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ClassDetailsScreen(classModel: filtered[i]),
                          ),
                        ),
                      ),
                    ),
                    childCount: filtered.length,
                  ),
                ),
              ),
      ],
    );
  }

  // ── FAB ───────────────────────────────────────────────────────────────────
  Widget _buildFab() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        shape: BoxShape.circle,
        boxShadow: AppTheme.fabShadow,
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Add Class — coming soon!',
                style: AppTextStyles.bodyMd(color: Colors.white),
              ),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              ),
              margin: const EdgeInsets.fromLTRB(
                AppTheme.spacingMd,
                0,
                AppTheme.spacingMd,
                100,
              ),
              duration: const Duration(seconds: 2),
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
