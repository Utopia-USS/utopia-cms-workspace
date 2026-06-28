import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:utopia_cms/utopia_cms.dart';

import 'mock_filter_eval.dart';

/// A tiny in-memory [CmsToManyDelegate] backing the demo "Tags" column.
///
/// It maps each lib row id to a set of tag ids over a fixed tag catalogue, so
/// the table renders a chip list (with "+N more" overflow) for a to-many
/// relation column. `get` honours the search [CmsFilter] so the picker's
/// search box narrows the tag catalogue. Edits made through the management
/// overlay persist for the session.
class MockToManyDelegate implements CmsToManyDelegate {
  MockToManyDelegate({required List<JsonMap> tags, required Map<String, Set<String>> relations})
    : _tags = tags,
      _relations = {
        for (final entry in relations.entries) entry.key: {...entry.value},
      };

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
        .where((tag) => mockMatches(tag, filter))
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
}
