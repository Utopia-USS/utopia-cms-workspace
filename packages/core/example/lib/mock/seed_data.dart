import 'package:utopia_cms/utopia_cms.dart';

import 'mock_delegate.dart';
import 'mock_to_many_delegate.dart';

/// Closed-set values for the Libs "layer" dropdown - the layers actually present
/// in the catalogue below.
const List<String> kLayers = ['CMS', 'State', 'Arch', 'UI', 'Net', 'i18n', 'CLI'];

/// Session-scoped delegates - module level so in-memory state survives menu
/// navigation for the whole session.
final MockDelegate libsDelegate = MockDelegate(_libsSeed, idPrefix: 'lib');
final MockDelegate skillsDelegate = MockDelegate(_skillsSeed, idPrefix: 'skill');

/// Backs the Libs "Tags" column - a to-many relation rendered as a chip list.
final MockToManyDelegate tagsDelegate = MockToManyDelegate(tags: _tags, relations: _libTags);

JsonMap _tag(String id, String name) => {'id': id, 'name': name};

/// The fixed tag catalogue (the "foreign" side of the to-many relation).
final List<JsonMap> _tags = [
  _tag('state', 'State'),
  _tag('arch', 'Arch'),
  _tag('di', 'DI'),
  _tag('net', 'Net'),
  _tag('i18n', 'i18n'),
  _tag('utils', 'Utils'),
  _tag('cms', 'CMS'),
  _tag('hooks', 'Hooks'),
  _tag('widgets', 'Widgets'),
  _tag('reactive', 'Reactive'),
  _tag('async', 'Async'),
  _tag('forms', 'Forms'),
  _tag('codegen', 'Codegen'),
  _tag('admin', 'Admin'),
  _tag('crud', 'CRUD'),
  _tag('firebase', 'Firebase'),
  _tag('hasura', 'Hasura'),
  _tag('graphql', 'GraphQL'),
  _tag('cli', 'CLI'),
  _tag('scaffold', 'Scaffold'),
];

/// Which tags each lib carries. Some have > 6 to show the "+N more" overflow.
const Map<String, Set<String>> _libTags = {
  'lib_cms': {'cms', 'admin', 'crud', 'widgets', 'forms', 'state'},
  'lib_cms_firebase': {'cms', 'admin', 'firebase'},
  'lib_cms_hasura': {'cms', 'admin', 'hasura', 'graphql'},
  'lib_cms_graphql': {'cms', 'admin', 'graphql', 'net'},
  'lib_hooks': {'state', 'hooks', 'reactive', 'async', 'forms', 'widgets', 'utils', 'di'},
  'lib_hooks_riverpod': {'hooks', 'state', 'reactive', 'di'},
  'lib_cli': {'cli', 'scaffold', 'arch'},
  'lib_localization': {'i18n', 'codegen', 'utils'},
  'lib_arch': {'arch', 'hooks', 'widgets', 'state', 'di', 'forms', 'utils'},
  'lib_widgets': {'widgets', 'utils'},
  'lib_connectivity': {'net', 'reactive', 'async', 'utils'},
};

Map<String, dynamic> _link(String name) => {'name': name, 'url': 'https://pub.dev/packages/$name'};

/// GitHub source link. [path] is everything after the `Utopia-USS/` org - a
/// standalone repo (`utopia_cms`, `utopia-cli`) or a `<repo>/tree/master/packages/<dir>`
/// path into one of the monorepos (`utopia-flutter`, `utopia_cms`).
Map<String, dynamic> _github(String path) => {'name': 'GitHub', 'url': 'https://github.com/Utopia-USS/$path'};

