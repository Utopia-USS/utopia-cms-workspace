import 'package:flutter/widgets.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/util/json_map.dart';
import 'package:utopia_cms/src/util/map_extensions.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

/// Adapts a [CmsEntry] into the generalized ui `CmsTableEntry<JsonMap>` column
/// shape consumed by `CmsTable<JsonMap>`.
extension CmsEntryTableColumnExtension on CmsEntry<dynamic> {
  /// Builds the column for this entry: [key] as the sort/search id,
  /// [CmsEntry.fixedLabel] as the header, [flex]/`width` passed through as-is,
  /// and a cell that replicates the previous `CmsTableItem`'s preview
  /// rendering exactly - `Padding`/`Align` sizing now lives in the ui
  /// `CmsTableItem`, so this builder must NOT re-wrap the preview.
  ///
  /// Sorting mirrors the old header's rule exactly: a column offers sorting
  /// iff [CmsEntry.sortable] (`modifier.sortable`) is `true`. There is no
  /// client-side comparator - sorting is always resolved server-side via the
  /// table page's delegate - so [CmsTableEntry.sortable] is set explicitly as
  /// an override instead of deriving it from a `sortBy` function.
  CmsTableEntry<JsonMap> toTableEntry() {
    Widget cellBuilder(BuildContext context, JsonMap row) => buildPreview(context, fromJson(row.getAtPath(key)));

    return flex != null
        ? CmsTableEntry<JsonMap>(id: key, title: fixedLabel, flex: flex, cellBuilder: cellBuilder, sortable: sortable)
        : CmsTableEntry<JsonMap>.fixed(
            id: key,
            title: fixedLabel,
            width: width,
            cellBuilder: cellBuilder,
            sortable: sortable,
          );
  }
}

/// Maps a list of [CmsEntry] into the ui table's column list, in order.
extension CmsEntriesTableColumnExtension on IList<CmsEntry<dynamic>> {
  /// See [CmsEntryTableColumnExtension.toTableEntry].
  IList<CmsTableEntry<JsonMap>> toTableEntries() => map((entry) => entry.toTableEntry()).toIList();
}
