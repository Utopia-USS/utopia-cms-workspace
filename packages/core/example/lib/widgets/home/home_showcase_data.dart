import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

/// Static content for the home dashboard. Pure data (no widgets beyond
/// [IconData]) so the presentational widgets stay dumb and the catalog is
/// editable in one place.

/// One `CmsEntry` type, as listed in the home page "Entry types" catalog. Each
/// row mirrors a real exported entry from `package:utopia_cms`.
class HomeEntryInfo {
  /// Glyph shown in the tile's icon chip.
  final IconData icon;

  /// The exported class name, rendered verbatim (e.g. `CmsTextEntry`).
  final String name;

  /// One-line description of what the entry renders / edits.
  final String blurb;

  const HomeEntryInfo({required this.icon, required this.name, required this.blurb});
}

/// A pub.dev package row in the home page "Backends" card - the delegate
/// packages a CMS can sit on. [url] opens on pub.dev.
class HomePackageInfo {
  final String name;
  final String blurb;
  final String url;

  const HomePackageInfo({required this.name, required this.blurb, required this.url});
}

/// A core utopia_cms abstraction shown in the "Core types" section: the base
/// classes you compose, each linking to its source on GitHub.
class HomeAbstractionInfo {
  final IconData icon;
  final String name;
  final String blurb;
  final String url;

  const HomeAbstractionInfo({required this.icon, required this.name, required this.blurb, required this.url});
}

String _ghSource(String path) =>
    'https://github.com/Utopia-USS/utopia-cms-workspace/blob/master/packages/core/lib/src/$path';

