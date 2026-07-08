## 0.1.0

Initial release.

- **theme**: `CmsTheme` inherited widget, `CmsThemeData` design tokens (colors, text styles, radii, paddings, shadows) with a zero-config `defaultTheme` fallback and `context.theme` / `context.colors` / `context.textStyles` / `context.fieldDecoration` lookups.
- **primitives**: `CmsButton`, `CmsRemoveIconButton`, `CmsChip`, `CmsChipList`, `CmsCheckRow`, `CmsSwitch`, `CmsSwitchField`, `CmsTextField`, `CmsSearchField`, `CmsFieldWrapper`, `CmsLabeledField`, `CmsDropdownField`, `CmsOverlayAnchor`, `CmsDatePicker`, `CmsLoader`, `CmsMockLoadingBox`, `CmsThreeBounce`, `CmsDivider`, `CmsCard`, `CmsGradientBackground`, `CmsTitle`, `CmsCopyableText`, `CmsBreakpoints`, `CmsPageWrapper`.
- **table**: `CmsTable<T>`, typed `CmsTableEntry<T>` columns (flex or fixed width) with controlled sorting, `CmsTableSearchPanel`, `CmsTableEmpty`, and the `useCmsTableState` client-side search/sort hook.
- **dialog**: `CmsDialog` (raw and `.form`) and `CmsConfirmDialog`, both adaptive full-screen/card chrome that re-attach the ambient theme across route boundaries.
- **sidebar**: `CmsSidebar` with rail and drawer presentations, and the `CmsSidebarDestination` / `CmsSidebarAction` / `CmsSidebarCustom` item model.
