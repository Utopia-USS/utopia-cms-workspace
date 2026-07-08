import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// A small rounded pill used to display a categorical / tag-like value in a
/// `CmsTable` cell (e.g. a dropdown value or one element of a to-many relation).
///
/// Colours and corner radius come from `CmsThemeData` / `CmsThemeColors` so the
/// whole admin app stays themable from one place.
class CmsChip extends StatelessWidget {
  /// The chip label.
  final Widget child;

  /// Optional leading widget (icon, dot, …) shown before [child].
  final Widget? leading;

  /// Overrides `CmsThemeColors.chipBackground`.
  final Color? color;

  /// Overrides `CmsThemeColors.chipForeground`.
  final Color? contentColor;

  /// Creates a chip pill.
  const CmsChip({super.key, required this.child, this.leading, this.color, this.contentColor});

  @override
  Widget build(BuildContext context) {
    final contentColor = this.contentColor ?? context.colors.chipForeground;
    return Container(
      decoration: BoxDecoration(
        color: color ?? context.colors.chipBackground,
        borderRadius: BorderRadius.circular(context.theme.chipRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: DefaultTextStyle.merge(
        style: context.textStyles.caption.copyWith(color: contentColor),
        child: IconTheme.merge(
          data: IconThemeData(color: contentColor, size: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 6)],
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
