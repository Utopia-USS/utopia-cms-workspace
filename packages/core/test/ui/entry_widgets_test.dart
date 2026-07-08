import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_bool_entry.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_date_entry.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_dropdown_entry.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_num_entry.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_text_entry.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('CmsTextEntry', () {
    testWidgets('buildPreview shows the value text', (tester) async {
      final entry = CmsTextEntry(key: 'name');

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, 'hello'))));

      expect(find.text('hello'), findsOneWidget);
    });

    testWidgets('buildPreview shows the previewBuilder output instead of the raw value', (tester) async {
      final entry = CmsTextEntry(key: 'name', previewBuilder: (value) => 'built: $value');

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, 'hello'))));

      expect(find.text('built: hello'), findsOneWidget);
      expect(find.text('hello'), findsNothing);
    });

    testWidgets('buildEditField renders a TextField and the required label', (tester) async {
      final entry = CmsTextEntry(key: 'name');

      await tester.pumpWidget(
        _wrap(Builder(builder: (context) => entry.buildEditField(context: context, value: 'x', onChanged: (_) {}))),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('name*'), findsOneWidget);
    });
  });

  group('CmsNumEntry', () {
    testWidgets('buildPreview shows value.toString()', (tester) async {
      final entry = CmsNumEntry(key: 'count');

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, 42))));

      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('buildPreview shows the previewBuilder output instead', (tester) async {
      final entry = CmsNumEntry(key: 'count', previewBuilder: (value) => '#$value');

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, 42))));

      expect(find.text('#42'), findsOneWidget);
    });

    testWidgets('buildPreview renders without crashing for a null value with no previewBuilder', (tester) async {
      final entry = CmsNumEntry(key: 'count');

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, null))));

      expect(tester.takeException(), isNull);
    });
  });

  group('CmsBoolEntry', () {
    testWidgets('buildPreview renders a CmsSwitch for a true value', (tester) async {
      final entry = CmsBoolEntry(key: 'flag');

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, true))));

      expect(find.byType(CmsSwitch), findsOneWidget);
    });

    testWidgets('buildPreview renders a CmsSwitch for a null value', (tester) async {
      final entry = CmsBoolEntry(key: 'flag');

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, null))));

      expect(find.byType(CmsSwitch), findsOneWidget);
    });
  });

  group('CmsDateEntry', () {
    testWidgets('buildPreview shows toDisplayStringWithoutHours()', (tester) async {
      final entry = CmsDateEntry(key: 'date');
      final date = DateTime(2026, 7, 2, 13, 30);

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, date))));

      expect(find.text(date.toDisplayStringWithoutHours()), findsOneWidget);
    });
  });

  group('CmsDropdownEntry', () {
    testWidgets('buildPreview shows "-" when valueLabelBuilder returns an empty string', (tester) async {
      final entry = CmsDropdownEntry<String>(
        key: 'status',
        values: const ['active', 'inactive'],
        valueLabelBuilder: (value) => '',
      );

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, 'active'))));

      expect(find.text('-'), findsOneWidget);
    });

    testWidgets('buildPreview shows a CmsChip with the label when non-empty', (tester) async {
      final entry = CmsDropdownEntry<String>(
        key: 'status',
        values: const ['active', 'inactive'],
        valueLabelBuilder: (value) => 'Active',
      );

      await tester.pumpWidget(_wrap(Builder(builder: (context) => entry.buildPreview(context, 'active'))));

      expect(find.byType(CmsChip), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
    });
  });
}
