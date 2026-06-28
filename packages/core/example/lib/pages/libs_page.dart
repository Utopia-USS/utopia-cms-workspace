import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utopia_cms/utopia_cms.dart';

import '../entries/dropdown_filter_entry.dart';
import '../entries/svg_media_entry.dart';
import '../mock/marks.dart';
import '../mock/seed_data.dart';

/// "Libs" - the Utopia package catalog.
///
/// Entries: spirit-animal media, a clickable [CmsLinkEntry] to pub.dev, a second
/// link to the GitHub source, a layer dropdown, a tags relation, a description
/// and a "used here" flag (is this a package the showcase itself is built on?).
/// Plus a row action that copies the `flutter pub add` line.
///
/// Filters: a free-text search across name + description, a layer facet, and a
/// tri-state "used here" facet - all resolved server-side by the delegate (here
/// the in-memory mock).
class LibsPage extends StatelessWidget {
  const LibsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CmsTablePage(
      title: 'Packages',
      delegate: libsDelegate,
      pagingLimit: 20,
      filterEntries: [
        CmsFilterSearchEntry(filterKeys: const ['link.name', 'description'], entryKey: 'q', label: 'Search packages'),
        CmsDropdownFilterEntry<String>(
          entryKey: 'layer',
          filterKey: 'layer',
          label: 'Layer',
          values: kLayers,
          valueLabelBuilder: (v) => v,
        ),
        CmsDropdownFilterEntry<bool>(
          entryKey: 'usedHere',
          filterKey: 'usedHere',
          label: 'Used here',
          values: const [true, false],
          valueLabelBuilder: (v) => v ? 'Yes' : 'No',
        ),
      ],
      customActions: [
        CmsTableAction(
          label: 'Copy flutter pub add',
          shouldUpdateTable: false,
          onPressed: (row) async {
            final name = (row['link'] as Map?)?['name'] as String? ?? '';
            await Clipboard.setData(ClipboardData(text: 'flutter pub add $name'));
            return null;
          },
        ),
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
        CmsLinkEntry(key: 'link', label: 'Package', flex: 3),
        CmsLinkEntry(key: 'github', label: 'GitHub', flex: 2),
        CmsDropdownEntry<String>(
          key: 'layer',
          label: 'Layer',
          flex: 1,
          values: kLayers,
          valueLabelBuilder: (v) => v ?? '',
        ),
        CmsToManyDropdownEntry(
          delegate: tagsDelegate,
          label: 'Tags',
          flex: 4,
          filterFields: const ['name'],
          fieldDisplayBuilder: (tag) => tag['name'] as String? ?? '',
          previewDisplayBuilder: (tag) => tag['name'] as String? ?? '',
        ),
        CmsTextEntry(
          key: 'description',
          label: 'Description',
          flex: 6,
          maxLines: 3,
          modifier: const CmsEntryModifier(expanded: true),
        ),
        CmsBoolEntry(key: 'usedHere', label: 'Used here', flex: 1),
      ],
    );
  }
}
