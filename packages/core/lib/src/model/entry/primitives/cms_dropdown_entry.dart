import 'package:flutter/material.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

/// [CmsEntry] for handling offline items picker
class CmsDropdownEntry<T> extends CmsEntry<T> {
  final List<T> values;
  final T? defaultValue;
  final String Function(T? value) valueLabelBuilder;

  CmsDropdownEntry({
    required this.key,
    required this.values,
    required this.valueLabelBuilder,
    this.defaultValue,
    this.label,
    this.modifier = const CmsEntryModifier(),
    this.flex = 2,
    this.width,
  });

  CmsDropdownEntry.simple({
    required this.key,
    required this.values,
    required this.valueLabelBuilder,
    this.label,
    this.defaultValue,
    this.modifier = const CmsEntryModifier(),
    this.flex = 1,
    this.width,
  });

  @override
  final int? flex;

  @override
  final double? width;

  @override
  final String key;

  @override
  final String? label;

  @override
  final CmsEntryModifier modifier;

  @override
  Widget buildPreview(BuildContext context, T? value) {
    final label = valueLabelBuilder(value);
    if (label.isEmpty) {
      return Text('-', style: context.textStyles.text.copyWith(color: context.colors.hint));
    }
    return CmsChip(child: Text(label, overflow: TextOverflow.ellipsis));
  }

  @override
  Widget buildEditField({required BuildContext context, required T? value, required void Function(T value) onChanged}) {
    return IgnorePointer(
      ignoring: !modifier.editable,
      child: CmsDropdownField<T>(
        value: value ?? defaultValue,
        onChanged: onChanged,
        values: values,
        label: fixedLabelRequired,
        valueLabelBuilder: valueLabelBuilder,
      ),
    );
  }
}
