<img src="docs/header.png" width="240" alt="Utopia CMS UI"/>

[![pub][pub_badge]][pub_link] [![publisher][publisher_badge]][publisher_link] [![license][license_badge]][license_link] [![style: utopia\_lints][style_badge]][style_link]

# utopia_cms_ui

The design system underlying [utopia_cms](https://pub.dev/packages/utopia_cms): a themeable, general-purpose
set of Flutter components for building admin-panel-quality UI - tables, dialogs, a navigation sidebar and the
form primitives they're built from.

`utopia_cms_ui` is data-shape agnostic and has no CMS dependency. It doesn't know what a `JsonMap` is, doesn't
assume a delegate or a backend, and doesn't ship any CRUD logic - every component is generic over your own
model types and driven by plain values and callbacks. If your project needs "an admin-panel-quality table /
button / dialog" but has its own models, its own data layer and its own brand, you can adopt this package
without forking it.

## Install

```
flutter pub add utopia_cms_ui
```

or add it to `pubspec.yaml` directly:

```yaml
dependencies:
  utopia_cms_ui: ^0.1.0
```

## 60-second start

Wrap your app (or just the subtree that needs it) in a `CmsTheme`, then use any component from the barrel
import - everything renders correctly even without a `CmsTheme` ancestor, but wrapping one is how you brand it.

```dart
import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CmsTheme(
        data: CmsThemeData.defaultTheme,
        child: Scaffold(
          body: Center(
            child: CmsButton(
              onTap: () {},
              child: const Text('Get started'),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Theming

Every visual constant a component reads - colors, text styles, radii, paddings, shadows - comes from one token
root: `CmsThemeData`. Components never hardcode a color or a font; if you need a new visual constant, it's
added to `CmsThemeData`, never inlined into a widget.

`CmsThemeData` (a freezed class) is a flat set of fields - no per-component theme objects in v1:

| Field | Type | Notes |
|---|---|---|
| `colors` | `CmsThemeColors` | its own freezed token class - `primary`, `text`, `surface`, `border`, `hover`, `hint`, ... |
| `textStyles` | `CmsThemeTextStyles` | its own freezed token class of `TextStyle`s (`header`, `title`, `text`, `label`, `button`, `caption`) |
| `borderRadius` | `BorderRadius` | default corner radius (buttons, fields) |
| `fieldContentPadding` | `EdgeInsets` | padding inside a field's content area |
| `pageTopPadding` | `double` | top inset used by pages and dialogs |
| `menuShadow` / `menuRadius` | `List<BoxShadow>` / `BorderRadius` | popup/dropdown chrome |
| `shortButtonWidth` | `double` | width for compact button layouts |
| `cardRadius` / `cardBorderWidth` / `cardShadow` | - | the table card's corner radius, border stroke and drop shadow |
| `tileHeight` | `double` | height of a single table row |
| `dividerThickness` | `double` | row/header divider stroke width |
| `chipRadius` | `double` | corner radius of a `CmsChip` |

`colors` and `textStyles` are extended as separate token classes because they group naturally; the rest are
flat layout tokens used directly by components (table row height, divider thickness, chip radius, and so on).
Extend `CmsThemeData` itself when a component needs a new visual constant - never inline it into the widget.

**Distribution.** `CmsTheme` is a plain `InheritedWidget`, like `Theme` or `DefaultTextStyle` - no `provider`
dependency:

- `CmsTheme.of(context)` returns the closest ancestor's `CmsThemeData`, silently falling back to
  `CmsThemeData.defaultTheme` when there is none. Every component works zero-config.
- `CmsTheme.maybeOf(context)` returns `null` instead of falling back, for callers that need to tell the two
  cases apart.

**Ergonomic lookups** are context extensions, backed by `CmsTheme.of`:

```dart
context.theme;           // CmsThemeData
context.colors;          // CmsThemeColors
context.textStyles;      // CmsThemeTextStyles
context.fieldDecoration; // BoxDecoration for a field's background
```

To rebrand an app, construct your own `CmsThemeData` (typically as `CmsThemeData.defaultTheme.copyWith(...)`)
and pass it to a `CmsTheme` at the root - every descendant re-themes automatically.

## The table

`CmsTable<T>` is a general-purpose, data-shape-agnostic table generic over a row type `T` of your choosing. It
is fully controlled: you pass rows, sort state and callbacks, and it renders and reports interaction - it never
owns app state itself. It's also sliver-first, so it composes into a `CustomScrollView` alongside your page's
other content rather than requiring its own scroll view.

Columns are declared as `CmsTableEntry<T>`:

```dart
CmsTableEntry<T>({
  required Widget Function(BuildContext, T) cellBuilder,
  String? id,             // falls back to `title` via `effectiveId`
  String? title,
  int? flex = 2,          // flexes like Expanded.flex
  Comparable<Object?>? Function(T)? sortBy,   // enables toggle-sort
  String? Function(T)? searchBy,              // enables client-side search
  List<CmsTableSortOption<T>>? sortOptions,   // named-orderings dropdown instead of a toggle
})

CmsTableEntry<T>.fixed({
  required Widget Function(BuildContext, T) cellBuilder,
  required double width,  // fixed instead of flexing
  // ... same optional fields as above
})
```

Sorting is controlled: `CmsTable.currentSort` (a `({String columnId, bool descending})` record) says which
column is active, and `onSortPressed` / `onSortSelected` report taps back to you. If you don't need
server-side sorting or search, the `useCmsTableState` hook gives you both for free, entirely client-side:

```dart
final tableState = useCmsTableState<TeamMember>(rows: members, entries: entries);

CmsTable<TeamMember>(
  rows: tableState.visibleRows,      // search-filtered, then sorted
  entries: entries,
  rowKey: (row) => row.name,
  currentSort: tableState.currentSort,
  onSortPressed: tableState.onSortPressed,
  onSortSelected: tableState.onSortSelected,
  searchPanel: CmsTableSearchPanel(
    searchField: CmsSearchField(
      value: tableState.searchState.value,
      hint: 'Search by name or role',
      onChanged: (value) => tableState.searchState.value = value ?? '',
    ),
  ),
)
```

`rows: null` renders a skeleton loader that mirrors the real row layout; an empty (non-null) list renders
`emptyWidget` (or `CmsTableEmpty` / a themed default "No items" message). Rows are matched across rebuilds by
`rowKey`, so reordering or inserting rows doesn't tear down unrelated row state.

Because it's a sliver, `CmsTable` is placed inside a `CustomScrollView`:

```dart
CustomScrollView(
  slivers: [
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      sliver: CmsTable<TeamMember>(
        rows: tableState.visibleRows,
        entries: entries,
        rowKey: (row) => row.name,
        currentSort: tableState.currentSort,
        onSortPressed: tableState.onSortPressed,
      ),
    ),
  ],
)
```

## Dialogs

`CmsDialog` is adaptive dialog chrome: a full-screen surface on mobile widths, a centered rounded card
everywhere else - it resolves its own size class internally, so it works from any call site.

- **`CmsDialog(title:, builder:)`** - the raw constructor, full control of the body below the title row.
- **`CmsDialog.form(title:, sliver:, bottom:)`** - the common case: a scrollable sliver of fields with a
  pinned bottom action bar.
- **`CmsConfirmDialog`** - a neutral confirm/cancel prefab (no baked-in copy; you supply your own strings).

```dart
CmsButton(
  onTap: () => CmsDialog.show<void>(context, builder: (_) => const EditProfileDialog()),
  child: const Text('Edit profile'),
);

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog();

  @override
  Widget build(BuildContext context) {
    return CmsDialog.form(
      title: const Text('Edit profile'),
      sliver: SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        sliver: SliverList.list(
          children: [
            CmsTextField(value: 'Ava Chen', label: const Text('Name'), onChanged: (_) {}),
            const SizedBox(height: 14),
            CmsSwitchField(value: true, title: 'Active', onChanged: (_) {}),
          ],
        ),
      ),
      bottom: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: CmsButton(onTap: () => Navigator.of(context).maybePop(), child: const Text('Done')),
      ),
    );
  }
}
```

A confirm prompt is a one-liner:

```dart
final confirmed = await CmsConfirmDialog.show(
  context,
  title: 'Remove member?',
  subtitle: 'This cannot be undone.',
  confirmLabel: 'Remove',
);
```

**Theme re-attachment.** `CmsDialog.show` and `CmsConfirmDialog.show` are thin wrappers over vanilla
`showDialog` - the only navigation opinion they take is capturing `CmsTheme.of(context)` before pushing the
route and re-wrapping the pushed builder in a `CmsTheme` with that data. This matters because `showDialog`
roots its route at the app `Navigator`, outside of any `CmsTheme` ancestor in your widget tree - without the
re-attachment, the dialog subtree would silently fall back to `CmsThemeData.defaultTheme` instead of inheriting
whatever theme is scoped around the call site. If you push a dialog through some other route mechanism, do the
same: capture `CmsTheme.of(context)` and wrap your builder's result in a `CmsTheme` with it.

## Sidebar

`CmsSidebar` is an adaptive navigation sidebar: a collapsible hover/pin rail on wide screens, a flush full-width
drawer body on small screens. It carries no data-layer or navigation opinions - it never pushes routes and
never closes its own drawer; "selected" means nothing more than `selectedId` matching a destination's `id`.

Items are one of three kinds:

```dart
CmsSidebarDestination(id: 'home', icon: const Icon(Icons.home_outlined), label: const Text('Home'));
CmsSidebarAction(icon: const Icon(Icons.logout), label: const Text('Sign out'), onPressed: signOut);
CmsSidebarCustom(builder: (context) => const Divider());
```

```dart
CmsSidebar(
  selectedId: selectedId,
  presentation: isWide ? CmsSidebarPresentation.rail : CmsSidebarPresentation.drawer,
  onDestinationPressed: (destination) => onSelect(destination.id),
  items: [
    CmsSidebarDestination(id: 'home', icon: const Icon(Icons.home_outlined), label: const Text('Home')),
    CmsSidebarDestination(id: 'settings', icon: const Icon(Icons.settings_outlined), label: const Text('Settings')),
    CmsSidebarAction(icon: const Icon(Icons.logout), label: const Text('Sign out'), onPressed: signOut),
  ],
)
```

`presentation` chooses `rail` (default: collapsed by default, peeks open on hover, pins open via the top toggle
icon) or `drawer` (always full and flush - host it in your own `Scaffold.drawer` and close it yourself after a
tap). `style` (`CmsSidebarStyle`) is opt-in branding: a `backgroundColors` gradient and a `headerBuilder` for a
logo pinned above the items; leaving both unset renders a plain surface card matching the content card.

**Pinning items to the bottom.** The sidebar's body sizes itself to the larger of the viewport and its content,
which means `Expanded` / `Spacer` items are supported as direct entries and will consume the free space left
when the items above are shorter than the viewport - the way to push trailing items (e.g. "Sign out", a version
label) down to the sidebar's bottom edge is a `CmsSidebarCustom` spacer between the two groups:

```dart
items: [
  CmsSidebarDestination(id: 'home', icon: const Icon(Icons.home_outlined), label: const Text('Home')),
  CmsSidebarDestination(id: 'settings', icon: const Icon(Icons.settings_outlined), label: const Text('Settings')),
  const CmsSidebarCustom(builder: _buildSpacer),
  CmsSidebarAction(icon: const Icon(Icons.logout), label: const Text('Sign out'), onPressed: signOut),
],

