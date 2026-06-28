import 'package:flutter/material.dart';
import 'package:utopia_cms/src/ui/widget/wrapper/cms_field_wrapper.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

/// A read-only field that shares `CmsTextField`'s chrome - the same borderless
/// [CmsFieldWrapper], floating label and height - but displays a picked value
/// instead of an editable input.
///
/// This is the common base for fields whose value is chosen rather than typed
/// (the dropdowns). Unlike a read-only `CmsTextField` it holds no
/// `useFieldState`, so the displayed [value] always reflects the latest prop -
/// picking a new option updates the trigger immediately.
class CmsLabeledField extends StatelessWidget {
  /// The floating label, styled exactly like a `CmsTextField` label.
  final String label;

  /// The current value text. Empty/null keeps the label in its resting position
  /// (matching an empty `CmsTextField`); a non-empty value floats it.
  final String? value;

  /// Trailing affordance (e.g. a dropdown chevron), laid out like a
  /// `CmsTextField` suffix.
  final Widget? suffix;

  const CmsLabeledField({super.key, required this.label, required this.value, this.suffix});

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    final value = this.value ?? '';

    return CmsFieldWrapper(
      includePadding: false,
      child: Row(
        children: [
          Expanded(
            child: InputDecorator(
              isEmpty: value.isEmpty,
              baseStyle: textStyles.text,
              decoration: cmsFieldDecoration(context, label: Text(label)),
              child: Text(value, style: textStyles.text, overflow: TextOverflow.ellipsis),
            ),
          ),
          ?suffix,
        ],
      ),
    );
  }
}
