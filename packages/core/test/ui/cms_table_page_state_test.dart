import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/delegate/cms_delegate.dart';
import 'package:utopia_cms/src/model/cms_filter.dart';
import 'package:utopia_cms/src/model/cms_functions_params.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_text_entry.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_filter_entry.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_search_filter_entry.dart';
import 'package:utopia_cms/src/model/table/cms_table_page_params.dart';
import 'package:utopia_cms/src/ui/table_page/state/cms_table_page_state.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms/src/util/json_map.dart';

class _FakeBuildContext extends Fake implements BuildContext {}

class _FakeNavigatorState extends Fake implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => 'FakeNavigatorState';
}

typedef _GetCall = ({CmsFunctionsSortingParams? sorting, CmsFilter filter, CmsFunctionsPagingParams paging});

class _FakeDelegate implements CmsDelegate {
  _FakeDelegate({required this.getResult});

  @override
  final String idKey = 'id';

  List<JsonMap> Function(CmsFunctionsPagingParams paging) getResult;

  final List<_GetCall> getCalls = [];
  final List<JsonMap> deleted = [];

  @override
  Future<List<JsonMap>> get({
    CmsFunctionsSortingParams? sorting,
    CmsFilter filter = const CmsFilterAll(),
    required CmsFunctionsPagingParams paging,
  }) async {
    getCalls.add((sorting: sorting, filter: filter, paging: paging));
    return getResult(paging);
  }

  @override
  Future<void> delete(JsonMap value) async {
    deleted.add(value);
  }

  @override
  Future<JsonMap> update(JsonMap value, JsonMap oldValue) => throw UnimplementedError();

  @override
  Future<JsonMap> create(JsonMap value) => throw UnimplementedError();
}

SimpleHookContext<CmsTablePageState> _build({
  required _FakeDelegate delegate,
  CmsTableParams params = CmsTableParams.defaultParams,
  IList<CmsFilterEntry<dynamic>> filterEntries = const IList.empty(),
  int? pagingLimit,
  Future<bool?> Function()? confirmDelete,
  IList<CmsEntry<dynamic>>? entries,
}) {
  return SimpleHookContext<CmsTablePageState>(
    () => useCmsTablePageState(
      delegate: delegate,
      params: params,
      navigator: _FakeNavigatorState(),
      entries: entries ?? const IList.empty(),
      filterEntries: filterEntries,
      confirmDelete: confirmDelete ?? () async => null,
      pagingLimit: pagingLimit,
      managementSectionEntries: const [],
    ),
    provided: {BuildContext: _FakeBuildContext()},
  );
}

