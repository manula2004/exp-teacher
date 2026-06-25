import 'package:flutter/material.dart';
import '../mock_data/mock_classes.dart';
import '../models/class_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/class_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/search_bar_widget.dart';
import 'class_details_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MyClassesScreen — Screen 1, "My Classes / Dashboard".
//
// References:
//   "My Classes - Dashboard.html"   → loaded/normal state
//   "My Classes - Empty State.html" → empty state (no classes / no results)
//
// States:
//   • Normal:        mockClasses list rendered as ClassCard widgets.
//   • Search active: list filtered live by name/subject (case-insensitive).
//   • No results:    "No classes match '[query]'" EmptyState.
//   • No classes:    "No classes yet" EmptyState (reached via debug toggle).
//
// FAB: Tap shows a SnackBar placeholder — full add-class flow out of scope.
// ─────────────────────────────────────────────────────────────────────────────
class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({super.key});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Debug toggle: set to true to preview the "no classes at all" empty state.
  bool _forceEmpty = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ClassModel> get _filteredClasses {
    if (_forceEmpty) return [];
    if (_searchQuery.isEmpty) return mockClasses;
    final q = _searchQuery.toLowerCase();
    return mockClasses
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.subject.toLowerCase().contains(q))
        .toList();
  }

  void _onSearch(String query) => setState(() => _searchQuery = query);

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = '');
  }

  void _onFabTap() {
    ScaffoldMessenger.of(context).showSnackBar(
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
        margin: const EdgeInsets.only(
          left: AppTheme.spacingMd,
          right: AppTheme.spacingMd,
          bottom: 100,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredClasses;
    final bool hasClasses = mockClasses.isNotEmpty && !_forceEmpty;
    final bool hasResults = filtered.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      // ── Top App Bar ──────────────────────────────────────────────────────
      appBar: _buildAppBar(),
      // ── Body ─────────────────────────────────────────────────────────────
      body: SafeArea(
        top: false,
        child: hasClasses
            ? _buildLoadedBody(filtered, hasResults)
            : _buildNoClassesEmpty(),
      ),
      // ── FAB ──────────────────────────────────────────────────────────────
      floatingActionButton: _buildFab(),
      // ── Bottom Nav ───────────────────────────────────────────────────────
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: AppTheme.spacingMarginMobile,
      title: Row(
        children: [
          // ── Menu icon ──
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(9999),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.menu, color: AppColors.primary, size: 24),
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          // ── Greeting + name ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Good Morning,',
                  style: AppTextStyles.headlineLgMobile(
                      color: AppColors.onSurface),
                ),
                Text(
                  'Mrs. Smith',
                  style: AppTextStyles.subtitleMd(
                      color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // ── Notification bell with red dot ──
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
            // Red notification badge (matching HTML: w-2 h-2 bg-error)
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
        // ── Avatar ──
        GestureDetector(
          onTap: () {
            // Debug toggle: tap avatar to toggle the no-classes empty state.
            setState(() => _forceEmpty = !_forceEmpty);
          },
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: AppTheme.spacingMd),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryContainer,
              border: Border.all(
                color: AppColors.primaryContainer,
                width: 2,
              ),
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

  // ── Loaded body ───────────────────────────────────────────────────────────
  Widget _buildLoadedBody(List<ClassModel> filtered, bool hasResults) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMarginMobile,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: AppTheme.spacingLg),

              // ── Search bar ──
              SearchBarWidget(
                controller: _searchController,
                onChanged: _onSearch,
                hintText: 'Search classes',
              ),

              const SizedBox(height: AppTheme.spacingLg),

              // ── Stats overview ──
              _buildStatsRow(),

              const SizedBox(height: AppTheme.spacingXl),

              // ── Section header ──
              _buildSectionHeader(),

              const SizedBox(height: AppTheme.spacingMd),
            ]),
          ),
        ),

        // ── Class list or search-empty state ──
        if (!hasResults)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildSearchEmpty(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.spacingMarginMobile,
              0,
              AppTheme.spacingMarginMobile,
              AppTheme.spacingXl,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cls = filtered[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < filtered.length - 1
                          ? AppTheme.spacingMd
                          : 0,
                    ),
                    child: ClassCard(
                      classModel: cls,
                      onTap: () => _navigateToDetails(cls),
                    ),
                  );
                },
                childCount: filtered.length,
              ),
            ),
          ),
      ],
    );
  }

  // ── Stats overview card ───────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: [
        // ── Teaching status (md:col-span-2) ──
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              border: Border.all(
                color: AppColors.primaryContainer.withValues(alpha: 0.20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TEACHING STATUS',
                        style: AppTextStyles.labelCaps(
                            color: AppColors.primary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${mockClasses.length} Classes Active Today',
                        style: AppTextStyles.headlineMd(
                            color: AppColors.onPrimaryContainer),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                  child: const Icon(
                    Icons.analytics_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacingMd),
        // ── Avg attendance ──
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Avg Attendance',
                  style: AppTextStyles.bodySm(
                      color: AppColors.onSecondaryContainer),
                ),
                const SizedBox(height: 4),
                Text(
                  '94%',
                  style: AppTextStyles.headlineLg(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Section header ────────────────────────────────────────────────────────
  Widget _buildSectionHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Your Classes',
            style: AppTextStyles.headlineMd(color: AppColors.onBackground),
          ),
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All',
                  style:
                      AppTextStyles.subtitleMd(color: AppColors.primary),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.primary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Search empty state ────────────────────────────────────────────────────
  Widget _buildSearchEmpty() {
    return EmptyState(
      icon: Icons.search_off_rounded,
      title: 'No results found',
      subtitle:
          'No classes match "$_searchQuery". Try a different search or clear the filter.',
      animate: true,
    );
  }

  // ── No-classes empty state ────────────────────────────────────────────────
  Widget _buildNoClassesEmpty() {
    return EmptyState(
      icon: Icons.school_outlined,
      title: 'No classes yet',
      subtitle:
          'Tap the + button below to add your first class and start managing your curriculum.',
      animate: true,
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
          onTap: _onFabTap,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  // ── Bottom navigation bar ─────────────────────────────────────────────────
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
          _NavItem(icon: Icons.grid_view_outlined, label: 'Dashboard'),
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
                    color:
                        AppColors.primaryContainer.withValues(alpha: 0.30),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 24),
            ),
          ),
          _NavItem(
              icon: Icons.calendar_today_outlined, label: 'Schedule'),
        ],
      ),
    );
  }

  // ── Navigation ────────────────────────────────────────────────────────────
  void _navigateToDetails(ClassModel cls) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClassDetailsScreen(classModel: cls),
      ),
    );
  }
}

// ── Bottom nav item ───────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingXs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.onSecondaryContainer, size: 24),
          ],
        ),
      ),
    );
  }
}


