/// Internal foundation barrel for utopia_cms.
///
/// Re-exports the web-safe pieces utopia_cms actually uses (hooks, widgets,
/// collections). Replaces the former `package:utopia_arch/utopia_arch.dart`
/// dependency, which transitively pulled `logger` (and its `dart:io` file
/// output), breaking web platform support on pub.dev.
library;

export 'package:fast_immutable_collections/fast_immutable_collections.dart';
export 'package:utopia_collections/utopia_collections.dart';
export 'package:utopia_hooks/utopia_hooks.dart';
export 'package:utopia_widgets/utopia_widgets.dart';
