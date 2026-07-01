import 'package:flutter/material.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

class CmsSwitch extends StatelessWidget {
  final bool value;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;
  final bool readOnly;

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
