import 'dart:async';

import 'package:flutter/material.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_filter_entry.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_search_filter_entry.dart';
import 'package:utopia_cms/src/model/table/cms_table_action.dart';
import 'package:utopia_cms/src/ui/table_page/state/cms_table_page_state.dart';
import 'package:utopia_cms/src/ui/table_page/view/cms_table_filter_panel.dart';
import 'package:utopia_cms/src/ui/widget/header/cms_header.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table_actions.dart';
import 'package:utopia_cms/src/util/entries_extensions.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms/src/util/json_map.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

class CmsTablePageView extends StatelessWidget {
  final CmsTablePageState state;
  final IList<CmsEntry<dynamic>> entries;
  final IList<CmsFilterEntry<dynamic>> filterEntries;
  final IList<CmsTableAction> customActions;
  final String title;

  const CmsTablePageView({
    super.key,
    required this.state,
    required this.entries,
    required this.title,
    required this.customActions,
    required this.filterEntries,
  });

  @override
  Widget build(BuildContext context) {
    // Column derivation (pinning + adaptation) lives on the state
    // (state.tableEntriesFor) so this view stays hook-free and column/cell
    // identity survives rebuilds.
    final pinnedEntries = entries.pinnedFor(context.pageType);
    final tableEntries = state.tableEntriesFor(context.pageType);
    return MultiWidget([
      (child) => Scaffold(backgroundColor: context.colors.canvas, body: child),
      (child) => SizedBox.expand(child: child),
      (child) => _buildNotificationListener(child: child),
      (_) => _buildContent(context, pinnedEntries: pinnedEntries, tableEntries: tableEntries),
    ]);
  }

  Widget _buildNotificationListener({required Widget child}) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.extentAfter < 50 &&
            state.pagingEnabled &&
            state.items.isNotEmpty &&
            state.computedState.value is! ComputedStateValueInProgress) {
          unawaited(state.computedState.refresh());
        }
        return false;
      },
      child: child,
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required IList<CmsEntry<dynamic>> pinnedEntries,
    required IList<CmsTableEntry<JsonMap>> tableEntries,
  }) {
    final isLoadingMore = state.items.isNotEmpty && state.computedState.value is ComputedStateValueInProgress;
    return CustomScrollView(
      controller: state.scrollController,
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: context.theme.pageTopPadding)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CmsHeader(text: title),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 24),
          sliver: _buildTable(context, pinnedEntries: pinnedEntries, tableEntries: tableEntries),
        ),
        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CmsLoader()),
            ),
          ),
        SliverToBoxAdapter(child: SizedBox(height: context.theme.pageTopPadding)),
      ],
    );
  }

  Widget _buildTable(
    BuildContext context, {
    required IList<CmsEntry<dynamic>> pinnedEntries,
    required IList<CmsTableEntry<JsonMap>> tableEntries,
  }) {
    final currentSortingParams = state.currentSortingParams;
    return CmsTable<JsonMap>(
      rows: state.items.isEmpty && state.computedState.value is ComputedStateValueInProgress ? null : state.items,
      entries: tableEntries,
      // Object identity: the delegate replaces row instances wholesale on every
      // refetch (see CmsTablePageState.updateItem/resetState), so identity is a
      // stable-enough key - matching the previous un-keyed row list behavior.
      rowKey: (row) => row,
      currentSort: currentSortingParams == null
          ? null
          : (columnId: currentSortingParams.fieldKey, descending: currentSortingParams.sortDesc),
      onSortPressed: (tableEntry) {
        final matches = pinnedEntries.where((entry) => entry.key == tableEntry.id);
        if (matches.isNotEmpty) state.onSortPressed(matches.first);
      },
      onRowPressed: state.onEditPressed,
      searchPanel: _buildSearchPanel(context),
      actionsBuilder: !state.hasDefaultActions && customActions.isEmpty
          ? null
          : (context, row, index) {
              return CmsTableActionsButton(
                value: row,
                onUpdate: (value) => state.updateItem(value, index),
                actions: [
                  _buildManageAction(index),
                  if (customActions.isNotEmpty) ...customActions,
                  if (state.params.canDelete) _buildDeleteAction(index),
                ],
              );
            },
    );
  }

  Widget _buildSearchPanel(BuildContext context) {
    final search = _searchEntry();
    return CmsTableFilterPanel(
      searchEntry: search,
      searchHint: _searchHint(search),
      searchValue: search == null ? null : state.filterValues[search.entryKey] as String?,
      otherFilters: filterEntries.where((e) => e is! CmsFilterSearchEntry).toIList(),
      filterValues: state.filterValues,
      onFilterChanged: state.onFilterChanged,
      canCreate: state.params.canCreate,
      onCreatePressed: state.onCreatePressed,
      isReloading: state.computedState.value is ComputedStateValueInProgress,
      onReloadPressed: state.onReloadPressed,
    );
  }

  CmsFilterSearchEntry? _searchEntry() {
    for (final entry in filterEntries) {
      if (entry is CmsFilterSearchEntry) return entry;
    }
    return null;
  }

  String _searchHint(CmsFilterSearchEntry? search) {
    if (search == null) return 'Search';
    final labels = entries
        .where((e) => search.filterKeys.any((key) => key == e.key || key.startsWith('${e.key}.')))
        .map((e) => e.fixedLabel)
        .toList();
    if (labels.isNotEmpty) return 'Search by ${labels.join(', ')}';
    final label = search.label;
    return label == null || label.isEmpty ? 'Search' : label;
  }

  CmsTableAction _buildDeleteAction(int index) {
    return CmsTableAction(
      label: "Delete",
      shouldUpdateTable: false,
      onPressed: (value) async {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await state.onDeletePressed(value, index);
        });
        return null;
      },
    );
  }

  CmsTableAction _buildManageAction(int index) {
    return CmsTableAction(
      label: "Manage",
      shouldUpdateTable: false,
      onPressed: (value) async {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.onEditPressed(value, index);
        });
        return null;
      },
    );
  }
}