void main() {
  group('useCmsTablePageState', () {
    test('initial load performs a single get call and disables paging once results are shorter than the page', () async {
      final delegate = _FakeDelegate(getResult: (paging) => [{'id': 1}, {'id': 2}]);
      final context = _build(delegate: delegate, pagingLimit: 10);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.length == 2);

      expect(delegate.getCalls.length, 1);
      expect(delegate.getCalls.single.paging.offset, 0);
      expect(delegate.getCalls.single.paging.limit, 10);
      expect(delegate.getCalls.single.filter, const CmsFilterAll());
      expect(delegate.getCalls.single.sorting, isNull);
      expect(context().pagingEnabled, isFalse);
    });

    test('a full page of results keeps paging enabled and refresh appends the next page', () async {
      final delegate = _FakeDelegate(
        getResult: (paging) => List.generate(3, (i) => {'id': paging.offset + i}),
      );
      final context = _build(delegate: delegate, pagingLimit: 3);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.length == 3);
      expect(context().pagingEnabled, isTrue);

      await context().computedState.refresh();

      expect(delegate.getCalls.length, 2);
      expect(delegate.getCalls[1].paging.offset, 3);
      expect(context().items.map((e) => e['id']).toList(), [0, 1, 2, 3, 4, 5]);
    });

    test('duplicate ids across pages are dropped, but the offset advances by the raw page size', () async {
      var callCount = 0;
      final delegate = _FakeDelegate(
        getResult: (paging) {
          callCount++;
          return switch (callCount) {
            1 => [{'id': 1}, {'id': 2}],
            2 => [{'id': 2}, {'id': 3}],
            _ => <JsonMap>[],
          };
        },
      );
      final context = _build(delegate: delegate, pagingLimit: 2);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.length == 2);

      await context().computedState.refresh();

      // id 2 is shared between both pages: only the unique ids 1, 2, 3 remain.
      expect(context().items.map((e) => e['id']).toList(), [1, 2, 3]);
      expect(delegate.getCalls[1].paging.offset, 2);

      // Page two added only one unique row but was two rows long. The next
      // offset must reflect the raw page length (2 + 2), not the deduplicated
      // item count - otherwise the same page would be refetched forever.
      await context().computedState.refresh();
      expect(delegate.getCalls[2].paging.offset, 4);
    });

    test('pagingLimit null disables paging after the first load and refresh is a no-op', () async {
      final delegate = _FakeDelegate(getResult: (paging) => [{'id': 1}]);
      final context = _build(delegate: delegate);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.length == 1);
      expect(context().pagingEnabled, isFalse);

      await context().computedState.refresh();

      expect(delegate.getCalls.length, 1);
    });

    test('onSortPressed toggles sortDesc on repeated presses and resets on a different entry', () async {
      final nameEntry = CmsTextEntry(key: 'name', modifier: const CmsEntryModifier(sortable: true, sortInvertNulls: true));
      final otherEntry = CmsTextEntry(key: 'other');
      final delegate = _FakeDelegate(getResult: (paging) => [{'id': 1}]);
      final context = _build(delegate: delegate, pagingLimit: 10);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.isNotEmpty);

      context().onSortPressed(nameEntry);
      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(
        context().currentSortingParams,
        const CmsFunctionsSortingParams(fieldKey: 'name', sortDesc: false, invertNulls: true),
      );
      expect(delegate.getCalls.last.sorting, context().currentSortingParams);
      // Sorting resets the paging offset back to 0.
      expect(delegate.getCalls.last.paging.offset, 0);

      context().onSortPressed(nameEntry);
      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(context().currentSortingParams?.fieldKey, 'name');
      expect(context().currentSortingParams?.sortDesc, isTrue);

      context().onSortPressed(nameEntry);
      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(context().currentSortingParams?.sortDesc, isFalse);

      context().onSortPressed(otherEntry);
      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(context().currentSortingParams?.fieldKey, 'other');
      expect(context().currentSortingParams?.sortDesc, isFalse);
    });

    test('onFilterChanged combines active filters with AND and drops filters cleared back to null', () async {
      final filterEntries = IList<CmsFilterEntry<dynamic>>([
        CmsFilterSearchEntry(entryKey: 'q1', filterKeys: const ['a']),
        CmsFilterSearchEntry(entryKey: 'q2', filterKeys: const ['b']),
      ]);
      final delegate = _FakeDelegate(getResult: (paging) => [{'id': 1}]);
      final context = _build(delegate: delegate, pagingLimit: 10, filterEntries: filterEntries);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(delegate.getCalls.single.filter, const CmsFilterAll());

      context().onFilterChanged('q1', 'foo');
      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(delegate.getCalls.last.filter, const CmsFilterContains('a', 'foo'));
      expect(context().filterValues['q1'], 'foo');

      context().onFilterChanged('q2', 'bar');
      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(
        delegate.getCalls.last.filter,
        const CmsFilterAnd([CmsFilterContains('a', 'foo'), CmsFilterContains('b', 'bar')]),
      );
      expect(context().filterValues, {'q1': 'foo', 'q2': 'bar'});

      context().onFilterChanged('q1', null);
      await context.waitUntil((s) => s.items.isNotEmpty);
      expect(delegate.getCalls.last.filter, const CmsFilterContains('b', 'bar'));
      expect(context().filterValues, {'q1': null, 'q2': 'bar'});
    });

    test('initialFilterValues from params seed the first load filter', () async {
      final filterEntries = IList<CmsFilterEntry<dynamic>>([
        CmsFilterSearchEntry(entryKey: 'q1', filterKeys: const ['a']),
      ]);
      final delegate = _FakeDelegate(getResult: (paging) => [{'id': 1}]);
      final context = _build(
        delegate: delegate,
        pagingLimit: 10,
        filterEntries: filterEntries,
        params: const CmsTableParams(initialFilterValues: {'q1': 'preset'}),
      );
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.isNotEmpty);

      expect(delegate.getCalls.single.filter, const CmsFilterContains('a', 'preset'));
      expect(context().filterValues['q1'], 'preset');
    });

    test('onDeletePressed only deletes and removes the row when confirmed', () async {
      final row1 = {'id': 1};
      final row2 = {'id': 2};
      final delegate = _FakeDelegate(getResult: (paging) => [row1, row2]);
      var confirmResult = false;
      final context = _build(delegate: delegate, pagingLimit: 10, confirmDelete: () async => confirmResult);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.length == 2);

      await context().onDeletePressed(row1, 0);
      expect(delegate.deleted, isEmpty);
      expect(context().items.length, 2);

      confirmResult = true;
      await context().onDeletePressed(row1, 0);
      expect(delegate.deleted, [row1]);
      expect(context().items.map((e) => e['id']).toList(), [2]);
    });

    test('updateItem replaces the row at the given index', () async {
      final delegate = _FakeDelegate(getResult: (paging) => [{'id': 1}, {'id': 2}]);
      final context = _build(delegate: delegate, pagingLimit: 10);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.length == 2);

      context().updateItem({'id': 99}, 0);

      expect(context().items[0], {'id': 99});
      expect(context().items[1], {'id': 2});
    });

    test('onReloadPressed resets items and refetches from offset 0', () async {
      var callCount = 0;
      final delegate = _FakeDelegate(
        getResult: (paging) {
          callCount++;
          return callCount == 1 ? [{'id': 1}, {'id': 2}] : [{'id': 3}];
        },
      );
      final context = _build(delegate: delegate, pagingLimit: 10);
      addTearDown(context.dispose);

      await context.waitUntil((s) => s.items.length == 2);

      await context().onReloadPressed();

      expect(delegate.getCalls.last.paging.offset, 0);
      expect(context().items.map((e) => e['id']).toList(), [3]);
    });
  });
}
