import 'package:flutter/material.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_filter_entry.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_search_filter_entry.dart';
import 'package:utopia_cms/src/util/json_map.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

/// The CMS's table search/filter toolbar: a prominent search bar, a refresh
/// control, the "+" create button, and any remaining (non-search) filter
/// fields - built from [CmsFilterEntry]s and rendered on top of the
/// generalized ui `CmsTableSearchPanel` (which owns the responsive
/// inline/stacked layout and spacing).
///
/// Internal to `utopia_cms` - not part of the public barrel, since it is
/// wired directly to `CmsTablePageState` by `CmsTablePageView`.
class CmsTableFilterPanel extends StatelessWidget {
  final CmsFilterSearchEntry? searchEntry;
  final String searchHint;
  final String? searchValue;
  final IList<CmsFilterEntry<dynamic>> otherFilters;
  final JsonMap filterValues;
  final void Function(String entryKey, Object? value) onFilterChanged;
  final bool canCreate;
  final void Function() onCreatePressed;
  final bool isReloading;
  final void Function() onReloadPressed;

  const CmsTableFilterPanel({
    super.key,
    required this.searchEntry,
    required this.searchHint,
    required this.searchValue,
    required this.otherFilters,
    required this.filterValues,
    required this.onFilterChanged,
    required this.canCreate,
    required this.onCreatePressed,
    required this.isReloading,
    required this.onReloadPressed,
  });

  /// Shared height for every control in the panel (search, filter fields and the
  /// refresh / create buttons) so the toolbar row lines up.
  static const double _controlHeight = 48;

  @override
  Widget build(BuildContext context) {
    return CmsTableSearchPanel(
      searchField: _buildSearch(context),
      filters: [for (final entry in otherFilters) _buildFilterField(context, entry)],
      actions: [_buildReload(context), if (canCreate) _buildCreate(context)],
    );
  }

  Widget _buildSearch(BuildContext context) {
    final entry = searchEntry;
    final field = entry == null
        ? const SizedBox.shrink()
        : CmsSearchField(
            value: searchValue ?? '',
            hint: searchHint,
            formatters: entry.formatters,
            onChanged: (value) => onFilterChanged(entry.entryKey, value),
          );
    return SizedBox(height: _controlHeight, child: field);
  }

  /// The refresh control - the same [CmsButton] as the "+" create button (same
  /// primary fill, square and radius) so the pair shares one colour. Reuses the
  /// button's built-in loading state for the in-progress spinner.
  Widget _buildReload(BuildContext context) {
    return Tooltip(
      message: 'Refresh',
      child: CmsButton(
        dense: true,
        height: _controlHeight,
        maxWidth: _controlHeight,
        loading: isReloading,
        isEnabled: !isReloading,
        onTap: onReloadPressed,
        child: const Icon(Icons.refresh, size: 24),
      ),
    );
  }

  Widget _buildCreate(BuildContext context) {
    return CmsButton(
      dense: true,
      height: _controlHeight,
      maxWidth: _controlHeight,
      onTap: onCreatePressed,
      child: const Icon(Icons.add, size: 24),
    );
  }

  Widget _buildFilterField(BuildContext context, CmsFilterEntry<dynamic> entry) {
    return SizedBox(
      width: (100.0 * entry.flex).clamp(160.0, 320.0),
      height: _controlHeight,
      child: entry.buildField(
        context: context,
        value: entry.fromJson(filterValues[entry.entryKey]),
        onChanged: (value) => onFilterChanged(entry.entryKey, entry.toJson(value)),
      ),
    );
  }
}
