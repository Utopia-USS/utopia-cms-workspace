import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

import 'home_code_card.dart';
import 'home_hud.dart';
import 'home_pub_add_chip.dart';

/// The landing hero: a tall, chamfered gradient panel (Auris HUD) with a corner
/// reticle, the value proposition + CTAs on the left, and a live
/// `CmsTablePage` code card on the right.
///
/// The fill is the theme's `primary -> accent` gradient and every label uses
/// `theme.textStyles.button.color` - the one foreground each theme tunes to
/// contrast that gradient - so the hero recolours wholesale on a theme switch
/// and never breaks contrast. Below [_stackBreakpoint] the code card drops
/// below the copy.
class HomeHero extends StatelessWidget {
  final CmsThemeData theme;
  final void Function() onOpenPubDev;
  final void Function() onOpenGithub;

  const HomeHero({super.key, required this.theme, required this.onOpenPubDev, required this.onOpenGithub});

  static const double _stackBreakpoint = 820;
  static const double _cut = 28;

  @override
  Widget build(BuildContext context) {
    final onHero = theme.textStyles.button.color ?? Colors.white;
    final bevel = aurisBevel(_cut, side: BorderSide(color: onHero.withValues(alpha: 0.25), width: 1.5));
    return HudCornerFrame(
      color: onHero.withValues(alpha: 0.65),
      inset: 16,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.colors.primary, theme.colors.accent],
          ),
          shape: bevel,
          shadows: aurisGlow(theme.colors.primary, alpha: 0.45, blur: 48),
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: aurisBevel(_cut)),
          child: Stack(
            children: [
              _buildGlow(onHero),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 52),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final stacked = constraints.maxWidth < _stackBreakpoint;
                    final copy = _buildCopy(onHero, stacked);
                    if (stacked) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [copy, const SizedBox(height: 36), const HomeCodeCard()],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: copy),
                        const SizedBox(width: 48),
                        ConstrainedBox(constraints: const BoxConstraints(maxWidth: 440), child: const HomeCodeCard()),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A soft radial highlight in the top-right, drawn in the hero foreground, to
  /// give the flat gradient some depth without risking contrast.
  Widget _buildGlow(Color onHero) {
    return Positioned(
      right: -120,
      top: -120,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [onHero.withValues(alpha: 0.12), onHero.withValues(alpha: 0.0)]),
        ),
      ),
    );
  }

  Widget _buildCopy(Color onHero, bool stacked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildEyebrow(onHero),
        const SizedBox(height: 22),
        Text(
          'ADMIN PANELS, DECLARED.\nNOT HAND-ROLLED.',
          style: theme.textStyles.header.copyWith(
            color: onHero,
            fontSize: stacked ? 30 : 40,
            height: 1.1,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            'utopia_cms turns a list of fields into a full back-office: a sortable '
            'table, a create / edit / delete overlay, filters, theming and loading '
            'states - all from one CmsTablePage.',
            style: theme.textStyles.text.copyWith(color: onHero.withValues(alpha: 0.92), fontSize: 16, height: 1.5),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _HeroButton(
              theme: theme,
              label: 'VIEW ON PUB.DEV',
              icon: Icons.arrow_outward,
              filled: true,
              onHero: onHero,
              onTap: onOpenPubDev,
            ),
            _HeroButton(
              theme: theme,
              label: 'GITHUB',
              icon: Icons.code,
              filled: false,
              onHero: onHero,
              onTap: onOpenGithub,
            ),
          ],
        ),
        const SizedBox(height: 16),
        HomePubAddChip(theme: theme, onColor: onHero),
      ],
    );
  }

  /// Mono uppercase kicker on a translucent wash of the hero foreground, with a
  /// leading marker - the Auris data-label treatment.
  Widget _buildEyebrow(Color onHero) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: ShapeDecoration(color: onHero.withValues(alpha: 0.16), shape: aurisBevel(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 7, height: 7, color: onHero),
          const SizedBox(width: 10),
          Text(
            'LOW-CODE FLUTTER ADMIN',
            style: TextStyle(
              fontFamily: kHudMono,
              color: onHero,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

/// A hero CTA pill with a chamfered shape. [filled] = a solid surface chip with
/// the primary-coloured label (pops off the gradient); otherwise an outline
/// drawn in the hero foreground.
class _HeroButton extends StatelessWidget {
  final CmsThemeData theme;
  final String label;
  final IconData icon;
  final bool filled;
  final Color onHero;
  final void Function() onTap;

  const _HeroButton({
    required this.theme,
    required this.label,
    required this.icon,
    required this.filled,
    required this.onHero,
    required this.onTap,
  });

  static const double _cut = 10;

  @override
  Widget build(BuildContext context) {
    final fg = filled ? theme.colors.primary : onHero;
    final shape = aurisBevel(
      _cut,
      side: filled ? BorderSide.none : BorderSide(color: onHero.withValues(alpha: 0.55), width: 1.5),
    );
    return Material(
      color: filled ? theme.colors.surface : Colors.transparent,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        hoverColor: onHero.withValues(alpha: 0.12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: theme.textStyles.button.copyWith(
                  color: fg,
                  fontFamily: kHudMono,
                  letterSpacing: 1.2,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 16, color: fg),
            ],
          ),
        ),
      ),
    );
  }
}
