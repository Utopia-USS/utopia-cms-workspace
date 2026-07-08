import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

import '../widgets/section.dart';

/// Tag pills, overflow collapsing and utility text.
class ChipsTextSection extends StatelessWidget {
  /// Creates the chips and text section.
  const ChipsTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SheetSection(
      title: 'Chips & text',
      subtitle: 'Tag pills, overflow collapsing and utility text.',
      child: Wrap(
        spacing: 32,
        runSpacing: 24,
        children: [
          const SpecimenTile(
            label: 'CmsChip',
            child: CmsChip(child: Text('Published')),
          ),
          const SpecimenTile(
            label: 'CmsChip - leading',
            child: CmsChip(leading: Icon(Icons.tag), child: Text('release')),
          ),
          SpecimenTile(
            label: 'CmsChip - custom colors',
            child: CmsChip(
              color: colors.primary.withValues(alpha: 0.12),
              contentColor: colors.primary,
              child: const Text('Active'),
            ),
          ),
          SpecimenTile(
            label: 'CmsChipList - maxLength: 4',
            child: CmsChipList(labels: IList(const ['Design', 'Docs', 'Beta', 'Admin', 'QA', 'Infra']), maxLength: 4),
          ),
          SpecimenTile(
            label: 'CmsChipList - empty',
            child: CmsChipList(labels: IList(const <String>[])),
          ),
          const SpecimenTile(
            label: 'CmsCopyableText',
            width: 260,
            child: CmsCopyableText('550e8400-e29b-41d4-a716-446655440000'),
          ),
          const SpecimenTile(label: 'CmsCopyableText - null', width: 200, child: CmsCopyableText(null)),
          const SpecimenTile(
            label: 'CmsTitle',
            child: CmsTitle(title: 'Section title'),
          ),
        ],
      ),
    );
  }
}
