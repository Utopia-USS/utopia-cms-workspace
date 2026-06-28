import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

import 'home_hud.dart';
import 'home_section_heading.dart';
import 'home_showcase_data.dart';

/// The "Entry types" landing section: a centred heading over a responsive grid
/// of every exported `CmsEntry`. Adding a column to a real table is picking one
/// of these, so the catalog doubles as the feature list.
class HomeEntriesSection extends StatelessWidget {
  final CmsThemeData theme;

  const HomeEntriesSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeSectionHeading(
          theme: theme,
          eyebrow: 'Entries',
          subtitle: 'Ten field types, each rendering its own cell, edit field and filter. Drop them into any table.',
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 900
                ? 3
                : constraints.maxWidth >= 560
                ? 2
                : 1;
            const gap = 16.0;
            // Fixed tile width + a centred Wrap so the last (partial) row sits
            // centred rather than orphaning a lone tile to the left. The 0.5
            // shave keeps float rounding from bumping a full row's last tile.
            final tileWidth = (constraints.maxWidth - gap * (columns - 1)) / columns - 0.5;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: [for (final entry in kHomeEntries) SizedBox(width: tileWidth, child: _buildTile(entry))],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTile(HomeEntryInfo entry) {
    return HudPanel(
      theme: theme,
      cut: 12,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: ShapeDecoration(color: theme.colors.chipBackground, shape: aurisBevel(8)),
            child: Icon(entry.icon, size: 22, color: theme.colors.chipForeground),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    fontFamily: kHudMono,
                    color: theme.colors.text,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  entry.blurb,
                  style: theme.textStyles.text.copyWith(color: theme.colors.text.withValues(alpha: 0.6), fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
