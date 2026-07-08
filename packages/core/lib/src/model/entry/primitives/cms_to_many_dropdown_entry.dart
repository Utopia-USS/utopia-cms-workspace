import 'package:flutter/material.dart';
import 'package:utopia_cms/src/delegate/cms_delegate.dart';
import 'package:utopia_cms/src/delegate/cms_to_many_delegate.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/ui/item_management/view/cms_management_view.dart' show CmsManagementView;
import 'package:utopia_cms/src/ui/widget/dropdown/to_many/cms_to_many_dropdown_field.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms/src/util/json_map.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

/// Default pin gate for to-many columns: never shown as a table column.
bool _neverPinned(CmsPageType pageType) => false;

/// [CmsEntry] for handling toMany relationships
class CmsToManyDropdownEntry extends CmsEntry<Object> {
  /// server-layer for handling relationships operations
  final CmsToManyDelegate delegate;

  /// Builder for display of loaded values in the [buildPreview] / [CmsTable]
  ///
  /// Refers to generic values loaded by [CmsDelegate]
  final String Function(JsonMap)? previewDisplayBuilder;

  /// Builder for display of values in the [buildEditField] / [CmsManagementView]
  ///
  /// Refers to values loaded by [CmsToManyDelegate]
  final String Function(JsonMap) fieldDisplayBuilder;

  final List<String> filterFields;

  CmsToManyDropdownEntry({
    required this.delegate,
    required this.filterFields,
    required this.fieldDisplayBuilder,
    this.previewDisplayBuilder,
    required this.label,
    this.modifier = const CmsEntryModifier(pinned: _neverPinned),
    this.flex = 4,
    this.width,
  });

  @override
  final int? flex;

  @override
  final double? width;

  // Used to get originId from the containing CmsTable.
  @override
  String get key => delegate.originIdKey;

  @override
  final String label;

  @override
  final CmsEntryModifier modifier;

  @override
  Widget buildPreview(BuildContext context, Object value) {
    return HookBuilder(
      builder: (context) {
        final values = useMemoizedFuture(() async => delegate.get(originId: value));
        if (!values.hasData) return const CmsMockLoadingBox(width: 72, height: 22);
        final labels = values.data!.map(previewDisplayBuilder ?? fieldDisplayBuilder).toIList();
        return CmsChipList(labels: labels, maxLength: 6);
      },
    );
  }

  @override
  Widget buildEditField({
    required BuildContext context,
    required Object? value,
    required void Function(JsonMap value) onChanged,
  }) {
    return CmsToManyDropdownField(
      label: fixedLabelRequired,
      valueLabelBuilder: fieldDisplayBuilder,
      delegate: delegate,
      filterFields: filterFields,
      originId: value,
    );
  }
}
