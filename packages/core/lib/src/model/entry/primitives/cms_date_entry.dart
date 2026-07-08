import 'package:flutter/material.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

/// [CmsEntry] for handling basic dates
class CmsDateEntry extends CmsEntry<DateTime?> {
  CmsDateEntry({required this.key, this.label, this.modifier = const CmsEntryModifier(), this.flex = 2, this.width});

  @override
  final String key;

  @override
  final int? flex;

  @override
  final double? width;

  @override
  final String? label;

  @override
  final CmsEntryModifier modifier;

  @override
  Widget buildPreview(BuildContext context, DateTime? value) {
    return CmsCopyableText(value?.toDisplayStringWithoutHours());
  }

  @override
  Widget buildEditField({
    required BuildContext context,
    required DateTime? value,
    required void Function(DateTime? value) onChanged,
  }) {
    return CmsDatePicker(date: value, label: fixedLabelRequired, onDateChanged: onChanged);
  }

  @override
  String? toJson(DateTime? value) => value?.toString();

  @override
  DateTime? fromJson(Object? json) => json?.let((it) => DateTime.parse(it as String));
}
