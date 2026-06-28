import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:utopia_cms/utopia_cms.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../state/theme_mode_state.dart';
import '../theme.dart';

/// A custom menu item for the CMS left rail that replaces the stock "About"
/// entry with a live theme-mode picker.
///
/// Tapping the tile opens a small popup listing the [ExampleThemeMode]s,
/// each with a colour-swatch preview, and selecting one re-themes the whole
/// shell at runtime. The popup is rendered FROM A PORTAL (the "jolly pen-tool"
/// pattern, via `flutter_portal`) rather than as a Flutter route or an
/// [OverlayEntry]: the tile is wrapped in nested [PortalTarget]s so the popup
/// floats above sibling widgets - escaping the rail's clip and scroll - while a
/// full-screen transparent follower underneath captures taps outside to dismiss
/// it. The nearest enclosing [Portal] (added by the app shell) hosts both
/// followers.
///
/// This is a widget-level hook component (utopia_hooks composable-hooks
/// pattern): it holds purely-local popup visibility in a [useState] and reads
/// the app-wide selection through `useProvided<ThemeModeState>()`, writing the
/// picked mode straight back onto that state's [MutableValue].
///
/// The active [theme] is passed in rather than read from a context extension:
/// the shell already resolves the current [CmsThemeData] from the selected mode,
/// and the picker reuses it for ALL styling so the tile and popup always match
/// whichever theme is live (the internal `context.theme` / `context.colors`
/// extensions are private to utopia_cms and not exported).
class ThemePickerMenuItem extends HookWidget {
  /// The active CMS theme, resolved by the shell from the current mode. Used to
  /// style the tile and popup so the picker matches whichever theme is active.
  final CmsThemeData theme;

  const ThemePickerMenuItem({super.key, required this.theme});

  /// Fixed height of the trigger tile. It mirrors a native `CmsMenuTile` (outer 3
  /// + inner 12 vertical padding + a 22px icon, top and bottom = 52) so the picker
  /// lines up with the page items above it, and it is PINNED for a specific
  /// reason: the tile uses a [LayoutBuilder] to switch expanded / collapsed by
  /// rail width, and a LayoutBuilder cannot answer intrinsic-height queries. The
  /// CMS rail measures every menu item's intrinsic height (its body is an
  /// [IntrinsicHeight] inside a fill-viewport scroll view), so an unbounded tile
  /// would throw there. A tight-height [SizedBox] short-circuits that query
  /// without ever descending into the LayoutBuilder.
  static const double _tileHeight = 52;

  @override
  Widget build(BuildContext context) {
    final state = useProvided<ThemeModeState>();
    final isOpen = useState(false);

    return PortalTarget(
      visible: isOpen.value,
      // Full-screen barrier under the popup: any tap outside dismisses it.
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => isOpen.value = false,
        child: const ColoredBox(color: Colors.transparent),
      ),
      child: PortalTarget(
        visible: isOpen.value,
        // The tile sits at the bottom of the left rail, so the popup flies out
        // to the RIGHT with bottoms aligned, nudged off the rail by a small gap
        // and shifted back on-screen if it would overflow either axis.
        anchor: const Aligned(
          follower: Alignment.bottomLeft,
          target: Alignment.bottomRight,
          shiftToWithinBound: AxisFlag(x: true, y: true),
          offset: Offset(8, 0),
        ),
        portalFollower: isOpen.value ? _buildPopup(state, isOpen) : null,
        child: _buildTile(isOpen),
      ),
    );
  }

  /// The trigger tile. Mirrors `CmsMenuTile`'s metrics (outer 12/3 padding,
  /// themed border radius, inner 14/12 padding, hover colour) so it reads as a
  /// native menu item, and collapses to a bare icon when the rail is narrow.
  Widget _buildTile(MutableValue<bool> isOpen) {
    return SizedBox(
      height: _tileHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: Material(
          color: Colors.transparent,
          borderRadius: theme.borderRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => isOpen.value = !isOpen.value,
            hoverColor: theme.colors.hover,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Rail is 76px collapsed / 300px expanded; 150 splits cleanly.
                  final isExpanded = constraints.maxWidth > 150;
                  return Row(
                    children: [
                      Icon(Icons.palette_outlined, size: 22, color: theme.colors.text),
                      if (isExpanded) ...[
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            'Theme',
                            style: theme.textStyles.label.copyWith(color: theme.colors.text),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The floating popup: a themed card listing every [ExampleThemeMode]. The
  /// inner [Material] lets InkWell ripples render over the portal layer.
  Widget _buildPopup(ThemeModeState state, MutableValue<bool> isOpen) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 248),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: theme.cardRadius,
          border: Border.all(color: theme.colors.border, width: theme.cardBorderWidth),
          boxShadow: theme.cardShadow,
        ),
        padding: const EdgeInsets.all(8),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                child: Text('Theme', style: theme.textStyles.label.copyWith(color: theme.colors.hint)),
              ),
              for (final mode in ExampleThemeMode.values) _buildOption(state, isOpen, mode),
            ],
          ),
        ),
      ),
    );
  }

  /// A single selectable theme row: swatches, label, and a check on the active
  /// mode. Selecting writes the mode to global state and closes the popup.
  Widget _buildOption(ThemeModeState state, MutableValue<bool> isOpen, ExampleThemeMode mode) {
    final selected = mode == state.mode.value;
    return Material(
      key: ValueKey('railThemeOption_${mode.name}'),
      color: selected ? theme.colors.chipBackground : Colors.transparent,
      borderRadius: theme.borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          state.mode.value = mode;
          isOpen.value = false;
        },
        hoverColor: theme.colors.hover,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            children: [
              _buildSwatches(mode),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  mode.label,
                  style: theme.textStyles.text.copyWith(color: selected ? theme.colors.primary : theme.colors.text),
                ),
              ),
              if (selected) Icon(Icons.check_rounded, size: 18, color: theme.colors.primary),
            ],
          ),
        ),
      ),
    );
  }

  /// The 3-colour preview for a mode. Each swatch carries a hairline border so a
  /// colour that matches the popup surface (e.g. the cyberpunk near-black
  /// surface) is still visible against the card.
  Widget _buildSwatches(ExampleThemeMode mode) {
    final swatches = mode.swatches;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < swatches.length; i++)
          Container(
            width: 16,
            height: 16,
            margin: EdgeInsets.only(right: i == swatches.length - 1 ? 0 : 3),
            decoration: BoxDecoration(
              color: swatches[i],
              shape: BoxShape.circle,
              border: Border.all(color: theme.colors.border, width: 1),
            ),
          ),
      ],
    );
  }
}
