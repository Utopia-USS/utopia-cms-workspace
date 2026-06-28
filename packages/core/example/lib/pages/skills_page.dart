import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

import '../entries/svg_media_entry.dart';
import '../mock/marks.dart';
import '../mock/seed_data.dart';

/// "AI Skills" - the Claude Code skill catalog.
///
/// Entries: a spirit-animal avatar (the same gallery the Packages page uses), a
/// clickable [CmsLinkEntry] name, a description and a sortable reference count.
///
/// Filter: a free-text search across name + description, resolved server-side by
/// the delegate (here the in-memory mock).
class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CmsTablePage(
      title: 'AI Skills',
      delegate: skillsDelegate,
      pagingLimit: 10,
      params: const CmsTableParams(initialSortingParams: CmsFunctionsSortingParams(sortDesc: true, fieldKey: 'refs')),
      filterEntries: [
        CmsFilterSearchEntry(filterKeys: const ['link.name', 'description'], entryKey: 'q', label: 'Search AI skills'),
      ],
      entries: [
        SvgMediaEntry(
          key: 'animal',
          gallery: kSpiritAnimals,
          labels: kSpiritAnimalLabels,
          // Empty header - the avatar column needs no title.
          label: '',
          // Fixed-width, non-flexing column: the avatar should not stretch.
          flex: null,
          width: 60,
        ),
        CmsLinkEntry(key: 'link', label: 'Skill'),
        CmsTextEntry(
          key: 'description',
          label: 'What it does',
          flex: 4,
          maxLines: 3,
          modifier: const CmsEntryModifier(expanded: true),
        ),
        CmsNumEntry(
          key: 'refs',
          label: 'Refs',
          flex: 1,
          modifier: const CmsEntryModifier(sortable: true),
          previewBuilder: (v) => v == null ? '-' : '${v.toInt()}',
        ),
      ],
    );
  }
}
