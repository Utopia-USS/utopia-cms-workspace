import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// A themed on/off switch, styled from `CmsThemeColors` instead of the
/// ambient `MaterialApp` theme.
class CmsSwitch extends StatelessWidget {
  /// Whether the switch renders in its "on" position.
  final bool value;

  /// Called with the new value when toggled; `null` disables interaction.
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;

  /// When `true`, blocks interaction while keeping the full-color styling
  /// (instead of Flutter's faded disabled look).
  final bool readOnly;

  /// Creates a themed on/off switch.
  const CmsSwitch({super.key, required this.value, this.onChanged, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return IgnorePointer(
      ignoring: readOnly,
      child: MouseRegion(
        cursor: readOnly ? MouseCursor.defer : SystemMouseCursors.click,
        child: Switch(
          activeTrackColor: colors.primary,
          inactiveTrackColor: colors.disabled,
          inactiveThumbColor: Colors.white,
          activeThumbColor: Colors.white,
          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
          trackOutlineWidth: const WidgetStatePropertyAll(0),
          value: value,
          // When read-only we still want the full-colour look (not Flutter's
          // faded disabled styling), so pass a no-op handler and let the
          // surrounding IgnorePointer block interaction.
          onChanged: onChanged ?? (readOnly ? (_) {} : null),
        ),
      ),
    );
  }
}
