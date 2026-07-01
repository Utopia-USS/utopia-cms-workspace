<img src="https://raw.githubusercontent.com/Utopia-USS/utopia-cms-workspace/master/packages/core/cms_core.png" width="206" alt="Utopia CMS"/>

[![pub][pub_badge]][pub_link] [![publisher][publisher_badge]][publisher_link] [![license][license_badge]][license_link] [![style: utopia\_lints][style_badge]][style_link]

# Utopia CMS (Core)

Utopia CMS is a Flutter framework for building CMS and admin panels - the back-office dashboards and
internal tools that manage your app's data. It gives you animated, high-performance CRUD screens:
sortable, filterable tables with create / edit / delete flows and per-row actions, backed by Firebase,
Supabase, Hasura or any GraphQL backend.

<img src="https://github.com/Utopia-USS/utopia-cms-workspace/raw/master/packages/core/video.gif" width="100%" alt="Utopia CMS admin panel demo"/>

## Motivation

Creating CMS panels in Flutter can be costly compared to using No-Code/Low-Code solutions. However, we believe that it
is still beneficial for a project as it ensures maintainability and allows for the creation of outstanding UI, which is
often lacking in existing solutions. That's why we have developed this Low-Code library to optimize the process of
creating customizable panels.

## Example

This is a simple example which integrates with GraphQL server and creates complete CMS layout with one page and
management flow.

```dart
class Example extends StatelessWidget {
  final String? pageId;
  final void Function(String pageId) onPageChanged;
  final GraphQLClient client;

  const Example({required this.pageId, required this.onPageChanged, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CmsWidget(
        selectedPageId: MutableValue.delegate(() => pageId ?? 'users', onPageChanged),
        items: [
          CmsWidgetItem.page(
            id: 'products',
            icon: Icon(Icons.shopping_basket_outlined),
            title: Text('Products'),
            content: _buildProductsPage(),
          ),
        ],
      ),
    );
  }

  CmsTablePage _buildProductsPage() {
    return CmsTablePage(
      title: "Products",
      delegate: CmsHasura.delegate(
        client: client,
        table: Tables.products,
        fields: TableFields.products,
        archivedFilter: const CmsFilterNotEquals("archived", true),
      ),
      entries: [
        CmsTextEntry(key: "name", modifier: const CmsEntryModifier(sortable: true)),
        CmsTextEntry(key: "description", flex: 4),
      ],
    );
  }
}
```

## CMS overview & basic features

The utopia_cms_core library provides the following features for creating server-layer, responsive table-based pages,
edit/create flows, and internal navigation. It also supports integration with custom pages and offers a set of helpful
widgets to maintain a coherent theme in your application.

### CmsWidget

Wraps whole application and creates a proper paging behavior using a built-in navigation menu.

### Responsiveness

The panel is responsive down to phone widths via `CmsBreakpoints`. Below 900px the sidebar collapses into a
drawer (opened by a burger next to the page title); at or above it, it stays an in-layout rail. Independently,
each page resolves a `CmsPageType` (mobile / tablet / web) from the width it actually receives, tuning table
layout, form column nesting and paddings - and opening create / edit full-screen on mobile.

### CmsThemeData

Modifies the styling of the Widgets, determines fonts and colors.

### CmsTablePage

This is a standalone widget for table-based content management. By default, it displays a sortable and filterable table,
introduces infinite-scroll paging (30 items per page by default, configurable via `pagingLimit`), creates edit and create subpages, and supports item removal. The data is
provided by `CmsDelegate` and displayed by `CmsEntry`. Requests may be filtered via `CmsFilterEntry`.

### CmsEntry

This interface handles the display and management of data. There is a pre-created set of primitives for interacting with
basic data types.

| Name                                                                                                                   | Description                                     |
|------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| [CmsTextEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsTextEntry-class.html)                     | Handles generic String variables                |
| [CmsNumEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsNumEntry-class.html)                       | Handles numeric variables                       |
| [CmsDropdownEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsDropdownEntry-class.html)             | For managing set of options and singular choice |
| [CmsCountryEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsCountryEntry-class.html)               | Country picker (single selection)               |
| [CmsBoolEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsBoolEntry-class.html)                     | Handles bool variables                          |
| [CmsDateEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsDateEntry-class.html)                     | Handles Date variables                          |
| [CmsLinkEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsLinkEntry-class.html)                     | Handles clickable links (opens via url_launcher) |
| [CmsMediaEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsMediaEntry-class.html)                   | Handles files (img, vid, doc, unknown)          |
| [CmsSingleMediaEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsSingleMediaEntry-class.html)       | Single file (scalar URL, not a list)            |
| [CmsToManyDropdownEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsToManyDropdownEntry-class.html) | M2M relationships multi selection dropdown      |

You can create custom entries by referring to the implementation of any primitive and the
[CmsEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsEntry-class.html)

