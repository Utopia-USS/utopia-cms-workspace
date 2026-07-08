import 'package:flutter/widgets.dart';
import 'package:utopia_cms_ui/src/theme/cms_theme.dart';
import 'package:utopia_cms_ui/src/theme/cms_theme_colors.dart';
import 'package:utopia_cms_ui/src/theme/cms_theme_data.dart';
import 'package:utopia_cms_ui/src/theme/cms_theme_text_styles.dart';

/// Shorthand theme lookups: `context.theme`, `context.colors`,
/// `context.textStyles`, `context.fieldDecoration`.
///
/// Backed by [CmsTheme.of], so they fall back to
/// [CmsThemeData.defaultTheme] when no [CmsTheme] ancestor exists.
extension CmsThemeContextExtensions on BuildContext {
  /// The ambient `CmsThemeData`, resolved via [CmsTheme.of].
  CmsThemeData get theme => CmsTheme.of(this);

  /// Shorthand for `theme.colors`.
  CmsThemeColors get colors => theme.colors;

  /// Shorthand for `theme.textStyles`.
  CmsThemeTextStyles get textStyles => theme.textStyles;

  /// Shorthand for `theme.fieldDecoration`.
  BoxDecoration get fieldDecoration => theme.fieldDecoration;
}
