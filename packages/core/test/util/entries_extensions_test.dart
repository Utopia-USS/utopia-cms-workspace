import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_bool_entry.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_text_entry.dart';
import 'package:utopia_cms/src/util/entries_extensions.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

void main() {
  group('editable', () {
    test('returns an empty list when the page is not editable', () {
      final entries = IList<CmsEntry<dynamic>>([CmsTextEntry(key: 'a')]);

      expect(entries.editable(isCreate: false, isPageEditable: false), isEmpty);
    });

    test('keeps only editable entries outside of create', () {
      final editableEntry = CmsTextEntry(key: 'a');
      final notEditableNotInitializable = CmsTextEntry(
        key: 'b',
        modifier: const CmsEntryModifier(editable: false, initializable: false),
      );
      final entries = IList<CmsEntry<dynamic>>([editableEntry, notEditableNotInitializable]);

      final result = entries.editable(isCreate: false, isPageEditable: true);

      expect(result, [editableEntry]);
    });

    test('excludes an entry that is not editable but is initializable when isCreate is false', () {
      final entry = CmsTextEntry(key: 'a', modifier: const CmsEntryModifier(editable: false));
      final entries = IList<CmsEntry<dynamic>>([entry]);

      expect(entries.editable(isCreate: false, isPageEditable: true), isEmpty);
    });

    test('includes an entry that is not editable but is initializable when isCreate is true', () {
      final entry = CmsTextEntry(key: 'a', modifier: const CmsEntryModifier(editable: false));
      final entries = IList<CmsEntry<dynamic>>([entry]);

      expect(entries.editable(isCreate: true, isPageEditable: true), [entry]);
    });
  });

  group('readOnly', () {
    test('returns the full list unchanged when the page is not editable', () {
      final entries = IList<CmsEntry<dynamic>>([CmsTextEntry(key: 'a'), CmsTextEntry(key: 'b')]);

      expect(entries.readOnly(isPageEditable: false), same(entries));
    });

    test('returns only non-editable entries when the page is editable', () {
      final editableEntry = CmsTextEntry(key: 'a');
      final notEditableEntry = CmsTextEntry(key: 'b', modifier: const CmsEntryModifier(editable: false));
      final entries = IList<CmsEntry<dynamic>>([editableEntry, notEditableEntry]);

      expect(entries.readOnly(isPageEditable: true), [notEditableEntry]);
    });
  });

  group('pinnedFor', () {
    test('keeps an entry pinned for web but drops it for mobile', () {
      final entry = CmsTextEntry(key: 'a', modifier: CmsEntryModifier(pinned: (t) => !t.isMobile));
      final entries = IList<CmsEntry<dynamic>>([entry]);

      expect(entries.pinnedFor(CmsPageType.web), [entry]);
      expect(entries.pinnedFor(CmsPageType.mobile), isEmpty);
    });
  });

  group('sorted', () {
    test('keeps non-long entries first, then long text entries, preserving relative order', () {
      final longText = CmsTextEntry(key: 'long1', maxLines: 3);
      final shortText = CmsTextEntry(key: 'short');
      final boolEntry = CmsBoolEntry(key: 'flag');
      final longText2 = CmsTextEntry(key: 'long2', maxLines: 4);
      final entries = IList<CmsEntry<dynamic>>([longText, shortText, boolEntry, longText2]);

      expect(entries.sorted, [shortText, boolEntry, longText, longText2]);
    });
  });

  group('isExpanded', () {
    test('is true for a CmsTextEntry with maxLines > 1', () {
      final entry = CmsTextEntry(key: 'a', maxLines: 2);

      expect(entry.isExpanded, isTrue);
    });

    test('is false for a CmsTextEntry with maxLines == 1', () {
      final entry = CmsTextEntry(key: 'a');

      expect(entry.isExpanded, isFalse);
    });

    test('is true for any entry with modifier.expanded', () {
      final entry = CmsBoolEntry(key: 'a', modifier: const CmsEntryModifier(expanded: true));

      expect(entry.isExpanded, isTrue);
    });
  });
}
