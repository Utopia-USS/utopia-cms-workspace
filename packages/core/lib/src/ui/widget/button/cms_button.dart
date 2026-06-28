import 'package:flutter/material.dart';
import 'package:utopia_cms/src/ui/widget/layout/cms_gradient_background.dart';
import 'package:utopia_cms/src/ui/widget/loading/cms_three_bounce.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

class CmsButton extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final bool isEnabled;
  final bool loading;
  final bool dense;
  final double maxWidth;
  final List<Color>? colors;

  /// Overrides the fixed square extent (min/max height and min width). Defaults
  /// to 44 when [dense], 60 otherwise. Pair with [maxWidth] == [height] for a
  /// square icon button.
  final double? height;

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
        constraints: BoxConstraints(
          minHeight: extent,
          maxHeight: extent,
          minWidth: extent,
          maxWidth: maxWidth,
        ),
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
