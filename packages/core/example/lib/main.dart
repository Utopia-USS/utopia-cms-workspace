import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart';
import 'package:utopia_cms/utopia_cms.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import 'app_images.dart';
import 'pages/home_page.dart';
import 'pages/libs_page.dart';
import 'pages/skills_page.dart';
import 'state/image_precache_state.dart';
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
/// [ImagePrecacheState] decodes the menu art before the shell paints.
const _providers = <Type, Object? Function()>{
  ThemeModeState: useThemeModeState,
  ImagePrecacheState: useImagePrecacheState,
};

/// The pages the shell exposes. The URL path (`/home`, `/libs`, `/skills`) owns
/// which one is selected, so each page is deep-linkable and browser back/forward
/// works; [home] is the default landing page.
class ShowcasePages {
  const ShowcasePages._();

  static const home = 'home';
  static const libs = 'libs';
  static const skills = 'skills';

  static const all = {home, libs, skills};
}

/// The URL is the single source of truth for the selected page. `/:pageId` builds
/// the shell with that page selected; `/` (no id) falls through to the default
/// page, and an unknown id is clamped to [ShowcasePages.home] rather than
/// rendering a blank stack.
GoRouter _buildRouter() => GoRouter(
  initialLocation: '/${ShowcasePages.home}',
  redirect: (context, state) => state.uri.path == '/' ? '/${ShowcasePages.home}' : null,
  routes: [
    GoRoute(
      path: '/:pageId',
      // The const key keeps the one shell element mounted across page switches,
      // so the CMS tables keep their loaded rows / filters as you change pages -
      // without it every `context.go` would remount the shell and wipe that state.
      pageBuilder: (context, state) {
        final id = state.pathParameters['pageId'];
        final pageId = ShowcasePages.all.contains(id) ? id! : ShowcasePages.home;
        return MaterialPage(
          key: const ValueKey('shell'),
          child: _ShowcaseShell(pageId: pageId),
        );
      },
    ),
  ],
);

/// A deployable utopia_cms showcase that catalogs the Utopia ecosystem itself:
/// one [CmsWidget] shell with a "Libs" page (the pub.dev packages) and a
/// "Skills" page (the Claude Code skills), both on stateful in-memory mock
/// delegates - every create / edit / delete is live for the session. The
/// menu's theme picker re-themes the whole shell at runtime from global state.
class UtopiaShowcaseApp extends HookWidget {
  const UtopiaShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // One router per app instance, stable across rebuilds: the route param drives
    // the shell, so the router carries the navigation state for the app's lifetime.
    final router = useMemoized(_buildRouter);
    return MaterialApp.router(
      title: 'Utopia - Libs & Skills',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      // The providers sit under MaterialApp (so the precache hook has a real
      // BuildContext to decode against) and above the routed shell (so every
      // page can read them). The gate holds the first paint until the art is warm.
      builder: (context, child) => HookProviderContainerWidget(
        _providers,
        alwaysNotifyDependents: false,
        child: Portal(child: _PrecacheGate(child: child!)),
      ),
    );
  }
}

/// Holds the first paint behind the themed canvas until the menu/logo art is
/// decoded, so the shell appears with its images already warm (no pop-in on
/// load). This is the lightweight splash tier - a [HookWidget] that reads the
/// globals inline - so it may consume [useProvided] directly.
class _PrecacheGate extends HookWidget {
  final Widget child;

  const _PrecacheGate({required this.child});

  @override
  Widget build(BuildContext context) {
    final precache = useProvided<ImagePrecacheState>();
    final themeMode = useProvided<ThemeModeState>();
    if (precache.isInitialized) return child;
    // Paint the theme's canvas so there's no white flash before the shell shows.
    return ColoredBox(color: themeFor(themeMode.mode.value).colors.canvas, child: const SizedBox.expand());
  }
}

/// The CMS shell, re-themed reactively from [ThemeModeState]. Selecting a mode in
/// the menu's theme picker rebuilds this widget with a new [CmsThemeData], which
/// [CmsWidget] propagates to every surface. [pageId] (the URL route param) drives
/// which page is shown, and tapping a rail item navigates the URL - both bound in
/// one place through [MutableValue.computed].
class _ShowcaseShell extends HookWidget {
  final String pageId;

  const _ShowcaseShell({required this.pageId});

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
      // URL -> menu (so deep links and browser back/forward select the right page)
      // and menu -> URL (a rail tap navigates). The route param stays the source
      // of truth, so the two directions can't drift apart.
      selectedPageId: MutableValue.computed(() => pageId, (id) => context.go('/$id')),
      menuParams: CmsWidgetMenuParams(
        headerBuilder: (context, isCollapsed) => _MenuHeader(isCollapsed: isCollapsed, isDark: isDarkMenu),
      ),
      items: [
        // First page = the shell's default landing page. The marketing home
        // dashboard takes the theme in so it recolours with the rest of the
        // shell when the theme picker fires.
        CmsWidgetItem.page(
          id: ShowcasePages.home,
          icon: const Icon(Icons.waving_hand_outlined),
          title: const Text('About'),
          content: HomePage(theme: theme),
        ),
        CmsWidgetItem.page(
          id: ShowcasePages.libs,
          icon: const Icon(Icons.redeem_outlined),
          title: const Text('Packages'),
          content: const LibsPage(),
        ),
        CmsWidgetItem.page(
          id: ShowcasePages.skills,
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
    final mark = isDark ? AppImages.utopiaMarkDark : AppImages.utopiaMarkLight;
    final lockup = isDark ? AppImages.cmsCoreDark : AppImages.cmsCoreLight;
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: isCollapsed
          ? Align(
              child: Image(image: AssetImage(mark), height: _height * 0.75, fit: BoxFit.contain),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 26, right: 16),
              child: Image.asset(lockup, height: _height, fit: BoxFit.contain, alignment: Alignment.centerLeft),
            ),
    );
  }
}
