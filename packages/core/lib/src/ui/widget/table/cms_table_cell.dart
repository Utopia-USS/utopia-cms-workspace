import 'package:flutter/widgets.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';

/// Lays out a single table cell so the column header and the row cells line up.
///
/// Both the column header and the row cells wrap their content through
/// [wrapTableCell], so a column's sizing rule lives in one place.
extension CmsEntryTableCell on CmsEntry<dynamic> {
  /// Width used for a fixed column ([flex] == null) when no [CmsEntry.width] is
  /// provided. Keeps the header and rows aligned without forcing every caller
  /// to pick a width.
  static const double defaultFixedColumnWidth = 72;

  /// Wraps [child] for placement directly inside the table's `Row`.
  ///
  /// Flexing columns ([flex] != null) share the row width via [Expanded]; fixed
  /// columns ([flex] == null) get a constant width ([CmsEntry.width] or
  /// [defaultFixedColumnWidth]) and never stretch.
  Widget wrapTableCell(Widget child) => flex == null
      ? SizedBox(width: width ?? defaultFixedColumnWidth, child: child)
      : Expanded(flex: flex!, child: child);
}
