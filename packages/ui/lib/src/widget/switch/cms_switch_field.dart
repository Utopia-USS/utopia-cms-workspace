import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';
import 'package:utopia_cms_ui/src/widget/switch/cms_switch.dart';
import 'package:utopia_cms_ui/src/widget/wrapper/cms_field_wrapper.dart';

/// A titled row pairing a label with a [CmsSwitch], wrapped in the shared
/// [CmsFieldWrapper] chrome so it lines up with the other CMS fields.
class CmsSwitchField extends StatelessWidget {
  /// Whether the switch renders in its "on" position.
  final bool value;

  /// The label shown beside the switch.
  final String title;

  /// Called with the new value when toggled; `null` disables interaction.
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;

  /// When `true`, blocks interaction while keeping the full-color styling.
  final bool readOnly;

  /// Creates a titled switch row.
  const CmsSwitchField({super.key, required this.value, required this.title, this.onChanged, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return CmsFieldWrapper(
      child: Row(
        children: [
          Expanded(child: Text(title, style: context.textStyles.text)),
          CmsSwitch(value: value, onChanged: onChanged, readOnly: readOnly),
        ],
      ),
    );
  }
}
