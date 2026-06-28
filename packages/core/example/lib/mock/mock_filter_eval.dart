import 'package:utopia_cms/utopia_cms.dart';

/// Evaluates a [CmsFilter] tree against a single in-memory row. Shared by the
/// mock delegates so the demo's filter semantics live in one place.
bool mockMatches(JsonMap row, CmsFilter filter) {
  return filter.when(
    all: () => true,
    equals: (field, value) => row.getAtPath(field) == value,
    notEquals: (field, value) => row.getAtPath(field) != value,
    containsString: (field, value, caseSensitive) {
      final cell = row.getAtPath(field)?.toString() ?? '';
      return caseSensitive ? cell.contains(value) : cell.toLowerCase().contains(value.toLowerCase());
    },
    inList: (field, values) => values.contains(row.getAtPath(field)),
    greaterOrEq: (field, value) => mockCompare(row.getAtPath(field), value) >= 0,
    lesserOrEq: (field, value) => mockCompare(row.getAtPath(field), value) <= 0,
    and: (filters) => filters.every((f) => mockMatches(row, f)),
    or: (filters) => filters.any((f) => mockMatches(row, f)),
    not: (inner) => !mockMatches(row, inner),
  );
}

/// Null-safe, type-aware comparison for sorting and range filters.
int mockCompare(Object? a, Object? b) {
  if (a == null && b == null) return 0;
  if (a == null) return -1;
  if (b == null) return 1;
  if (a is num && b is num) return a.compareTo(b);
  if (a is bool && b is bool) return (a ? 1 : 0).compareTo(b ? 1 : 0);
  return a.toString().toLowerCase().compareTo(b.toString().toLowerCase());
}
