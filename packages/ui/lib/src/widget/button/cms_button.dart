import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';
import 'package:utopia_cms_ui/src/widget/layout/cms_gradient_background.dart';
import 'package:utopia_cms_ui/src/widget/loading/cms_three_bounce.dart';

/// The primary call-to-action button: a gradient-filled, rounded surface with
/// an inline loading state.
class CmsButton extends StatelessWidget {
  /// The button's content, styled with `CmsThemeTextStyles.button`.
  final Widget child;

  /// Called on tap, while [isEnabled] is `true`.
  final void Function() onTap;

  /// Whether the button responds to taps; visually dims via [CmsGradientBackground] when `false`.
  final bool isEnabled;

  /// Replaces [child] with a [CmsThreeBounce] indicator while `true`.
  final bool loading;

  /// Uses a shorter fixed extent (44 instead of 60) when [height] is not set.
  final bool dense;

  /// Upper bound on the button's width.
  final double maxWidth;

  /// Overrides the default primary/accent gradient.
  final List<Color>? colors;

  /// Overrides the fixed square extent (min/max height and min width). Defaults
  /// to 44 when [dense], 60 otherwise. Pair with [maxWidth] == [height] for a
  /// square icon button.
  final double? height;

  /// Creates the primary call-to-action button.
  const CmsButton({
    super.key,
    required this.child,
    required this.onTap,
    this.isEnabled = true,
    this.loading = false,
    this.dense = false,
    this.maxWidth = 300,
    this.colors,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final extent = height ?? (dense ? 44 : 60);
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: extent, maxHeight: extent, minWidth: extent, maxWidth: maxWidth),
        child: CmsGradientBackground(
          colors: colors,
          clipBehavior: Clip.antiAlias,
          borderRadius: context.theme.borderRadius,
          isEnabled: isEnabled,
          child: Center(heightFactor: 1, child: _buildTitle(context)),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final style = context.textStyles.button;
    if (loading) {
      return CmsThreeBounce(color: style.color);
    } else {
      return IconTheme.merge(
        data: IconThemeData(color: style.color),
        child: DefaultTextStyle(style: style, child: child),
      );
    }
  }
}
