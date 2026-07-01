import 'package:flutter/material.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table_cell.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms/src/util/json_map.dart';
import 'package:utopia_cms/src/util/map_extensions.dart';

/// A single table row. Height, alternating tint and hover colour all come from
/// the theme. The last row rounds its own bottom corners (cell content is inset,
/// so a rounded fill matches the card without an extra ClipRRect layer).
class CmsTableItem extends HookWidget {
  final JsonMap data;
  final IList<CmsEntry<dynamic>> entries;
  final Widget Function(JsonMap)? actionsBuilder;
  final bool isOdd;
  final bool isLast;
  final void Function()? onManagePressed;

  const CmsTableItem({
    super.key,
    required this.data,
    required this.entries,
    required this.isOdd,
    required this.isLast,
    required this.onManagePressed,
    this.actionsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final hovering = useState<bool>(false);
    final baseColor = isOdd ? context.colors.rowAlt : context.colors.surface;

    return MouseRegion(
      onEnter: (_) => hovering.value = true,
      onExit: (_) => hovering.value = false,
      cursor: onManagePressed != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: onManagePressed,
        child: Container(
          height: theme.tileHeight,
          padding: CmsTable.contentPadding,
          decoration: BoxDecoration(
            color: hovering.value ? context.colors.hover : baseColor,
            borderRadius: isLast
                ? BorderRadius.only(bottomLeft: theme.cardRadius.bottomLeft, bottomRight: theme.cardRadius.bottomRight)
                : null,
          ),
          child: Row(
            children: [
              ...entries.map(
                (e) => e.wrapTableCell(
                  Padding(
                    padding: CmsTable.itemPadding,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: e.buildPreview(context, e.fromJson(data.getAtPath(e.key))),
                    ),
                  ),
                ),
              ),
              if (actionsBuilder != null)
                Padding(
                  padding: CmsTable.itemPadding,
                  child: SizedBox(width: CmsTable.actionsWidth, child: actionsBuilder!(data)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
