import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

import 'home_hud.dart';
import 'home_section_heading.dart';
import 'home_showcase_data.dart';

/// The "Core types" landing section, above the entries grid: the base
/// abstractions a CMS is built from, each a chamfered panel that opens its
/// source file on GitHub. Everything else in the API extends one of these.
class HomeAbstractionsSection extends StatelessWidget {
  final CmsThemeData theme;
  final void Function(String url) onOpen;

  const HomeAbstractionsSection({super.key, required this.theme, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeading(
          theme: theme,
          eyebrow: 'Core types',
          subtitle: 'The handful of base classes you compose - subclass a delegate, list entries, add filters and '
              'actions. Each tile opens its source on GitHub.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final perRow = (constraints.maxWidth / 300).floor().clamp(1, 3);
            const gap = 16.0;
            final cardWidth = (constraints.maxWidth - gap * (perRow - 1)) / perRow - 0.5;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final type in kHomeAbstractions) SizedBox(width: cardWidth, child: _buildCard(type)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCard(HomeAbstractionInfo type) {
    return HudPanel(
      theme: theme,
      cut: 14,
      onTap: () => onOpen(type.url),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(type.icon, size: 18, color: theme.colors.primary),
              const Spacer(),
              Icon(Icons.open_in_new, size: 15, color: theme.colors.text.withValues(alpha: 0.45)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            type.name,
            style: TextStyle(fontFamily: kHudMono, color: theme.colors.text, fontWeight: FontWeight.w700, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            type.blurb,
            style: theme.textStyles.text.copyWith(color: theme.colors.text.withValues(alpha: 0.6), fontSize: 13),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
