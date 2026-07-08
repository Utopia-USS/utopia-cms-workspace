/// Internal foundation barrel for utopia_cms_ui.
///
/// Re-exports the web-safe pieces this package actually uses (hooks, widgets,
/// collections). Deliberately excludes `package:utopia_arch/utopia_arch.dart`,
/// which transitively pulls `logger` (and its `dart:io` file output), breaking
/// web platform support - see the charter's dependency policy.
library;

export 'package:fast_immutable_collections/fast_immutable_collections.dart';
export 'package:utopia_collections/utopia_collections.dart';
export 'package:utopia_hooks/utopia_hooks.dart';
export 'package:utopia_widgets/utopia_widgets.dart';
