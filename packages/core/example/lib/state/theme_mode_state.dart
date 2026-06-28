import 'package:utopia_hooks/utopia_hooks.dart';

import '../theme.dart';

/// App-wide selected theme mode. A UI-only selection, so the value is exposed as
/// a [MutableValue] the picker writes directly (see the utopia_hooks global-state
/// MutableValue idiom); the shell reads `.value` and re-themes [CmsWidget].
class ThemeModeState {
  final MutableValue<ExampleThemeMode> mode;

  const ThemeModeState({required this.mode});
}

/// Global state hook. Registered in main.dart's `_providers` under
/// [ThemeModeState]; consumed anywhere with `useProvided<ThemeModeState>()`.
ThemeModeState useThemeModeState() {
  final mode = useState(ExampleThemeMode.light);
  return ThemeModeState(mode: mode);
}
