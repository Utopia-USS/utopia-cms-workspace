import 'package:flutter/material.dart';
import 'package:utopia_cms/src/delegate/cms_delegate.dart';
import 'package:utopia_cms/src/model/cms_filter.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_date_entry.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_search_filter_entry.dart';
import 'package:utopia_cms/src/ui/table_page/cms_table_page.dart';
import 'package:utopia_cms/src/ui/widget/table/cms_table.dart';
import 'package:utopia_cms/src/ui/widget/wrapper/cms_field_wrapper.dart';
import 'package:utopia_cms/src/util/json_map.dart';

/// [CmsFilterEntry] is an interface of a basic [CmsTablePage] filter component.
///
/// There are few basic entries already implemented:
/// * [CmsFilterSearchEntry] for searching [String] values
/// * [CmsDateEntry] for creating date filter constraints
@optionalTypeArgs
abstract class CmsFilterEntry<T> {
  /// [filterKeys] are paths to values filtered in get of [CmsDelegate].
  ///
  /// It may be staggered, e.g. `user.data.image`.
  /// To see how it works check `MapExtensions`.
  abstract final List<String> filterKeys;

  ///identity of CmsFilterEntry
  ///
  ///Necessary for internal state management
  abstract final String entryKey;

  ///  * [label] displays the name of the entry. To find out more check [fixedLabel]
  abstract final String? label;

  ///  * Defines size of the [CmsFilterEntry] in the [CmsTable]
  abstract final int flex;

  ///  Builder of the filter field. Recommended to be wrapped with [CmsFieldWrapper]
  Widget buildField({required BuildContext context, required T value, required void Function(T) onChanged});

  /// Builder of filters for [CmsDelegate].
  ///
  /// `List<CmsFilterEntry>` joins filters with AND operator.
  /// Different behavior can be achieved with a custom [CmsFilterEntry].
  CmsFilter filterFromValues(JsonMap value);

  /// simple toJson method, e.g. 12.toString for an int value.
  Object? toJson(T value) => value;

  /// simple fromJson method, e.g. int.parse(json.toString) for an int value.
  T? fromJson(Object? json) => json as T?;

  /// Real display of the field.
  String get fixedLabel => label ?? '';
}
