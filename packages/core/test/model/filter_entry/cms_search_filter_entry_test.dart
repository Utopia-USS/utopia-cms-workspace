import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/cms_filter.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_search_filter_entry.dart';
import 'package:utopia_cms/src/util/json_map.dart';

void main() {
  group('filterFromValues', () {
    test('returns CmsFilterAll when the entryKey is missing from the values', () {
      final entry = CmsFilterSearchEntry(filterKeys: const ['name'], entryKey: 'search');

      expect(entry.filterFromValues(const {}), const CmsFilterAll());
    });

    test('returns CmsFilterAll when the value is null', () {
      final entry = CmsFilterSearchEntry(filterKeys: const ['name'], entryKey: 'search');

      expect(entry.filterFromValues(const {'search': null}), const CmsFilterAll());
    });

    test('returns CmsFilterAll when the value is an empty string', () {
      final entry = CmsFilterSearchEntry(filterKeys: const ['name'], entryKey: 'search');

      expect(entry.filterFromValues(const {'search': ''}), const CmsFilterAll());
    });

    test('returns CmsFilterAll when filterKeys is empty, even with a search value', () {
      final entry = CmsFilterSearchEntry(filterKeys: const [], entryKey: 'search');

      expect(entry.filterFromValues(const {'search': 'abc'}), const CmsFilterAll());
    });

    test('a single filterKey builds a CmsFilterContains', () {
      final entry = CmsFilterSearchEntry(filterKeys: const ['name'], entryKey: 'search');
      final JsonMap value = {'search': 'abc'};

      expect(entry.filterFromValues(value), const CmsFilterContains('name', 'abc'));
    });

    test('two filterKeys build a CmsFilterOr with a CmsFilterContains per key, in order', () {
      final entry = CmsFilterSearchEntry(filterKeys: const ['name', 'description'], entryKey: 'search');
      final JsonMap value = {'search': 'abc'};

      expect(
        entry.filterFromValues(value),
        const CmsFilterOr([CmsFilterContains('name', 'abc'), CmsFilterContains('description', 'abc')]),
      );
    });

    test('a staggered entryKey resolves through nested maps', () {
      final entry = CmsFilterSearchEntry(filterKeys: const ['name'], entryKey: 'filters.search');
      final JsonMap value = {
        'filters': {'search': 'abc'},
      };

      expect(entry.filterFromValues(value), const CmsFilterContains('name', 'abc'));
    });
  });

  group('fixedLabel', () {
    test('falls back to an empty string when label is null', () {
      final entry = CmsFilterSearchEntry(filterKeys: const ['name'], entryKey: 'search');

      expect(entry.fixedLabel, '');
    });
  });
}
