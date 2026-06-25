import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SearchBarWidget — matches the search bar from both dashboard HTML files.
//
// From "My Classes - Dashboard.html":
//   bg:            #F1F5F9 (surface-container-low variant)
//   border:        1px solid outline-variant (#BBCABF)
//   focus border:  primary (#006C49)
//   border-radius: lg = 8px (rounded-lg in first file) /
//                  xl = 12px (rounded-xl in empty-state file)
//   padding:       pl-12 pr-12 py-3 ≈ left 48px, right 48px, vertical 12px
//   leading icon:  search (outline, #6C7A71)
//   trailing icon: mic   (outline, #6C7A71)
//   font:          body-md (Hanken Grotesk 14px)
//   placeholder:   "Search classes"
// ─────────────────────────────────────────────────────────────────────────────
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.onChanged,
    this.hintText = 'Search classes',
    this.controller,
  });

  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController? controller;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Only dispose if we created it ourselves.
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(
          color: _isFocused ? AppColors.primary : AppColors.outlineVariant,
          width: 1,
        ),
      ),
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          style: AppTextStyles.bodyMd(color: AppColors.onBackground),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.bodyMd(color: AppColors.onSurfaceVariant),
            // left search icon
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
              child: Icon(Icons.search, color: AppColors.outline, size: 22),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 48),
            // right mic icon
            suffixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
              child: Icon(
                Icons.mic_none_outlined,
                color: AppColors.outline,
                size: 22,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 48),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            isDense: true,
          ),
        ),
      ),
    );
  }
}
