# utopia_cms_ui - design charter

The design system underlying utopia_cms: general-purpose, CMS-logic-free Flutter components.
This document is normative for every component added to this package. Deviations require
updating this charter first.

## Purpose & scope

`utopia_cms_ui` contains the presentational layer of the utopia_cms ecosystem as a standalone
design system, usable by any Flutter app - with or without the CMS. `utopia_cms` (core) is its
first consumer: core contributes data binding, delegates and CRUD orchestration on top.

Litmus test for every public API here: *a project that needs "an admin-panel-quality table /
button / dialog" but has its own models, its own data layer and its own brand must be able to
adopt this component without forking it.* Concretely that means: no assumptions about where data
comes from, what shape rows have, or what the app looks like.

## Naming

- Every public top-level type carries the `Cms` prefix, without exception: widgets (`CmsButton`),
  data/config classes (`CmsTableEntry`), enums (`CmsButtonVariant`, not `ButtonType`), typedefs.
  100% coverage is a review gate, not an aspiration.
- Hooks are `useCmsX` (`useCmsTableState`). Extensions are `CmsXExtensions`.
- Files are `snake_case` matching the primary type (`cms_button.dart` -> `CmsButton`).
- Named constructors express structural variants (`CmsTableEntry.fixed`, `CmsDialog.form`);
  enum params express visual variants (`variant:`, `size:`). Escape hatches are `.raw`.

## Package layout & exports

```
lib/
  utopia_cms_ui.dart          # THE barrel - the only supported import
  src/
    theme/                    # CmsTheme widget + token classes
    widget/<family>/          # one folder per component family (button, chip, table, ...)
    util/                     # internal helpers, context extensions
```

- Single barrel: consumers import `package:utopia_cms_ui/utopia_cms_ui.dart`, nothing else.
  Everything under `src/` is private unless exported by the barrel. No per-family barrels,
  no deep imports, no `export` statements embedded in component files.
- Doc comment required on every exported declaration (what it is + one usage hint).

## Theming

- Tokens: `CmsThemeData` (freezed) = `CmsThemeColors` + `CmsThemeTextStyles` + layout tokens
  (radii, paddings, shadows, tile/divider sizing) + computed decoration getters. Flat token
  root, v1 has NO per-component theme objects (revisit only with real demand; see forui/shadcn
  style-delta models for the shape it would take).
- Distribution: `CmsTheme` is a plain `InheritedWidget` (like `Theme`/`DefaultTextStyle`):
  - `CmsTheme.of(context)` -> `CmsThemeData`, silently falling back to
    `CmsThemeData.defaultTheme` when absent (zero-config components; matches current behavior).
  - `CmsTheme.maybeOf(context)` -> nullable, for callers that must distinguish.
  - `updateShouldNotify` compares `data` (freezed equality).
- Ergonomic lookup is the context extension (kept name-compatible with existing code):
  `context.theme`, `context.colors`, `context.textStyles`, `context.fieldDecoration`.
- Components NEVER hardcode colors/text styles/radii - every visual constant comes from the
  token classes. New tokens are added to `CmsThemeData` rather than inlined. (Anti-pattern
  references: static-const color access sprinkled per widget kills rebrandability.)
- Overlay/dialog helpers that push new routes must re-attach the ambient `CmsThemeData`
  captured from the opening context, so subtree-scoped themes survive route boundaries.
- No `provider` dependency; no Material `ThemeExtension` coupling (components must work under
  any `MaterialApp` theme, or none).

## Component API conventions

- Slots: static content is a `Widget` param; dynamic content is a named `xxxBuilder` with
  `BuildContext` first. Prefer builders over inheritance for customization.
- State modeling: presentational widgets take values + callbacks (`currentSort` in,
  `onSortPressed` out). Stateful conveniences ship as optional companion hooks
  (`useCmsTableState`), never baked into the widget. A widget must be usable fully controlled.