/// The base abstractions a CMS is built from - everything else extends one of
/// these. Each tile opens its source file on GitHub.
final IList<HomeAbstractionInfo> kHomeAbstractions = [
  HomeAbstractionInfo(
    icon: Icons.dashboard_outlined,
    name: 'CmsWidget',
    blurb: 'The admin shell: menu, pages, theming.',
    url: _ghSource('ui/cms_widget/cms_widget.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.table_chart_outlined,
    name: 'CmsTablePage',
    blurb: 'List, filter, sort and CRUD - declared.',
    url: _ghSource('ui/table_page/cms_table_page.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.dns_outlined,
    name: 'CmsDelegate',
    blurb: 'Your backend: get / create / update / delete.',
    url: _ghSource('delegate/cms_delegate.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.view_column_outlined,
    name: 'CmsEntry',
    blurb: 'One column: cell, edit field and filter.',
    url: _ghSource('model/entry/cms_entry.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.filter_alt_outlined,
    name: 'CmsFilterEntry',
    blurb: 'A table filter: search, dropdown, date.',
    url: _ghSource('model/filter_entry/cms_filter_entry.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.bolt_outlined,
    name: 'CmsTableAction',
    blurb: 'A per-row popup action.',
    url: _ghSource('model/table/cms_table_action.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.account_tree_outlined,
    name: 'CmsToManyDelegate',
    blurb: 'One-to-many & many-to-many relations.',
    url: _ghSource('delegate/cms_to_many_delegate.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.perm_media_outlined,
    name: 'CmsMediaDelegate',
    blurb: 'Media upload and display.',
    url: _ghSource('delegate/media/cms_media_delegate.dart'),
  ),
  HomeAbstractionInfo(
    icon: Icons.dashboard_customize_outlined,
    name: 'CmsManagementSectionEntry',
    blurb: 'Custom UI inside the edit overlay.',
    url: _ghSource('model/item_management/cms_management_section_entry.dart'),
  ),
].lock;

/// The `CmsTablePage` snippet shown in the hero's code card - a real, compiling
/// shape: a title, a delegate and a handful of entries is an entire admin page.
const List<List<String>> kHeroCodeLines = [
  ['type:CmsTablePage', 'punc:('],
  ['indent:  ', 'prop:title', 'punc:: ', "str:'Users'", 'punc:,'],
  ['indent:  ', 'prop:delegate', 'punc:: ', 'type:UserDelegate', 'punc:(),'],
  ['indent:  ', 'prop:entries', 'punc:: ['],
  ['indent:    ', 'type:CmsTextEntry', 'punc:(', 'prop:key', 'punc:: ', "str:'name'", 'punc:),'],
  ['indent:    ', 'type:CmsLinkEntry', 'punc:(', 'prop:key', 'punc:: ', "str:'email'", 'punc:),'],
  ['indent:    ', 'type:CmsBoolEntry', 'punc:(', 'prop:key', 'punc:: ', "str:'active'", 'punc:),'],
  ['indent:    ', 'type:CmsDateEntry', 'punc:(', 'prop:key', 'punc:: ', "str:'joined'", 'punc:),'],
  ['indent:  ', 'punc:],'],
  ['punc:)'],
];

/// The install command surfaced as a copyable chip in the hero and closing CTA.
const String kPubAddCommand = 'flutter pub add utopia_cms';

String _pubDev(String package) => 'https://pub.dev/packages/$package';

/// pub.dev page for the core package - the hero's primary CTA.
final String kPubDevUrl = _pubDev('utopia_cms');

/// The core's GitHub repository - the hero's secondary CTA.
const String kGithubUrl = 'https://github.com/Utopia-USS/utopia-cms-workspace';

/// The exported `CmsEntry` catalog, shown as the home page's "Entry types" grid.
/// Adding a column to a real table is picking one of these - the page makes that
/// catalog visible at a glance.
final IList<HomeEntryInfo> kHomeEntries = const [
  HomeEntryInfo(icon: Icons.subject, name: 'CmsTextEntry', blurb: 'Single & multi-line text'),
  HomeEntryInfo(icon: Icons.tag, name: 'CmsNumEntry', blurb: 'Numbers, sortable'),
  HomeEntryInfo(icon: Icons.toggle_on_outlined, name: 'CmsBoolEntry', blurb: 'Toggles & flags'),
  HomeEntryInfo(icon: Icons.event_outlined, name: 'CmsDateEntry', blurb: 'Date picker'),
  HomeEntryInfo(icon: Icons.arrow_drop_down_circle_outlined, name: 'CmsDropdownEntry', blurb: 'Single choice'),
  HomeEntryInfo(icon: Icons.account_tree_outlined, name: 'CmsToManyDropdownEntry', blurb: 'To-many relations'),
  HomeEntryInfo(icon: Icons.public, name: 'CmsCountryEntry', blurb: 'Country picker'),
  HomeEntryInfo(icon: Icons.perm_media_outlined, name: 'CmsMediaEntry', blurb: 'Images & video'),
  HomeEntryInfo(icon: Icons.image_outlined, name: 'CmsSingleMediaEntry', blurb: 'One media slot'),
  HomeEntryInfo(icon: Icons.link, name: 'CmsLinkEntry', blurb: 'Clickable URLs'),
].lock;

/// The delegate / backend packages, shown as the home page's "Backends" card.
/// One `CmsDelegate` abstraction, one package per backend - all on pub.dev.
final IList<HomePackageInfo> kHomeBackends = [
  HomePackageInfo(name: 'utopia_cms', blurb: 'Core: shell, tables, delegates', url: _pubDev('utopia_cms')),
  HomePackageInfo(name: 'utopia_cms_firebase', blurb: 'Firestore delegate', url: _pubDev('utopia_cms_firebase')),
  HomePackageInfo(name: 'utopia_cms_supabase', blurb: 'Supabase delegate', url: _pubDev('utopia_cms_supabase')),
  HomePackageInfo(name: 'utopia_cms_hasura', blurb: 'Hasura delegate', url: _pubDev('utopia_cms_hasura')),
  HomePackageInfo(name: 'utopia_cms_graphql', blurb: 'GraphQL service layer', url: _pubDev('utopia_cms_graphql')),
].lock;
