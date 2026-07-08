import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// A hairline divider drawn in the theme's border colour.
///
/// Separates the header from the rows and the rows from each other in a
/// `CmsTable`. Thickness comes from `CmsThemeData.dividerThickness`.
class CmsDivider extends StatelessWidget {
  /// Creates a hairline divider.
  const CmsDivider({super.key});

  @override
  Widget build(BuildContext context) => Container(height: context.theme.dividerThickness, color: context.colors.border);
}
