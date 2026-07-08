import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_text_entry.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

void main() {
  group('fixedLabel', () {
    test('uses label when set', () {
      final entry = CmsTextEntry(key: 'foo', label: 'Bar');

      expect(entry.fixedLabel, 'Bar');
    });

    test('falls back to the last segment of a dotted key when label is null', () {
      final entry = CmsTextEntry(key: 'user.data.image');

      expect(entry.fixedLabel, 'image');
    });

    test('falls back to the key itself when it is not dotted', () {
      final entry = CmsTextEntry(key: 'name');

      expect(entry.fixedLabel, 'name');
    });
  });

  group('fixedLabelRequired', () {
    test('appends * when the modifier requires the entry', () {
      final entry = CmsTextEntry(key: 'name');

      expect(entry.fixedLabelRequired, 'name*');
    });

    test('does not append * when the modifier does not require the entry', () {
      final entry = CmsTextEntry(key: 'name', modifier: const CmsEntryModifier(required: false));

      expect(entry.fixedLabelRequired, 'name');
    });
  });

  test('default toJson/fromJson are the identity', () {
    final entry = CmsTextEntry(key: 'name');

    expect(entry.toJson('x'), 'x');
    expect(entry.fromJson('x'), 'x');
    expect(entry.fromJson(null), isNull);
  });

  test('CmsEntry getters delegate to the modifier field by field', () {
    final entry = CmsTextEntry(
      key: 'name',
      modifier: const CmsEntryModifier(
        editable: false,
        required: false,
        sortable: true,
        sortInvertNulls: true,
        expanded: true,
        initializable: false,
      ),
    );

    expect(entry.editable, isFalse);
    expect(entry.required, isFalse);
    expect(entry.sortable, isTrue);
    expect(entry.sortInvertNulls, isTrue);
    expect(entry.expanded, isTrue);
    expect(entry.initializable, isFalse);
  });

  // Defaults are public API for a published package: a silent change flips
  // behavior in downstream forms, so the whole contract is pinned once here.
  test('CmsEntryModifier defaults', () {
    const modifier = CmsEntryModifier();

    expect(modifier.editable, isTrue);
    expect(modifier.required, isTrue);
    expect(modifier.sortable, isFalse);
    expect(modifier.sortInvertNulls, isFalse);
    expect(modifier.expanded, isFalse);
    expect(modifier.initializable, isTrue);
    for (final pageType in CmsPageType.values) {
      expect(modifier.pinned(pageType), isTrue, reason: 'expected pinned($pageType) to be true');
    }
  });
}
