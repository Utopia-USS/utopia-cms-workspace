import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

import 'home_hud.dart';
import 'home_section_heading.dart';
import 'home_showcase_data.dart';

/// The "Backends" landing section: a heading over a wrap of chamfered package
/// panels, one per delegate, each opening its pub.dev page. The abstraction is
/// a single `CmsDelegate`, so a trailing "roll your own" card closes the set.
class HomeBackendsSection extends StatelessWidget {
  final CmsThemeData theme;
  final void Function(String url) onOpen;

  const HomeBackendsSection({super.key, required this.theme, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeading(
          theme: theme,
          eyebrow: 'Backends',
          subtitle: 'Firebase, Supabase, Hasura and GraphQL ship as prebuilt delegates. Anything else is ~30 lines.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            // Aim for ~230px cards; clamp 1..3 per row so they never get tiny.
            final perRow = (constraints.maxWidth / 230).floor().clamp(1, 3);
            const gap = 16.0;
            final cardWidth = (constraints.maxWidth - gap * (perRow - 1)) / perRow - 0.5;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final pkg in kHomeBackends) SizedBox(width: cardWidth, child: _buildCard(pkg)),
                SizedBox(width: cardWidth, child: _buildCustomCard()),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCard(HomePackageInfo pkg) {
    return HudPanel(
      theme: theme,
      cut: 14,
      onTap: () => onOpen(pkg.url),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.dns_outlined, size: 18, color: theme.colors.primary),
              const Spacer(),
              Icon(Icons.arrow_outward, size: 16, color: theme.colors.primary.withValues(alpha: 0.6)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            pkg.name,
            style: TextStyle(
              fontFamily: kHudMono,
              color: theme.colors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            pkg.blurb,
            style: theme.textStyles.text.copyWith(color: theme.colors.text.withValues(alpha: 0.6), fontSize: 13),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCard() {
    return HudPanel(
      theme: theme,
      cut: 14,
      fill: theme.colors.field,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_outlined, size: 18, color: theme.colors.text.withValues(alpha: 0.5)),
          const SizedBox(height: 14),
          Text(
            'your_backend',
            style: TextStyle(fontFamily: kHudMono, color: theme.colors.text, fontWeight: FontWeight.w700, fontSize: 14),
            maxLines: 1,
          ),
          const SizedBox(height: 5),
          Text(
            'Implement CmsDelegate - four methods, ~30 lines.',
            style: theme.textStyles.text.copyWith(color: theme.colors.text.withValues(alpha: 0.6), fontSize: 13),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