- Data-shape agnosticism: generic over row/item type `T` with builder/selector functions.
  `JsonMap`, string key-paths, delegates, and any `utopia_cms` core type are FORBIDDEN here -
  adapters live in core.
- Loading/disabled are modeled explicitly where the CMS needs them (`loading:` on `CmsButton`)
  even though external design systems avoid it - this is an app-oriented system, pragmatism wins.
- Slivers: scrollable composites are sliver-first (`CmsTable` is a sliver; pages compose it in
  a `CustomScrollView`). Use Flutter built-ins (`SliverMainAxisGroup`, `PinnedHeaderSliver`,
  `OverlayPortal`) - no sliver_tools, no flutter_portal.
- Responsiveness rides on one system: `CmsBreakpoints` + `CmsPageWrapper`/`CmsPageType`,
  consumed by pages AND dialogs alike.

## Dependency policy

Allowed: `flutter`, `utopia_hooks`, `utopia_widgets`, `utopia_collections`,
`fast_immutable_collections`, `shimmer`, `freezed_annotation`, `intl` (+ dev: freezed, build_runner,
utopia_lints). `intl` was added in phase 2 for the date-display formatting extension moved from
core alongside the date picker - pure Dart, web-safe, no `dart:io`.
Forbidden (with reasons, learned the hard way):
- `utopia_arch` - transitively pulls a `dart:io` logger and breaks web (precedent: core's
  foundation.dart dropped it for exactly this).
- `provider` - replaced by `CmsTheme` InheritedWidget.
- `flutter_portal`, `sliver_tools` - superseded by Flutter built-ins.
- Anything with platform-heavy native code (media/video/pickers) - those components stay in core.
Adding any dependency requires a charter update with rationale.

## Coupling rules (hard boundaries)

- This package must never import `utopia_cms` core (enforced by the package boundary; reviewers
  additionally check that no core types get copied in to smuggle coupling).
- No navigation opinions: components may push nothing by themselves except self-contained
  overlays (`OverlayPortal`); `show...` helpers are thin wrappers over vanilla `showDialog`.
- No I/O, no persistence, no network, no `dart:io`.

## Quality gates (every phase close)

1. `melos run analyze` clean; utopia_lints; public-API dartdoc coverage.
2. Example app compiles and behaves identically (headless-Chrome screenshot comparison for
   visual-parity phases).
3. Prefix/naming/barrel conformance sweep.
4. No client-project references anywhere in code, comments, docs or commits (public repo).
5. Charter conformance review recorded in the plan ledger.

## Component list v1 (frozen for phases 1-4)

- Phase 1 - theme: `CmsTheme`, `CmsThemeData`, `CmsThemeColors`, `CmsThemeTextStyles`.
- Phase 2 - primitives: `CmsButton`, `CmsRemoveIconButton`, `CmsChip`, `CmsChipList`,
  `CmsCheckRow`, `CmsSwitch`, `CmsSwitchField`, `CmsTextField`, `CmsSearchField`,
  `CmsFieldWrapper`, `CmsLabeledField`, `CmsDropdownField`, `CmsOverlayAnchor`, `CmsDatePicker`,
  `CmsLoader`, `CmsMockLoadingBox`, `CmsThreeBounce`, `CmsDivider`, `CmsCard`,
  `CmsGradientBackground`, `CmsTitle`, copyable-text cell (final name decided in phase 2),
  `CmsBreakpoints`, `CmsPageWrapper`, `CmsPageType`.
- Phase 3 - table: `CmsTable`, `CmsTableEntry<T>` (+ sort option type), header/item/cell
  subcomponents, empty/loader slots, `useCmsTableState`.
- Phase 4 - `CmsDialog` (raw + `.form`, confirm/alert prefabs), `CmsSidebar` (rail/drawer,
  generic item model).
- Explicitly NOT in this package: media/video components, country picker, management forms,
  table-page CRUD orchestration, shell/menu-scope machinery, delegates and filter models.
