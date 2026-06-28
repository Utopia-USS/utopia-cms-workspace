import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:utopia_cms/utopia_cms.dart';

import '../widgets/home/home_abstractions_section.dart';
import '../widgets/home/home_backends_section.dart';
import '../widgets/home/home_entries_section.dart';
import '../widgets/home/home_hero.dart';
import '../widgets/home/home_showcase_data.dart';
import '../widgets/home/home_theme_switcher.dart';

/// "Home" - the marketing landing page and default page of the showcase.
///
/// A scrolling, sectioned landing in the Auris HUD style: hero with a live code
/// card -> the live theme switcher (the interactive money-shot, right under the
/// hero) -> backend packages -> core type abstractions -> entry catalog.
/// Content is centred at [_maxContentWidth] so a wide viewport reads like a real
/// landing page instead of stretched-thin admin chrome.
///
/// Like `LibsPage` / `SkillsPage` this is a plain presentational page; the only
/// live state (the selected theme) lives in [HomeThemeSwitcher], a widget-level
/// hook component. The active [theme] is passed in by the shell so every
/// section recolours the instant the theme changes.
class HomePage extends StatelessWidget {
  final CmsThemeData theme;

  const HomePage({super.key, required this.theme});

  static const double _maxContentWidth = 1180;

  void _openUrl(String url) => unawaited(launchUrlString(url));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: theme.pageTopPadding),
        const CmsHeader(text: 'Home'),
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxContentWidth),
                // The CMS layout builder: derives a mobile / tablet / web size class
                // from the content width and exposes it via `context.pageType`, so the
                // hero adapts on the same breakpoints as the rest of the CMS instead
                // of a bespoke threshold.
                child: CmsPageWrapper(builder: (context, _) => _buildSections()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        HomeHero(theme: theme, onOpenPubDev: () => _openUrl(kPubDevUrl), onOpenGithub: () => _openUrl(kGithubUrl)),
        const SizedBox(height: 36),
        HomeThemeSwitcher(theme: theme),
        const SizedBox(height: 72),
        HomeBackendsSection(theme: theme, onOpen: _openUrl),
        const SizedBox(height: 72),
        HomeAbstractionsSection(theme: theme, onOpen: _openUrl),
        const SizedBox(height: 72),
        HomeEntriesSection(theme: theme),
        const SizedBox(height: 48),
      ],
    );
  }
}
