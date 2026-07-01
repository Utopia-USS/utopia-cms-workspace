import 'package:flutter/material.dart';
import 'package:utopia_cms/src/model/cms_functions_params.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/ui/widget/layout/cms_card.dart';
import 'package:utopia_cms/src/ui/widget/layout/cms_divider.dart';
import 'package:utopia_cms/src/ui/widget/loading/cms_mock_loading_box.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table_cell.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table_header.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table_item.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms/src/util/json_map.dart';

/// The table itself, rendered as a sliver so it composes into the page's
/// [CustomScrollView].
///
/// Everything lives in one card ([cmsCardSliver]): a pinned header (the
/// [searchPanel] + the column headers + a divider) followed by a divider-
/// separated [SliverList] of rows. Loading and empty states swap the row list.
class CmsTable extends HookWidget {
  final bool showLoader;
  final IList<JsonMap> values;
  final IList<CmsEntry<dynamic>> entries;

  /// The search / filter panel shown at the top of the card, above the columns.
  final Widget searchPanel;

  final CmsFunctionsSortingParams? currentSortParams;
  final void Function(JsonMap, int index)? onManagePressed;
  final void Function(CmsEntry) onSortPressed;
  final Widget Function(JsonMap, int index)? actionsBuilder;

  const CmsTable({
    super.key,
    required this.values,
    required this.entries,
    required this.showLoader,
    required this.searchPanel,
    required this.onSortPressed,
    required this.currentSortParams,
    required this.onManagePressed,
    this.actionsBuilder,
  });

  static const double actionsWidth = 24;
  static const EdgeInsets itemPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return cmsCardSliver(
      context,
      sliver: SliverMainAxisGroup(
        slivers: [
          _buildHeader(context),
          if (showLoader) _buildLoader(context) else if (values.isEmpty) _buildEmpty(context) else _buildList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final cardRadius = context.theme.cardRadius;
    // Rounded opaque fill (no ClipRRect layer): the panel content is inset, so
    // rounding the background is enough to keep the card's top corners, and the
    // opaque surface hides rows scrolling under the pinned header.
    return PinnedHeaderSliver(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.only(topLeft: cardRadius.topLeft, topRight: cardRadius.topRight),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            searchPanel,
            CmsTableHeader(
              entries: entries,
              currentSortParams: currentSortParams,
              onSortPressed: onSortPressed,
              hasActions: actionsBuilder != null,
            ),
            const CmsDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return SliverList.separated(
      itemCount: values.length,
      separatorBuilder: (_, _) => const CmsDivider(),
      itemBuilder: (context, index) => CmsTableItem(
        data: values[index],
        entries: entries,
        isOdd: index.isOdd,
        isLast: index == values.length - 1,
        onManagePressed: onManagePressed == null ? null : () => onManagePressed!(values[index], index),
        actionsBuilder: actionsBuilder == null ? null : (data) => actionsBuilder!(data, index),
      ),
    );
  }

  /// Loading placeholder. Mirrors [_buildList] / [CmsTableItem] exactly - same
  /// row height, padding, column layout, alternating tint and dividers - so the
  /// shimmer reads as real rows instead of floating boxes. Each cell holds a
  /// thin, left-aligned bar where the cell's preview content would sit.
  Widget _buildLoader(BuildContext context) {
    const itemCount = 12;
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (_, _) => const CmsDivider(),
      itemBuilder: (context, index) => _buildLoaderRow(context, index, isLast: index == itemCount - 1),
    );
  }

  Widget _buildLoaderRow(BuildContext context, int index, {required bool isLast}) {
    final theme = context.theme;
    final baseColor = index.isOdd ? context.colors.rowAlt : context.colors.surface;
    return Container(
      height: theme.tileHeight,
      padding: CmsTable.contentPadding,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: isLast
            ? BorderRadius.only(bottomLeft: theme.cardRadius.bottomLeft, bottomRight: theme.cardRadius.bottomRight)
            : null,
      ),
      child: Row(
        children: [
          ...entries.map(
            (e) => e.wrapTableCell(
              const Padding(
                padding: CmsTable.itemPadding,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: CmsMockLoadingBox(width: double.infinity, height: 12),
                  ),
                ),
              ),
            ),
          ),
          if (actionsBuilder != null)
            const Padding(
              padding: CmsTable.itemPadding,
              child: SizedBox(
                width: CmsTable.actionsWidth,
                child: CmsMockLoadingBox(width: double.infinity, height: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Text('No items', style: context.textStyles.text.copyWith(color: context.colors.hint)),
        ),
      ),
    );
  }
}
