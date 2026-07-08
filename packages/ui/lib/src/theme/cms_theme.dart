import 'package:flutter/widgets.dart';
import 'package:utopia_cms_ui/src/theme/cms_theme_data.dart';

/// Applies a [CmsThemeData] to its subtree.
///
/// Descendants read the ambient theme with [CmsTheme.of] (or the
/// `context.theme` extension), which falls back to [CmsThemeData.defaultTheme]
/// when no [CmsTheme] is found - components work zero-config, with or without
/// an ancestor [CmsTheme].
class CmsTheme extends InheritedWidget {
  /// The theme data made available to descendants.
  final CmsThemeData data;

  const CmsTheme({super.key, required this.data, required super.child});

  /// The [CmsThemeData] from the closest [CmsTheme] ancestor, or
  /// [CmsThemeData.defaultTheme] if there is none.
  static CmsThemeData of(BuildContext context) => maybeOf(context) ?? CmsThemeData.defaultTheme;

  /// The [CmsThemeData] from the closest [CmsTheme] ancestor, or `null` if
  /// there is none.
  static CmsThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CmsTheme>()?.data;

  /// Like [of], but WITHOUT registering a rebuild dependency - for one-shot
  /// reads outside `build` (event handlers, route builders), where
  /// subscribing the calling element to theme changes would cause needless
  /// rebuilds.
  static CmsThemeData read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<CmsTheme>()?.data ?? CmsThemeData.defaultTheme;

  /// Re-attaches the ambient theme across a route boundary: captures the
  /// theme resolved at [from] and wraps [child] in a [CmsTheme] carrying it.
  ///
  /// Routes (`showDialog`, `Navigator.push`) root at the app `Navigator`,
  /// outside any subtree-scoped [CmsTheme] - wrap the route's child in this
  /// so the pushed screen keeps the caller's theme instead of falling back
  /// to [CmsThemeData.defaultTheme].
  static Widget captured(BuildContext from, {required Widget child}) => CmsTheme(data: read(from), child: child);

  @override
  bool updateShouldNotify(CmsTheme oldWidget) => data != oldWidget.data;
}
