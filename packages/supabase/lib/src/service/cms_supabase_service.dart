import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utopia_cms/utopia_cms.dart';
import 'package:utopia_cms_supabase/src/model/cms_supabase_table.dart';

typedef _Query = PostgrestTransformBuilder<PostgrestList>;

class CmsSupabaseService {
  const CmsSupabaseService();

  Future<List<JsonMap>> query(
    SupabaseClient client, {
    required CmsSupabaseTable table,
    CmsFunctionsPagingParams? paging,
    CmsFilter filter = const CmsFilter.all(),
    CmsFunctionsSortingParams? sorting,
  }) async {
    _Query queryBuilder = _applyFilter(client.from(table.fullName).select(), filter);

    // Apply sorting
    if (sorting != null) {
      final orderColumn = sorting.fieldKey;
      final ascending = !sorting.sortDesc;
      if (sorting.invertNulls) {
        queryBuilder = queryBuilder.order(orderColumn, ascending: ascending, nullsFirst: ascending);
      } else {
        queryBuilder = queryBuilder.order(orderColumn, ascending: ascending);
      }
    }

    // Apply pagination
    if (paging != null) {
      final limit = paging.limit ?? 100;
      queryBuilder = queryBuilder.range(paging.offset, paging.offset + limit - 1);
    }

    return _asJsonMapList(await queryBuilder);
  }

  Future<List<JsonMap>> insert(
    SupabaseClient client, {
    required CmsSupabaseTable table,
    required List<JsonMap> objects,
  }) async {
    final response = await client.from(table.fullName).insert(objects).select();
    return _asJsonMapList(response);
  }

  Future<JsonMap> insertOne(SupabaseClient client, {required CmsSupabaseTable table, required JsonMap object}) async {
    final response = await client.from(table.fullName).insert(object).select();
    return _asFirstJsonMap(response);
  }

  Future<JsonMap> updateById(
    SupabaseClient client, {
    required CmsSupabaseDataTable table,
    required JsonMap object,
  }) async {
    final id = object[table.idKey] as Object;
    final updateData = JsonMap.from(object)..remove(table.idKey);
    final response = await client.from(table.fullName).update(updateData).eq(table.idKey, id).select();
    return _asFirstJsonMap(response);
  }

  Future<List<JsonMap>> delete(
    SupabaseClient client, {
    required CmsSupabaseTable table,
    required CmsFilter filter,
  }) async {
    final queryBuilder = _applyFilter(client.from(table.fullName).delete(), filter);
    final response = await queryBuilder.select();
    return _asJsonMapList(response);
  }

  Future<JsonMap> deleteById(SupabaseClient client, {required CmsSupabaseDataTable table, required Object id}) async {
    final response = await client.from(table.fullName).delete().eq(table.idKey, id).select();
    return _asFirstJsonMap(response);
  }

  PostgrestFilterBuilder<T> _applyFilter<T>(PostgrestFilterBuilder<T> query, CmsFilter filter) {
    return filter.when(
      all: () => query,
      equals: (field, value) {
        if (value == null) {
          return query.isFilter(field, null);
        }
        return query.eq(field, value);
      },
      notEquals: (field, value) {
        if (value == null) {
          return query.not(field, 'is', null);
        }
        return query.neq(field, value);
      },
      containsString: (field, value, caseSensitive) {
        final pattern = '%$value%';
        return caseSensitive ? query.like(field, pattern) : query.ilike(field, pattern);
      },
      inList: (field, values) => query.inFilter(field, values),
      and: (filters) {
        // For AND, we apply all filters sequentially (they are ANDed by default)
        var result = query;
        for (final f in filters) {
          result = _applyFilter(result, f);
        }
        return result;
      },
      or: (filters) {
        if (filters.isEmpty) return query;
        if (filters.length == 1) return _applyFilter(query, filters.first);

        final orConditions = filters.map(_buildCondition).where((c) => c.isNotEmpty).join(',');
        if (orConditions.isNotEmpty) {
          return query.or(orConditions);
        }
        return query;
      },
      greaterOrEq: (field, value) => query.gte(field, value),
      lesserOrEq: (field, value) => query.lte(field, value),
      not: (filter) {
        final condition = _buildCondition(filter, isNegatedContext: true);
        if (condition.isNotEmpty) {
          return query.or('not.and($condition)');
        }
        return query;
      },
    );
  }

  String _buildCondition(CmsFilter filter, {bool isNegatedContext = false}) {
    return filter.when(
      all: () => '',
      equals: (field, value) {
        if (value == null) return '$field.is.null';
        return '$field.eq.${_formatValue(value)}';
      },
      notEquals: (field, value) => '$field.neq.${_formatValue(value)}',
      containsString: _buildContainsCondition,
      inList: (field, values) => '$field.in.(${values.map(_formatValue).join(',')})',
      and: (filters) {
        return filters.map(_buildCondition).where((c) => c.isNotEmpty).join(',');
      },
      or: (filters) {
        return filters.map(_buildCondition).where((c) => c.isNotEmpty).join(',');
      },
      greaterOrEq: (field, value) => '$field.gte.${_formatValue(value)}',
      lesserOrEq: (field, value) => '$field.lte.${_formatValue(value)}',
      not: (filter) {
        final condition = _buildCondition(filter, isNegatedContext: !isNegatedContext);
        if (condition.isEmpty) return '';
        return isNegatedContext ? condition : 'not.$condition';
      },
    );
  }

  List<JsonMap> _asJsonMapList(PostgrestList response) => response.cast<JsonMap>();

  JsonMap _asFirstJsonMap(PostgrestList response) => _asJsonMapList(response).first;

  String _buildContainsCondition(String field, String value, bool caseSensitive) {
    final pattern = '%$value%';
    final formattedPattern = _formatValue(pattern);
    return caseSensitive ? '$field.like.$formattedPattern' : '$field.ilike.$formattedPattern';
  }

  String _formatValue(Object? value) {
    if (value == null) return 'null';
    if (value is String) {
      // Escape quotes and backslashes, wrap in quotes
      return '"${value.replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"';
    }
    if (value is bool) return value.toString();
    if (value is num) return value.toString();
    // For other types, convert to string and quote
    return '"${value.toString().replaceAll(r'\', r'\\').replaceAll('"', r'\"')}"';
  }
}
