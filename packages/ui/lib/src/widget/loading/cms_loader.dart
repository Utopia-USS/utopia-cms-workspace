import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// A small circular progress indicator, sized and coloured to fit inline in
/// text-scale contexts (e.g. a loading row or a compact overlay).
class CmsLoader extends StatelessWidget {
  /// Overrides `CmsThemeTextStyles.label`'s color.
  final Color? color;

  /// The square dimension of the indicator.
  final double size;

  /// Creates a small inline loading indicator.
  const CmsLoader({super.key, this.color, this.size = 12});

  @override
  Widget build(BuildContext context) {
    final style = context.textStyles.label;
    return Center(
      child: SizedBox.square(
        dimension: size,
        child: Center(
          child: CircularProgressIndicator(color: color ?? style.color, strokeWidth: size / 6),
        ),
      ),
    );
  }
}
