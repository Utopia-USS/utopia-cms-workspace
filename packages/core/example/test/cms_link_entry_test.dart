import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/utopia_cms.dart';

void main() {
  /// Pumps the link entry's edit field at a given width. [CmsPageWrapper]
  /// resolves the page type from that width (mobile < 600), exactly as the real
  /// edit overlay does, so `context.pageType` inside the field works.
  Future<void> pumpEditField(WidgetTester tester, {required double width}) async {
    dynamic value = <String, dynamic>{'name': 'utopia_cms', 'url': 'https://pub.dev/packages/utopia_cms'};
    final entry = CmsLinkEntry(key: 'link', label: 'Package');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: width,
              child: CmsPageWrapper(
                builder: (context, _) =>
                    entry.buildEditField(context: context, value: value, onChanged: (v) => value = v),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders the label and the URL as two text fields', (tester) async {
    await pumpEditField(tester, width: 1000);

    expect(find.text('Package - label (optional)'), findsOneWidget);
    expect(find.text('URL'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('web/tablet: the two fields sit side by side without overflow', (tester) async {
    await pumpEditField(tester, width: 1000);

    expect(tester.takeException(), isNull);

    final left = tester.getTopLeft(find.byType(TextField).at(0));
    final right = tester.getTopLeft(find.byType(TextField).at(1));

    // Side by side: second field to the right of the first, on the same row.
    expect(right.dx, greaterThan(left.dx));
    expect((right.dy - left.dy).abs(), lessThan(1.0));
  });

  testWidgets('mobile: the two fields stack into one column without overflow', (tester) async {
    await pumpEditField(tester, width: 480);

    expect(tester.takeException(), isNull);

    final top = tester.getTopLeft(find.byType(TextField).at(0));
    final bottom = tester.getTopLeft(find.byType(TextField).at(1));

    // Stacked: same horizontal offset, the URL sits below the label.
    expect((bottom.dx - top.dx).abs(), lessThan(1.0));
    expect(bottom.dy, greaterThan(top.dy));
  });

  testWidgets('is an expanded (full-row) entry by default', (tester) async {
    expect(CmsLinkEntry(key: 'link').modifier.expanded, isTrue);
  });
}
