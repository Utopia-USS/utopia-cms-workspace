import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:utopia_cms/utopia_cms.dart';

/// A tiny in-memory [CmsToManyDelegate] backing the demo "Tags" column.
///
/// It maps each lib row id to a set of tag ids over a fixed tag catalogue, so
/// the table renders a chip list (with "+N more" overflow) the way jolly renders
/// its "Classes" column. `get` honours the search [CmsFilter] so the picker's
/// search box narrows the tag catalogue. Edits made through the management
/// overlay persist for the session.
class MockToManyDelegate implements CmsToManyDelegate {
  MockToManyDelegate({required List<JsonMap> tags, required Map<String, Set<String>> relations})
      : _tags = tags,
        _relations = {for (final entry in relations.entries) entry.key: {...entry.value}};

  final List<JsonMap> _tags;
  final Map<String, Set<String>> _relations;

  @override
  String get originIdKey => 'id';

  @override
  String get foreignIdKey => 'id';

  @override
  Future<List<JsonMap>> get({Object? originId, CmsFilter filter = const CmsFilter.all()}) async {
    await _latency();
    final ids = originId == null ? null : (_relations[originId] ?? const <String>{});
    return _tags
        .where((tag) => ids == null || ids.contains(tag[foreignIdKey]))
        .where((tag) => _matches(tag, filter))
        .map((e) => <String, dynamic>{...e})
        .toList();
  }

  @override
  Future<void> update({
    required Object originId,
    required ISet<Object> addedForeignIds,
    required ISet<Object> removedForeignIds,
  }) async {
    await _latency();
    final set = _relations.putIfAbsent(originId as String, () => <String>{});
    set
      ..addAll(addedForeignIds.toSet().cast<String>())
      ..removeAll(removedForeignIds.toSet().cast<String>());
  }

  Future<void> _latency() => Future<void>.delayed(const Duration(milliseconds: 180));

  /// Evaluates the [CmsFilter] tree against a single tag row (drives the picker search).
  bool _matches(JsonMap row, CmsFilter filter) {
    return filter.when(
      all: () => true,
      equals: (field, value) => row.getAtPath(field) == value,
      notEquals: (field, value) => row.getAtPath(field) != value,
      containsString: (field, value, caseSensitive) {
        final cell = row.getAtPath(field)?.toString() ?? '';
        return caseSensitive
            ? cell.contains(value)
            : cell.toLowerCase().contains(value.toLowerCase());
      },
      inList: (field, values) => values.contains(row.getAtPath(field)),
      greaterOrEq: (field, value) => _compare(row.getAtPath(field), value) >= 0,
      lesserOrEq: (field, value) => _compare(row.getAtPath(field), value) <= 0,
      and: (filters) => filters.every((f) => _matches(row, f)),
      or: (filters) => filters.any((f) => _matches(row, f)),
      not: (inner) => !_matches(row, inner),
    );
  }

  /// Null-safe, type-aware comparison for range filters.
  int _compare(Object? a, Object? b) {
    if (a == null && b == null) return 0;
    if (a == null) return -1;
    if (b == null) return 1;
    if (a is num && b is num) return a.compareTo(b);
    if (a is bool && b is bool) return (a ? 1 : 0).compareTo(b ? 1 : 0);
    return a.toString().toLowerCase().compareTo(b.toString().toLowerCase());
  }
}
