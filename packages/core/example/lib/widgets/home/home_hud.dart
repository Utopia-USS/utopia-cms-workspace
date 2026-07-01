import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

/// Shared HUD primitives for the landing page: angular chamfered geometry,
/// neon glow in place of drop shadow, and data-readout typography.
///
/// Everything is theme-reactive - colours come from the active [CmsThemeData] -
/// so the page reads full-cyberpunk on the Neon theme and as a sharp technical
/// HUD on the others. Only the *geometry and type treatment* are fixed.

/// Monospace family for HUD labels / data readouts (the platform monospace).
const String kHudMono = 'monospace';

/// Signature cut-corner shape: chamfers the top-left and bottom-right
/// corners. Pass a [side] to draw an edge along the bevel.
ShapeBorder hudBevel(double cut, {BorderSide side = BorderSide.none}) {
  return BeveledRectangleBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(cut), bottomRight: Radius.circular(cut)),
    side: side,
  );
}

/// A neon glow (no offset) used instead of a soft drop shadow.
List<BoxShadow> hudGlow(Color color, {double alpha = 0.30, double blur = 26}) => [
  BoxShadow(
    color: color.withValues(alpha: alpha),
    blurRadius: blur,
  ),
];

/// A chamfered surface panel - the landing's universal card. Optional [onTap]
/// turns it into a clipped, hoverable target; [glow] adds an accent halo;
/// [edge] overrides the hairline border colour (e.g. the accent on an active
/// item).
class HudPanel extends StatelessWidget {
  final CmsThemeData theme;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? fill;
  final Gradient? gradient;
  final Color? edge;
  final double edgeWidth;
  final bool glow;
  final double cut;
  final void Function()? onTap;

  const HudPanel({
    super.key,
    required this.theme,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.fill,
    this.gradient,
    this.edge,
    this.edgeWidth = 1.5,
    this.glow = false,
    this.cut = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shape = hudBevel(
      cut,
      side: BorderSide(color: edge ?? theme.colors.border, width: edgeWidth),
    );
    // Clip the content/ink to the chamfer, but leave the glow shadow (drawn by
    // the outer DecoratedBox) un-clipped so the halo can spill past the edge.
    final clipped = ClipPath(
      clipper: ShapeBorderClipper(shape: hudBevel(cut)),
      child: onTap == null
          ? Padding(padding: padding, child: child)
          : Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                customBorder: hudBevel(cut),
                hoverColor: theme.colors.hover,
                child: Padding(padding: padding, child: child),
              ),
            ),
    );
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: gradient == null ? (fill ?? theme.colors.surface) : null,
        gradient: gradient,
        shape: shape,
        shadows: glow ? hudGlow(theme.colors.primary) : null,
      ),
      child: clipped,
    );
  }
}

/// A left-aligned HUD section header: a mono uppercase kicker with a trailing
/// hairline rule, then a muted one-line description - the "CUSTOMIZATION ___"
/// readout label. The big section title was dropped on purpose: it
/// ate vertical space for little value, so the kicker carries the section name.
class HudHeading extends StatelessWidget {
  final CmsThemeData theme;
  final String label;
  final String subtitle;

  const HudHeading({super.key, required this.theme, required this.label, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              '// ${label.toUpperCase()}',
              style: TextStyle(
                fontFamily: kHudMono,
                color: theme.colors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(child: Container(height: 1, color: theme.colors.border)),
          ],
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            subtitle,
            style: theme.textStyles.text.copyWith(
              color: theme.colors.text.withValues(alpha: 0.6),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

/// Overlays four L-shaped targeting brackets at the corners of [child] - a
/// targeting reticle. Sizes to the child.
class HudCornerFrame extends StatelessWidget {
  final Widget child;
  final Color color;
  final double length;
  final double thickness;
  final double inset;

  const HudCornerFrame({
    super.key,
    required this.child,
    required this.color,
    this.length = 18,
    this.thickness = 2,
    this.inset = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(top: inset, left: inset, child: _bracket(top: true, left: true)),
        Positioned(top: inset, right: inset, child: _bracket(top: true, right: true)),
        Positioned(bottom: inset, left: inset, child: _bracket(bottom: true, left: true)),
        Positioned(bottom: inset, right: inset, child: _bracket(bottom: true, right: true)),
      ],
    );
  }

  Widget _bracket({bool top = false, bool bottom = false, bool left = false, bool right = false}) {
    final side = BorderSide(color: color, width: thickness);
    return SizedBox(
      width: length,
      height: length,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: top ? side : BorderSide.none,
            bottom: bottom ? side : BorderSide.none,
            left: left ? side : BorderSide.none,
            right: right ? side : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
