import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms_example/main.dart';

void main() {
  /// The admin shell is a wide desktop/web layout; the default 800x600 test
  /// surface overflows it. Give every test a realistic window.
  void useWideWindow(WidgetTester tester) {
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('home is the default landing page', (tester) async {
    useWideWindow(tester);
    await tester.pumpWidget(const UtopiaShowcaseApp());
    await tester.pump();

    // The marketing hero (brand + tagline) renders up front, with its pub.dev
    // CTA repeated in the closing band (landing pages repeat the CTA).
    expect(find.text('utopia_cms'), findsWidgets);
    expect(find.text('VIEW ON PUB.DEV'), findsWidgets);
    // The entry catalog and backend sections render their content.
    expect(find.text('CmsTextEntry'), findsOneWidget);
    expect(find.text('utopia_cms_graphql'), findsOneWidget);
  });

  testWidgets('selecting Libs loads the table seed data', (tester) async {
    useWideWindow(tester);
    await tester.pumpWidget(const UtopiaShowcaseApp());
    await tester.pump();

    // Home is the default page (lazy stack), so the Libs table only builds once
    // its rail item is tapped.
    await tester.tap(find.byIcon(Icons.redeem_outlined));
    await tester.pump();
    // The mock delegate simulates ~280ms latency; advance past it.
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    // A seed row's link rendered => delegate.get ran end-to-end without throwing.
    expect(find.text('utopia_hooks'), findsOneWidget);
  });

  testWidgets('home theme switcher re-themes the shell live', (tester) async {
    useWideWindow(tester);
    await tester.pumpWidget(const UtopiaShowcaseApp());
    await tester.pump();

    // Light is the default mode, so its option carries the active check.
    expect(find.byKey(const ValueKey('homeThemeActive_light')), findsOneWidget);
    expect(find.byKey(const ValueKey('homeThemeActive_dracula')), findsNothing);

    // The theme section lives near the bottom of the landing scroll; bring it
    // into view, then tap Dracula. The shell rebuilds and the marker moves.
    final dracula = find.byKey(const ValueKey('homeThemeOption_dracula'));
    await tester.ensureVisible(dracula);
    await tester.pumpAndSettle();
    await tester.tap(dracula);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('homeThemeActive_dracula')), findsOneWidget);
    expect(find.byKey(const ValueKey('homeThemeActive_light')), findsNothing);
  });

  testWidgets('rail theme picker opens, lists modes, and dismisses on select', (
    tester,
  ) async {
    useWideWindow(tester);
    await tester.pumpWidget(const UtopiaShowcaseApp());
    await tester.pump();

    // The picker tile is the only palette icon in the rail (the home theme card
    // uses a different glyph).
    await tester.tap(find.byIcon(Icons.palette_outlined));
    await tester.pumpAndSettle();

    // The popup lists the modes (keyed, so they don't collide with the home
    // switcher's own mode pills).
    expect(find.byKey(const ValueKey('railThemeOption_dracula')), findsOneWidget);
    expect(find.byKey(const ValueKey('railThemeOption_cyberpunk')), findsOneWidget);

    // Selecting a mode re-themes the shell and closes the popup.
    await tester.tap(find.byKey(const ValueKey('railThemeOption_dracula')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('railThemeOption_dracula')), findsNothing);
  });
}
