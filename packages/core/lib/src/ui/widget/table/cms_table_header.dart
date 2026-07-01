import 'package:flutter/material.dart';
import 'package:utopia_cms/src/model/cms_functions_params.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table_cell.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';
import 'package:utopia_cms/src/util/foundation.dart';

/// The column-header row that sits inside the table card's pinned header,
/// above the divider and the rows. Columns line up with `CmsTableItem` cells.
class CmsTableHeader extends StatelessWidget {
  final IList<CmsEntry<dynamic>> entries;
  final CmsFunctionsSortingParams? currentSortParams;
  final void Function(CmsEntry) onSortPressed;
  final bool hasActions;

  const CmsTableHeader({
    super.key,
    required this.entries,
    required this.currentSortParams,
    required this.onSortPressed,
    required this.hasActions,
  });

  @override
  Widget build(BuildContext context) {
    // Column headers are a restrained take on the row data: same medium weight
    // (capped at w500 - any heavier reads as too bold here), only a hair larger,
    // not the full section/page title size which renders too big and too heavy.
    final body = context.textStyles.text;
    final style = body.copyWith(
      color: context.colors.text,
      fontWeight: FontWeight.w500,
      fontSize: (body.fontSize ?? 14) + 1,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          ...entries.map((e) => e.wrapTableCell(_buildHeaderItem(context, e, style))),
          if (hasActions)
            const Padding(
              padding: CmsTable.itemPadding,
              child: SizedBox(width: CmsTable.actionsWidth),
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(BuildContext context, CmsEntry entry, TextStyle style) {
    final content = Padding(
      padding: CmsTable.itemPadding,
      child: Row(
        children: [
          if (entry.sortable) _buildSortingIcons(context, entry),
          Flexible(
            child: Text(entry.fixedLabel, style: style, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
    if (!entry.sortable) return content;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: () => onSortPressed(entry), child: content),
    );
  }

  Widget _buildSortingIcons(BuildContext context, CmsEntry entry) {
    final isCurrent = entry.key == currentSortParams?.fieldKey;
    final activeColor = context.colors.text;
    final inactiveColor = context.colors.hint;
    final upActive = isCurrent && currentSortParams!.sortDesc;
    final downActive = isCurrent && !currentSortParams!.sortDesc;

    Widget arrow(IconData icon, Alignment alignment, {required bool active}) => Align(
      alignment: alignment,
      child: Icon(icon, size: 16, color: active ? activeColor : inactiveColor),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SizedBox(
        width: 16,
        height: 22,
        child: Stack(
          children: [
            arrow(Icons.keyboard_arrow_up_rounded, const Alignment(0, -0.6), active: upActive),
            arrow(Icons.keyboard_arrow_down_rounded, const Alignment(0, 0.6), active: downActive),
          ],
        ),
      ),
    );
  }
}
