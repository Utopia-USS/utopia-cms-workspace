import 'package:utopia_cms/utopia_cms.dart';

import 'mock_filter_eval.dart';

/// A fully in-memory, stateful [CmsDelegate].
///
/// It is the demo stand-in for a real Firebase / Supabase / Hasura delegate:
/// every create / update / delete mutates an in-memory list, so changes persist
/// for the lifetime of the session (across page switches) without a backend.
/// `get` honours sorting, the [CmsFilter] tree and offset paging in memory, so
/// the table's search, column sort and infinite scroll all behave realistically.
/// Field access uses dotted-path `getAtPath`, so nested keys (e.g. `link.name`)
/// work in filters and sorting.
///
/// Keep ONE instance per logical table (see `seed_data.dart`) so its state is
/// shared by the page that renders it.
class MockDelegate implements CmsDelegate {
  MockDelegate(List<JsonMap> seed, {this.idPrefix = 'row'})
    : _items = seed.map((e) => <String, dynamic>{...e}).toList();

  final List<JsonMap> _items;
  final String idPrefix;
  int _sequence = 0;

  @override
  String get idKey => 'id';

  @override
  Future<List<JsonMap>> get({
    CmsFunctionsSortingParams? sorting,
    CmsFilter filter = const CmsFilter.all(),
    required CmsFunctionsPagingParams paging,
  }) async {
    await _latency();
    final rows = _items.where((row) => mockMatches(row, filter)).toList();
    if (sorting != null) {
      rows.sort((a, b) {
        final result = mockCompare(a.getAtPath(sorting.fieldKey), b.getAtPath(sorting.fieldKey));
        return sorting.sortDesc ? -result : result;
      });
    }
    final offset = paging.offset;
    if (offset >= rows.length) return const [];
    final limit = paging.limit;
    final end = limit == null ? rows.length : (offset + limit).clamp(0, rows.length);
    return rows.sublist(offset, end).map((e) => <String, dynamic>{...e}).toList();
  }

  @override
  Future<JsonMap> create(JsonMap value) async {
    await _latency();
    final row = <String, dynamic>{...value, idKey: '${idPrefix}_${++_sequence}'};
    _items.insert(0, row);
    return <String, dynamic>{...row};
  }

  @override
  Future<JsonMap> update(JsonMap value, JsonMap oldValue) async {
    await _latency();
    final id = value[idKey];
    final index = _items.indexWhere((e) => e[idKey] == id);
    final row = <String, dynamic>{...value};
    if (index == -1) {
      _items.insert(0, row);
    } else {
      _items[index] = row;
    }
    return <String, dynamic>{...row};
  }

  @override
  Future<void> delete(JsonMap value) async {
    await _latency();
    _items.removeWhere((e) => e[idKey] == value[idKey]);
  }

  Future<void> _latency() => Future<void>.delayed(const Duration(milliseconds: 280));
}
