import 'package:flutter/widgets.dart';
import 'package:utopia_cms_ui/src/widget/table/cms_table_entry.dart';

/// Lays out a single table cell so the column header and the row cells line up.
///
/// Both the table's internal header row and item rows wrap their content
/// through [wrapTableCell], so a column's sizing rule lives in one place.
extension CmsTableEntryCellExtension on CmsTableEntry<dynamic> {
  /// Width used for a fixed column ([CmsTableEntry.flex] == null) when no
  /// [CmsTableEntry.width] is provided. Keeps the header and rows aligned
  /// without forcing every caller to pick a width.
  static const double defaultFixedColumnWidth = 72;

  /// Wraps [child] for placement directly inside the table row's `Row`.
  ///
  /// Flexing columns ([CmsTableEntry.flex] != null) share the row width via
  /// [Expanded]; fixed columns ([CmsTableEntry.flex] == null) get a constant
  /// width ([CmsTableEntry.width] or [defaultFixedColumnWidth]) and never
  /// stretch.
  Widget wrapTableCell(Widget child) =>
      flex == null ? SizedBox(width: width ?? defaultFixedColumnWidth, child: child) : Expanded(flex: flex!, child: child);
}
