import 'package:flutter/material.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';
import 'package:utopia_cms/src/util/foundation.dart';

class CmsFieldWrapper extends HookWidget {
  final Widget child;
  final bool includePadding;

  const CmsFieldWrapper({super.key, required this.child, this.includePadding = true});

  @override
  Widget build(BuildContext context) {
    final fieldTheme = context.fieldDecoration;
    final themeValues = context.theme;

    return Container(
      decoration: fieldTheme,
      padding: includePadding ? const EdgeInsets.symmetric(vertical: 4.0) : EdgeInsets.zero,
      child: Padding(padding: themeValues.fieldContentPadding, child: child),
    );
  }
}

/// The shared [InputDecoration] for every CMS field - the single source of the
/// borderless chrome and the floating-label styling.
///
/// Used by `CmsTextField` (and, through it, every text-backed field: text, num,
/// date, country) and by the read-only `CmsLabeledField` that backs the
/// dropdowns - so a label looks and floats the same everywhere.
InputDecoration cmsFieldDecoration(BuildContext context, {Widget? label, FloatingLabelBehavior? floatingLabelBehavior}) {
  final textStyles = context.textStyles;
  return InputDecoration(
    // Dense + zero content padding: the surrounding CmsFieldWrapper already
    // supplies the field padding, so the decorator only needs room for the
    // (floating) label and value - this keeps fields compact and a uniform
    // height alongside the search field and buttons in a toolbar row.
    isDense: true,
    contentPadding: EdgeInsets.zero,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    label: label,
    floatingLabelBehavior: floatingLabelBehavior,
    floatingLabelStyle: textStyles.label.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
    labelStyle: textStyles.label,
  );
}