### CmsEntryModifier

Every `CmsEntry` accepts an optional `modifier` (`CmsEntryModifier`) that tunes how its column and field
behave. `pinned` controls the table column only - the create / edit form always receives every entry - and
pairs with [Responsiveness](#responsiveness) to drop columns on smaller screens.

| Option            | Default          | Effect                                                                                         |
|-------------------|------------------|------------------------------------------------------------------------------------------------|
| `pinned`          | shown everywhere | `CmsPageType` predicate gating the table column (e.g. `(t) => !t.isMobile` hides it on phones) |
| `sortable`        | `false`          | Sort the table by this field (the `CmsDelegate` must support it)                               |
| `sortInvertNulls` | `false`          | Invert ordering of null values (no-op unless `sortable`)                                       |
| `editable`        | `true`           | `false` = read-only in edit, hidden from create (e.g. an `id`)                                 |
| `initializable`   | `true`           | Whether the field appears in the create flow                                                   |
| `required`        | `true`           | Whether a value is required to create / edit                                                   |
| `expanded`        | `false`          | Render the field on its own full-width row in the form                                         |

### CmsFilterEntry

This interface handles filtering fields of the table.

| Name                                                                                                               | Description                        |
|--------------------------------------------------------------------------------------------------------------------|------------------------------------|
| [CmsFilterSearchEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsFilterSearchEntry-class.html) | Handles generic String full search |
| [CmsFilterDateEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsFilterDateEntry-class.html)     | Handles date ranges                |

You can create custom entries by referring to the implementation of any primitive and the
[CmsFilterEntry](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsFilterEntry-class.html)

### CmsFilter

A composable predicate that describes *which* rows a `CmsDelegate` should return. A `CmsFilterEntry` builds
one from user input (via `filterFromValues`), and you can also pass one directly - like the `archivedFilter`
in the example above - to scope an entire table.

| Constructor                                               | Matches             |
|-----------------------------------------------------------|---------------------|
| `CmsFilter.all()`                                         | everything (no-op)  |
| `CmsFilter.equals(field, value)`                          | `field == value`    |
| `CmsFilter.notEquals(field, value)`                       | `field != value`    |
| `CmsFilter.containsString(field, value, {caseSensitive})` | substring match     |
| `CmsFilter.inList(field, values)`                         | `field` in `values` |
| `CmsFilter.greaterOrEq(field, value)`                     | `field >= value`    |
| `CmsFilter.lesserOrEq(field, value)`                      | `field <= value`    |
| `CmsFilter.and(filters)` / `CmsFilter.or(filters)`        | combine sub-filters |
| `CmsFilter.not(filter)`                                   | negate a filter     |

Filters also compose with operators: `a & b`, `a | b` and `~a`.

### CmsDelegate

This is the main interface for handling `CmsTablePage`. It is not suitable on its own for handling to-many relationships.
To achieve this functionality, refer to [Relationships](#relationships)

The library provides pre-created delegates:

| Name                                                                | Description                          |
|---------------------------------------------------------------------|--------------------------------------|
| [utopia_cms_firebase](https://pub.dev/packages/utopia_cms_firebase) | Firebase delegate integration        |
| [utopia_cms_supabase](https://pub.dev/packages/utopia_cms_supabase) | Supabase delegate integration        |
| [utopia_cms_graphql](https://pub.dev/packages/utopia_cms_graphql)   | Generic GraphQL delegate integration |
| [utopia_cms_hasura](https://pub.dev/packages/utopia_cms_hasura)     | Hasura delegate integration          |

To create your custom delegate, refer to the implementation of any delegate and the
[CmsDelegate](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsDelegate-class.html) interface.

### CmsTableAction

Adds a custom per-row action to the row's pop-up menu, alongside the auto-generated edit / delete. Provide a
list via `CmsTablePage.customActions`. `onPressed` receives the row's `JsonMap`; when `shouldUpdateTable` is
`true` and it returns a non-null map, that row is refreshed in place.

```dart
CmsTableAction(
  label: 'Copy flutter pub add',
  shouldUpdateTable: false,
  onPressed: (row) async {
    await Clipboard.setData(ClipboardData(text: 'flutter pub add ${row['name']}'));
    return null;
  },
)
```

### CmsManagementSectionEntry

Injects a custom section (a sliver) into the generated create / edit form, beyond the auto-built entry fields.
Provide a list via `CmsTablePage.managementSectionEntries`. Each section chooses whether it shows on edit and
/ or create (`showEdit` / `showCreate`) and builds its body from the current `JsonMap`. This is the usual
place to render to-many relationship editors (see [Relationships](#relationships)).

```dart
CmsManagementSectionEntry(
  title: 'Tags',
  showCreate: true,
  sliverBuilder: (value, isEdit) => SliverToBoxAdapter(child: TagsEditor(item: value)),
)
```

## Relationships

Handling relation-based entries in the system is slightly more complex. For a particular entry, you need to use
the [CmsToManyDelegate](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsToManyDelegate-class.html)
and register additional callbacks to `CmsManagementBaseState` that is available via `Provider`

```dart
final baseState = Provider.of<CmsManagementBaseState>(context);

baseState.addOnSavedCallback(
    (value) async {
        return delegate.update(...);
    }
);
```

The library provides the following existing solutions for relationships:

| Existing `CmsToManyDelegate` implementations                | Source                                                          |
|-------------------------------------------------------------|-----------------------------------------------------------------|
| `CmsHasuraOneToManyDelegate`, `CmsHasuraManyToManyDelegate` | [utopia_cms_hasura](https://pub.dev/packages/utopia_cms_hasura) |

## Media

Media such as images or videos are
handled by [CmsMediaDelegate](https://pub.dev/documentation/utopia_cms/latest/utopia_cms/CmsMediaDelegate-class.html)
which introduces upload and delete functions.

The library provides no existing generic solutions for relationships yet, but here's an example

```dart
class FileDelegate implements CmsMediaDelegate {
  final CmsGraphQLService graphQLService;
  final GraphQLClient client;

  const FileDelegate(this.graphQLService, this.client);

  Future<CmsMediaUploadRes> upload(XFile file) async {
    final (uploadUrl, downloadUrl) = await _createAttachment(mimeType: file.mimeType!);
    await _upload(uploadUrl, file);
    return CmsMediaUploadRes(downloadUrl: downloadUrl, ref: "XD");
  }

  Future<(String, String)> _createAttachment({required String mimeType}) async {
    final result = await graphQLService.mutate(
      client,
      name: 'createAttachment',
      arguments: {'data': {'contentType': mimeType}.toValueNodeUnsafe()},
      fields: {CmsGraphQLField('uploadUrl'), CmsGraphQLField('downloadUrl')},
    );
    result as Map<String, dynamic>;
    return (result['uploadUrl'] as String, result['downloadUrl'] as String);
  }

  Future<void> _upload(String url, XFile file) async {
    final webFile = await HttpRequest.request(file.path, responseType: 'blob');
    final request = await HttpRequest.request(url, method: 'PUT', mimeType: file.mimeType!, sendData: webFile.response);
    if(request.status != HttpStatus.ok) throw Exception("Failed to upload");
  }
}
```

## Widgets

The package exports its basic UI components in order to allow maintaining a coherent theme in your custom pages.

* **CmsFieldWrapper**
* **CmsTextField**
* **CmsDropdownField**
* **CmsDatePicker**
* **CmsCountryField**
* **CmsSwitch**
* **CmsMediaField**
* **CmsButton**
* **CmsChip**
* **CmsChipList**
* **CmsCard**
* **CmsDivider**
* **CmsPageWrapper**
* **CmsHeader**
* **CmsVideoPlayer**
* **CmsLoader**
* **CmsMockLoadingBox**

## AI assistants

This package ships agent rules and a skill - the CmsWidget shell, CmsTablePage,
delegates (Firebase/Supabase/Hasura/GraphQL), the entry catalog, filters, and
custom actions - that work with any agentic coding tool (Claude, Codex, Cursor,
and others) via `AGENTS.md` and the
[Utopia skills marketplace](https://github.com/Utopia-USS/utopia-flutter-skills).
Add them with `utopia init agents` / `utopia init skills`.

## Related packages

| Package | What it adds |
|---|---|
| [utopia_hooks](https://pub.dev/packages/utopia_hooks) | State management with hooks |
| [utopia_arch](https://pub.dev/packages/utopia_arch) | The full architecture bundle |
| [utopia_cms_firebase](https://pub.dev/packages/utopia_cms_firebase) | Firebase delegate |
| [utopia_cms_supabase](https://pub.dev/packages/utopia_cms_supabase) | Supabase delegate |
| [utopia_cms_hasura](https://pub.dev/packages/utopia_cms_hasura) | Hasura delegate |

Built by [Utopiasoft](https://utopiasoft.io).

## Contributing

👾 Contributions are welcome - open an issue to discuss a change, or send a pull request.

## License

BSD-3-Clause. See [LICENSE](LICENSE).

[pub_badge]: https://img.shields.io/pub/v/utopia_cms.svg?logo=dart
[pub_link]: https://pub.dev/packages/utopia_cms
[publisher_badge]: https://img.shields.io/pub/publisher/utopia_cms.svg?color=7A4FC2
[publisher_link]: https://pub.dev/publishers/utopiasoft.io
[license_badge]: https://img.shields.io/badge/license-BSD--3--Clause-2E8B57.svg
[license_link]: LICENSE
[style_badge]: https://img.shields.io/badge/style-utopia__lints-0B5EA2.svg
[style_link]: https://pub.dev/packages/utopia_lints
