import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// A page/section heading, styled with `CmsThemeTextStyles.title`.
class CmsTitle extends StatelessWidget {
  /// The heading text.
  final String title;

  /// Creates a page/section heading.
  const CmsTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: context.textStyles.title);
  }
}
