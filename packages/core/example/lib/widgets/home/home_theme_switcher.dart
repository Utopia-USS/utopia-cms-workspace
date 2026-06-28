import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../../state/theme_mode_state.dart';
import '../../theme.dart';
import 'home_hud.dart';

/// The "Theme" landing section: the four [ExampleThemeMode]s as selectable
/// swatch pills. Tapping one re-themes the entire shell live - the marketing
/// money-shot - by writing straight to the app-wide [ThemeModeState], the same
/// global the menu's theme picker drives.
///
/// A widget-level hook component (utopia_hooks composable-hooks pattern), like
/// `ThemePickerMenuItem`: it reads the shared selection via
/// `useProvided<ThemeModeState>()` and takes the active [theme] in for styling,
/// so the pills always match whichever theme is live.
class HomeThemeSwitcher extends HookWidget {
  final CmsThemeData theme;

  const HomeThemeSwitcher({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final state = useProvided<ThemeModeState>();
    final selected = state.mode.value;
    // Text stripped on request - just the pills. They self-label (swatch + name),
    // and sit directly under the hero as the live theme control strip.
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [for (final mode in ExampleThemeMode.values) _buildOption(state, mode, isActive: mode == selected)],
    );
  }

  Widget _buildOption(ThemeModeState state, ExampleThemeMode mode, {required bool isActive}) {
    const cut = 12.0;
    final shape = hudBevel(
      cut,
      side: BorderSide(color: isActive ? theme.colors.primary : theme.colors.border, width: isActive ? 2 : 1.5),
    );
    return DecoratedBox(
      key: ValueKey('homeThemeOption_${mode.name}'),
      decoration: ShapeDecoration(
        color: isActive ? theme.colors.chipBackground : theme.colors.surface,
        shape: shape,
        shadows: isActive ? hudGlow(theme.colors.primary, alpha: 0.35, blur: 22) : null,
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: hudBevel(cut)),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => state.mode.value = mode,
            customBorder: hudBevel(cut),
            hoverColor: theme.colors.hover,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSwatches(mode),
                  const SizedBox(width: 12),
                  Text(
                    mode.label.toUpperCase(),
                    style: TextStyle(
                      fontFamily: kHudMono,
                      color: isActive ? theme.colors.primary : theme.colors.text,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(width: 10),
                    Icon(
                      key: ValueKey('homeThemeActive_${mode.name}'),
                      Icons.check_rounded,
                      size: 18,
                      color: theme.colors.primary,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The mode's 3-colour preview (primary / accent / surface), each dot with a
  /// hairline border so a swatch matching the card surface stays visible.
  Widget _buildSwatches(ExampleThemeMode mode) {
    final swatches = mode.swatches;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < swatches.length; i++)
          Container(
            width: 16,
            height: 16,
            margin: EdgeInsets.only(right: i == swatches.length - 1 ? 0 : 4),
            decoration: BoxDecoration(
              color: swatches[i],
              shape: BoxShape.circle,
              border: Border.all(color: theme.colors.border),
            ),
          ),
      ],
    );
  }
}
