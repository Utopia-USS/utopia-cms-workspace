/// The bundled image assets, centralised so the menu header and the precache
/// state reference the same paths. Each logo ships as a theme-aware pair - a
/// black-ink `*_light.png` for the light themes and a white-ink `*_dark.png`
/// for the dark ones.
class AppImages {
  const AppImages._();

  /// Full utopia_cms lockup (mark + wordmark), pinned to the expanded menu.
  static const cmsCoreLight = 'assets/cms_core_light.png';
  static const cmsCoreDark = 'assets/cms_core_dark.png';

  /// Bare Utopia mark, shown when the menu rail is collapsed.
  static const utopiaMarkLight = 'assets/utopia_mark_light.png';
  static const utopiaMarkDark = 'assets/utopia_mark_dark.png';

  /// Decoded up-front by `useImagePrecacheState` so the sidebar logo is already
  /// warm when the shell first paints and doesn't pop in on load. Both theme
  /// variants are precached because the theme picker can flip the menu either way.
  static const precached = <String>[cmsCoreLight, cmsCoreDark, utopiaMarkLight, utopiaMarkDark];
}