// top-level function or static method
Widget _buildSpacer(BuildContext context) => const Spacer();
```

A `CmsSidebarCustom` builder is safe to build with a `LayoutBuilder` (the body deliberately avoids
`IntrinsicHeight`, which cannot be computed through one) - useful for custom entries that need their own
constraints-aware layout.

## Component index

Everything below is exported from the single barrel, `package:utopia_cms_ui/utopia_cms_ui.dart` - there are no
per-family barrels and no deep imports into `src/`.

**Theme**
`CmsTheme`, `CmsThemeData`, `CmsThemeColors`, `CmsThemeTextStyles`, and the `context.theme` / `context.colors` /
`context.textStyles` / `context.fieldDecoration` extensions.

**Buttons**
`CmsButton` - the primary call-to-action button, with an inline loading state.
`CmsRemoveIconButton` - a small "x" affordance to remove/clear a value.

**Chips**
`CmsChip`, `CmsChipList` - themed tags, with overflow collapsing on `CmsChipList`.

**Fields**
`CmsTextField`, `CmsSearchField`, `CmsDropdownField`, `CmsSwitch`, `CmsSwitchField`, `CmsCheckRow`,
`CmsDatePicker`, `CmsFieldWrapper` (shared field chrome), `CmsLabeledField` (read-only, "picked value" field
chrome used by dropdowns).

**Dialogs**
`CmsDialog` (raw and `.form`), `CmsConfirmDialog`.

**Sidebar**
`CmsSidebar`, `CmsSidebarDestination`, `CmsSidebarAction`, `CmsSidebarCustom`, `CmsSidebarStyle`,
`CmsSidebarPresentation`.

**Table**
`CmsTable<T>`, `CmsTableEntry<T>`, `CmsTableSort`, `CmsTableSortOption<T>`, `CmsTableSearchPanel`,
`CmsTableEmpty`, `CmsTableState<T>` / `useCmsTableState`.

**Layout**
`CmsBreakpoints`, `CmsPageWrapper`, `CmsPageType`, `CmsCard`, `CmsDivider`, `CmsGradientBackground`.

**Loading**
`CmsLoader`, `CmsMockLoadingBox` (skeleton placeholder), `CmsThreeBounce` (the indicator inside `CmsButton`).

**Overlay**
`CmsOverlayAnchor` - an anchored popup/dropdown follower built on native Flutter, no extra dependency.

**Text**
`CmsTitle`, `CmsCopyableText` (tap-to-copy text with a confirmation).

**Utilities**
`CmsDateTimeExtension` - `DateTime` display-formatting and calendar arithmetic used by `CmsDatePicker`. Plus
`IList` / `FicIterableExtension` (from `fast_immutable_collections`), re-exported since they appear in this
package's own public API (`CmsTable.rows`, entry lists, `useCmsTableState`).

## Relationship to utopia_cms

`utopia_cms_ui` is the presentational layer only: components take values and callbacks, never a data source.
[`utopia_cms`](https://pub.dev/packages/utopia_cms) (core) is its first consumer - it contributes everything
data-shaped on top: `CmsDelegate` and backend integrations, the `CmsEntry` catalog, filters, to-many
relationships, and the `CmsTablePage` / `CmsWidget` CRUD orchestration that turns these components into a full
admin panel. Any project that only needs the components - its own models, its own data layer, its own brand -
can depend on `utopia_cms_ui` alone.

## Related packages

| Package | What it adds |
|---|---|
| [utopia_cms](https://pub.dev/packages/utopia_cms) | The CMS framework built on these components: delegates, entries, CRUD flows |
| [utopia_hooks](https://pub.dev/packages/utopia_hooks) | State management with hooks |
| [utopia_widgets](https://pub.dev/packages/utopia_widgets) | Layout primitives this package builds on |

Built by [Utopiasoft](https://utopiasoft.io).

## Contributing

👾 Contributions are welcome - open an issue to discuss a change, or send a pull request.

## License

BSD-3-Clause. See [LICENSE](LICENSE).

[pub_badge]: https://img.shields.io/pub/v/utopia_cms_ui.svg?logo=dart
[pub_link]: https://pub.dev/packages/utopia_cms_ui
[publisher_badge]: https://img.shields.io/pub/publisher/utopia_cms_ui.svg?color=7A4FC2
[publisher_link]: https://pub.dev/publishers/utopiasoft.io
[license_badge]: https://img.shields.io/badge/license-BSD--3--Clause-2E8B57.svg
[license_link]: LICENSE
[style_badge]: https://img.shields.io/badge/style-utopia__lints-0B5EA2.svg
[style_link]: https://pub.dev/packages/utopia_lints
