import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_text_entry.dart';
import 'package:utopia_cms/src/ui/table_page/cms_entry_columns.dart';
import 'package:utopia_cms/src/util/foundation.dart';

void main() {
  group('toTableEntry', () {
    test('flexing entry maps to a flexing CmsTableEntry', () {
      final entry = CmsTextEntry(key: 'name', flex: 3, modifier: const CmsEntryModifier(sortable: true));

      final tableEntry = entry.toTableEntry();

      expect(tableEntry.id, 'name');
      expect(tableEntry.title, entry.fixedLabel);
      expect(tableEntry.flex, 3);
      expect(tableEntry.width, isNull);
      expect(tableEntry.sortable, isTrue);
      expect(tableEntry.isSortable, isTrue);
    });

    test('flex null with an explicit width maps to a fixed CmsTableEntry', () {
      final entry = CmsTextEntry(key: 'icon', flex: null, width: 56);

      final tableEntry = entry.toTableEntry();

      expect(tableEntry.flex, isNull);
      expect(tableEntry.width, 56.0);
    });

    test('flex null with no width leaves both null for the downstream default', () {
      final entry = CmsTextEntry(key: 'icon', flex: null);

      final tableEntry = entry.toTableEntry();

      expect(tableEntry.flex, isNull);
      expect(tableEntry.width, isNull);
    });
  });

  test('toTableEntries preserves order and length', () {
    final entries = IList<CmsEntry<dynamic>>([
      CmsTextEntry(key: 'a'),
      CmsTextEntry(key: 'b'),
      CmsTextEntry(key: 'c'),
    ]);

    final tableEntries = entries.toTableEntries();

    expect(tableEntries.length, 3);
    expect(tableEntries.map((e) => e.id).toList(), ['a', 'b', 'c']);
  });

  testWidgets('cellBuilder resolves nested paths through fromJson', (tester) async {
    final entry = CmsTextEntry(key: 'a.b');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => entry.toTableEntry().cellBuilder(context, {
              'a': {'b': 'hello'},
            }),
          ),
        ),
      ),
    );

    expect(find.text('hello'), findsOneWidget);
  });
}
