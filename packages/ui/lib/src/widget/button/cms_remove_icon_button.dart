import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// A small "x" icon button used to remove/clear a value (e.g. a chip or a
/// filled field), styled with `CmsThemeColors.text`.
class CmsRemoveIconButton extends StatelessWidget {
  /// Called when the icon is tapped.
  final void Function() onPressed;

  /// Creates the remove/clear icon button.
  const CmsRemoveIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(Icons.clear, color: colors.text, size: 18),
      ),
    );
  }
}
