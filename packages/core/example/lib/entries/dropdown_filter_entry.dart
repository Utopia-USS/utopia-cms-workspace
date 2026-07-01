import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

/// A reusable single-select dropdown [CmsFilterEntry].
///
/// The built-in filter catalog ships only search and date entries, so a faceted
/// "pick one value, or All" filter is a custom entry - this is the canonical
/// shape from the utopia-cms skill, made generic over the column type [T].
///
/// The stored value is nullable: `null` means "All" (no constraint). The table
/// only treats an entry as active when its stored value is non-null, so the
/// "All" option clears the filter for free; `filterFromValues` still returns
/// `CmsFilter.all()` for that case defensively. A non-null selection becomes a
/// `CmsFilter.equals` on the single `filterKey`, which the delegate evaluates
/// server-side (here: the in-memory mock delegate's filter tree).
///
/// Works for any equatable column value - a `String` enum-ish field (the
/// Packages "layer") or a `bool` rendered as a tri-state Yes / No / All (the
/// Packages "used here" flag).
class CmsDropdownFilterEntry<T> extends CmsFilterEntry<T?> {
  CmsDropdownFilterEntry({
    required String filterKey,
    required this.entryKey,
    required this.values,
    required this.valueLabelBuilder,
    this.label,
    this.allLabel = 'All',
    this.flex = 2,
  }) : filterKeys = [filterKey];

  /// The selectable values (without the synthetic "All" entry).
  final List<T> values;

  /// Human label for a single value in the dropdown.
  final String Function(T) valueLabelBuilder;

  /// Label of the synthetic "no constraint" option.
  final String allLabel;

  @override
  final List<String> filterKeys;
  @override
  final String entryKey;
  @override
  final String? label;
  @override
  final int flex;

  @override
  Widget buildField({required BuildContext context, required T? value, required void Function(T?) onChanged}) {
    // Reuse the core portal dropdown; `null` is the synthetic "All" option.
    return CmsDropdownField<T?>(
      value: value,
      onChanged: onChanged,
      values: [null, ...values],
      label: fixedLabel,
      valueLabelBuilder: (v) => v == null ? allLabel : valueLabelBuilder(v as T),
    );
  }

  @override
  CmsFilter filterFromValues(JsonMap value) {
    final selected = value.getAtPath(entryKey) as T?;
    if (selected == null) return const CmsFilter.all();
    return CmsFilter.equals(filterKeys.first, selected);
  }
}
