import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:media_kit/media_kit.dart';
import 'package:utopia_cms/utopia_cms.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import 'pages/home_page.dart';
import 'pages/libs_page.dart';
import 'pages/skills_page.dart';
import 'state/theme_mode_state.dart';
import 'theme.dart';
import 'widgets/theme_picker_menu_item.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const UtopiaShowcaseApp());
}

/// App-wide hook providers. [ThemeModeState] holds the selected theme mode,
/// written by the menu's theme picker and read by the shell to re-theme the CMS.
const _providers = <Type, Object? Function()>{ThemeModeState: useThemeModeState};

/// A deployable utopia_cms showcase that catalogs the Utopia ecosystem itself:
/// one [CmsWidget] shell with a "Libs" page (the pub.dev packages) and a
/// "Skills" page (the Claude Code skills), both on stateful in-memory mock
/// delegates - every create / edit / delete is live for the session. The
/// menu's theme picker re-themes the whole shell at runtime from global state.
class UtopiaShowcaseApp extends StatelessWidget {
  const UtopiaShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utopia - Libs & Skills',
      debugShowCheckedModeBanner: false,
      home: const HookProviderContainerWidget(
        _providers,
        alwaysNotifyDependents: false,
        child: Portal(child: _ShowcaseShell()),
      ),
    );
  }
}

/// The CMS shell, re-themed reactively from [ThemeModeState]. Selecting a mode in
/// the menu's theme picker rebuilds this widget with a new [CmsThemeData], which
/// [CmsWidget] propagates to every surface.
class _ShowcaseShell extends HookWidget {
  const _ShowcaseShell();

  @override
  Widget build(BuildContext context) {
    final themeMode = useProvided<ThemeModeState>();
    final theme = themeFor(themeMode.mode.value);
    // The menu paints on theme.colors.surface (no backgroundColors set), so the
    // logo ink follows that surface's brightness: the white-ink variants on the
    // dark themes (Dracula / Neon / Forest), the black-ink ones on the light
    // themes (Light / Kawaii).
    final isDarkMenu = theme.colors.surface.computeLuminance() < 0.5;
    return CmsWidget(
      theme: theme,
      menuParams: CmsWidgetMenuParams(
        headerBuilder: (context, isCollapsed) => _MenuHeader(isCollapsed: isCollapsed, isDark: isDarkMenu),
      ),
      items: [
        // First page = the shell's default landing page. The marketing home
        // dashboard takes the theme in so it recolours with the rest of the
        // shell when the theme picker fires.
        CmsWidgetItem.page(
          id: 'home',
          icon: const Icon(Icons.waving_hand_outlined),
          title: const Text('About'),
          content: HomePage(theme: theme),
        ),
        CmsWidgetItem.page(
          id: 'libs',
          icon: const Icon(Icons.redeem_outlined),
          title: const Text('Packages'),
          content: const LibsPage(),
        ),
        CmsWidgetItem.page(
          id: 'skills',
          icon: const Icon(Icons.bolt),
          title: const Text('AI Skills'),
          content: const SkillsPage(),
        ),
        CmsWidgetItem.custom(flex: 1),
        // The bottom "About" entry is replaced by the theme picker, which writes
        // the selected mode back to global state and re-themes the whole shell.
        CmsWidgetItem.custom(child: ThemePickerMenuItem(theme: theme)),
      ],
    );
  }
}

/// The utopia_cms logo pinned to the top of the menu. Collapsed, it shows just
/// the bare Utopia mark (a tightly-cropped variant of the lockup with the
/// wordmark removed), centred at the top of the rail; expanded, the full lockup,
/// left-aligned with the menu icons. Both states occupy the same fixed [_height]
/// so the items below don't shift when the rail toggles.
///
/// Each logo ships as a theme-aware pair - a black-ink `*_light.png` for the
/// light themes and a white-ink `*_dark.png` for the dark ones - and [isDark]
/// (the menu surface's brightness) picks the variant that reads on the current
/// sidebar.
class _MenuHeader extends StatelessWidget {
  final bool isCollapsed;
  final bool isDark;

  const _MenuHeader({required this.isCollapsed, required this.isDark});

  static const double _height = 64;

  @override
  Widget build(BuildContext context) {
    final mark = isDark ? 'assets/utopia_mark_dark.png' : 'assets/utopia_mark_light.png';
    final lockup = isDark ? 'assets/cms_core_dark.png' : 'assets/cms_core_light.png';
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: isCollapsed
          ? Align(
              alignment: Alignment.center,
              child: Image(image: AssetImage(mark), height: _height * 0.75, fit: BoxFit.contain),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 26, right: 16),
              child: Image.asset(lockup, height: _height, fit: BoxFit.contain, alignment: Alignment.centerLeft),
            ),
    );
  }
}