/// Real Utopia packages (publisher utopiasoft.io). Descriptions are polished
/// from the real pubspec descriptions; `usedHere` flags the packages this very
/// showcase is built on (utopia_cms for the panel, utopia_hooks for its state).
///
/// Order: the CMS family first (the star of this showcase), then the hooks it
/// runs on and its Riverpod-interop sister, the scaffolding CLI, the localization
/// generator, the umbrella architecture package, its widget library and the
/// connectivity helper.
final List<JsonMap> _libsSeed = [
  {
    'id': 'lib_cms',
    'animal': 'fox',
    'link': _link('utopia_cms'),
    'github': _github('utopia_cms'),
    'layer': 'CMS',
    'description': 'This very panel. Low-code admin and CRUD straight onto your backend.',
    'usedHere': true,
  },
  {
    'id': 'lib_cms_firebase',
    'animal': 'whale',
    'link': _link('utopia_cms_firebase'),
    'github': _github('utopia_cms/tree/master/packages/firebase'),
    'layer': 'CMS',
    'description': 'Points the CMS at Firestore - your collections become editable tables.',
    'usedHere': false,
  },
  {
    'id': 'lib_cms_hasura',
    'animal': 'owl',
    'link': _link('utopia_cms_hasura'),
    'github': _github('utopia_cms/tree/master/packages/hasura'),
    'layer': 'CMS',
    'description': 'Wires the CMS to Hasura - GraphQL tables with sort and filters for free.',
    'usedHere': false,
  },
  {
    'id': 'lib_cms_graphql',
    'animal': 'cat',
    'link': _link('utopia_cms_graphql'),
    'github': _github('utopia_cms/tree/master/packages/graphql'),
    'layer': 'CMS',
    'description': 'The GraphQL service layer for rolling your own CMS delegate by hand.',
    'usedHere': false,
  },
  {
    'id': 'lib_hooks',
    'animal': 'octopus',
    'link': _link('utopia_hooks'),
    'github': _github('utopia-flutter/tree/master/packages/hooks'),
    'layer': 'State',
    'description': 'State like React Hooks, but for Flutter. No StatefulWidget in sight.',
    'usedHere': true,
  },
  {
    'id': 'lib_hooks_riverpod',
    'animal': 'jellyfish',
    'link': _link('utopia_hooks_riverpod'),
    'github': _github('utopia-flutter/tree/master/packages/hooks_riverpod'),
    'layer': 'State',
    'description': 'Riverpod interop for utopia_hooks - read and watch providers from inside a hook.',
    'usedHere': false,
  },
  {
    // Not on pub.dev yet (0.2.0-dev), so the "Package" link points at GitHub too.
    'id': 'lib_cli',
    'animal': 'bee',
    'link': {'name': 'utopia_cli', 'url': 'https://github.com/Utopia-USS/utopia-cli'},
    'github': _github('utopia-cli'),
    'layer': 'CLI',
    'description': 'Scaffolds a whole Utopia app from the terminal - Screen/State/View and Claude skills included.',
    'usedHere': false,
  },
  {
    'id': 'lib_localization',
    'animal': 'frog',
    'link': _link('utopia_localization_generator'),
    'github': _github('utopia-flutter/tree/master/packages/localization/generator'),
    'layer': 'i18n',
    'description': 'i18n straight from Google Sheets - the translations generate themselves.',
    'usedHere': false,
  },
  {
    'id': 'lib_arch',
    'animal': 'penguin',
    'link': _link('utopia_arch'),
    'github': _github('utopia-flutter/tree/master/packages/arch'),
    'layer': 'Arch',
    'description': 'A whole app skeleton: hooks, widgets, reporter and validation, batteries included.',
    'usedHere': false,
  },
  {
    'id': 'lib_widgets',
    'animal': 'rabbit',
    'link': _link('utopia_widgets'),
    'github': _github('utopia-flutter/tree/master/packages/widgets'),
    'layer': 'UI',
    'description': 'The generic widgets you would otherwise rewrite in every project - packaged once.',
    'usedHere': false,
  },
  {
    'id': 'lib_connectivity',
    'animal': 'ladybug',
    'link': _link('utopia_connectivity'),
    'github': _github('utopia-flutter/tree/master/packages/connectivity'),
    'layer': 'Net',
    'description': 'Reactive online/offline state - know the moment the network drops.',
    'usedHere': false,
  },
];

final List<JsonMap> _skillsSeed = [
  {
    'id': 'skill_hooks',
    'animal': 'octopus',
    'link': {'name': 'utopia-hooks', 'url': 'https://github.com/Utopia-USS/utopia-flutter-skills'},
    'description': 'Flutter state, done right: Screen/State/View, the hook catalog, async and pagination.',
    'refs': 14,
  },
  {
    'id': 'skill_cms',
    'animal': 'fox',
    'link': {'name': 'utopia-cms', 'url': 'https://github.com/Utopia-USS/utopia-flutter-skills'},
    'description': 'Build admin/CMS panels on utopia_cms - shell, tables, delegates and entries.',
    'refs': 11,
  },
  {
    'id': 'skill_aiarch',
    'animal': 'penguin',
    'link': {'name': 'utopia-ai-arch', 'url': 'https://github.com/Utopia-USS/utopia-flutter-skills'},
    'description': 'The .claude/ layer: agents, skills and hooks that enforce your project conventions.',
    'refs': 8,
  },
  {
    'id': 'skill_migrate',
    'animal': 'bee',
    'link': {'name': 'migrate-bloc-to-utopia-hooks', 'url': 'https://github.com/Utopia-USS/utopia-flutter-skills'},
    'description': 'Migrate BLoC/Cubit to utopia_hooks, wave by wave, with review built in.',
    'refs': 6,
  },
];
