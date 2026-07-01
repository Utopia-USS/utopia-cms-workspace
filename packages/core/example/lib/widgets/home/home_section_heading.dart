import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

import 'home_hud.dart';

/// Landing-section heading. Thin wrapper over [HudHeading] so the sections keep
/// a stable API while rendering the HUD-style label (mono kicker +
/// trailing rule + muted one-line description). No big title - the kicker is
/// the section name.
class HomeSectionHeading extends StatelessWidget {
  final CmsThemeData theme;
  final String eyebrow;
  final String subtitle;

  const HomeSectionHeading({super.key, required this.theme, required this.eyebrow, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return HudHeading(theme: theme, label: eyebrow, subtitle: subtitle);
  }
}
