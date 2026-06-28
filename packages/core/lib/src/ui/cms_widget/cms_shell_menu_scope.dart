import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Shell-level menu state published by `CmsWidget` down the content subtree.
///
/// The page chrome (e.g. `CmsHeader`) reads this to decide whether to surface a
/// drawer-open ("burger") affordance: in `drawer` presentation the sidebar is
/// hidden behind `Scaffold.drawer` and the only way in is the burger next to the
/// page title. Resolved via `package:provider` because the page lives in its own
/// inner `Scaffold`, so `Scaffold.of` cannot reach the shell's drawer.
class CmsShellMenuScope {
  /// Whether the sidebar is currently presented as a drawer (small screens).
  final bool isDrawer;

  /// Opens the shell drawer. No-op when the shell has no drawer.
  final VoidCallback openDrawer;

  const CmsShellMenuScope({required this.isDrawer, required this.openDrawer});

  static CmsShellMenuScope? maybeOf(BuildContext context) =>
      Provider.of<CmsShellMenuScope?>(context, listen: false);
}
