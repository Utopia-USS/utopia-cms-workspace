import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/cms_filter.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_date_filter_entry.dart';
import 'package:utopia_cms/src/util/json_map.dart';

CmsFilterDateEntry _entry({
  CmsFilterDateEntryUnit unit = CmsFilterDateEntryUnit.dateTime,
  CmsFilterDateEntryMode mode = CmsFilterDateEntryMode.greater,
  List<String> filterKeys = const ['date'],
}) {
  return CmsFilterDateEntry(filterKeys: filterKeys, entryKey: 'date', mode: mode, unit: unit);
}

void main() {
  final date = DateTime(2026, 7, 2, 13, 30);

  group('toJson', () {
    test('dateTime unit returns DateTime.toString()', () {
      final entry = _entry();

      expect(entry.toJson(date), date.toString());
      expect(entry.toJson(null), isNull);
    });

    test('secondsSinceEpoch unit returns millisecondsSinceEpoch / 1000 as a double', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.secondsSinceEpoch);

      expect(entry.toJson(date), date.millisecondsSinceEpoch / 1000);
      expect(entry.toJson(date), isA<double>());
      expect(entry.toJson(null), isNull);
    });

    test('millisecondsSinceEpoch unit returns an int', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.millisecondsSinceEpoch);

      expect(entry.toJson(date), date.millisecondsSinceEpoch);
      expect(entry.toJson(date), isA<int>());
      expect(entry.toJson(null), isNull);
    });

    test('microsecondsSinceEpoch unit returns an int', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.microsecondsSinceEpoch);

      expect(entry.toJson(date), date.microsecondsSinceEpoch);
      expect(entry.toJson(date), isA<int>());
      expect(entry.toJson(null), isNull);
    });
  });

  group('fromJson', () {
    test('dateTime unit parses an ISO-8601 string', () {
      final entry = _entry();

      expect(entry.fromJson(date.toString()), date);
      expect(entry.fromJson(null), isNull);
    });

    test('millisecondsSinceEpoch unit parses an int', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.millisecondsSinceEpoch);

      expect(entry.fromJson(date.millisecondsSinceEpoch), date);
      expect(entry.fromJson(null), isNull);
    });

    test('microsecondsSinceEpoch unit parses an int', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.microsecondsSinceEpoch);

      expect(entry.fromJson(date.microsecondsSinceEpoch), date);
      expect(entry.fromJson(null), isNull);
    });

    test('secondsSinceEpoch unit parses an int', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.secondsSinceEpoch);
      final seconds = date.millisecondsSinceEpoch ~/ 1000;

      expect(entry.fromJson(seconds), date);
      expect(entry.fromJson(null), isNull);
    });
  });

  group('roundtrip', () {
    test('dateTime unit roundtrips', () {
      final entry = _entry();

      expect(entry.fromJson(entry.toJson(date)), date);
    });

    test('millisecondsSinceEpoch unit roundtrips', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.millisecondsSinceEpoch);

      expect(entry.fromJson(entry.toJson(date)), date);
    });

    test('microsecondsSinceEpoch unit roundtrips', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.microsecondsSinceEpoch);

      expect(entry.fromJson(entry.toJson(date)), date);
    });

    test('secondsSinceEpoch unit roundtrips through the fractional-seconds double', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.secondsSinceEpoch);
      final subSecondDate = DateTime(2026, 7, 2, 13, 30, 15, 250);

      expect(entry.toJson(subSecondDate), isA<double>());
      expect(entry.fromJson(entry.toJson(subSecondDate)), subSecondDate);
    });

    test('secondsSinceEpoch unit also accepts backend int seconds', () {
      final entry = _entry(unit: CmsFilterDateEntryUnit.secondsSinceEpoch);
      final wholeSecondDate = DateTime(2026, 7, 2, 13, 30);

      expect(entry.fromJson(wholeSecondDate.millisecondsSinceEpoch ~/ 1000), wholeSecondDate);
    });
  });

  group('filterFromValues', () {
    test('returns CmsFilterAll when the date is null', () {
      final entry = _entry();

      expect(entry.filterFromValues(const {'date': null}), const CmsFilterAll());
    });

    test('returns CmsFilterAll when filterKeys is empty', () {
      final entry = _entry(filterKeys: const []);
      final JsonMap value = {'date': date};

      expect(entry.filterFromValues(value), const CmsFilterAll());
    });

    test('mode greater (default) with a single key builds a CmsFilterGreaterOrEq', () {
      final entry = _entry();
      final JsonMap value = {'date': date};

      expect(entry.filterFromValues(value), CmsFilterGreaterOrEq('date', date));
    });

    test('mode lesser with a single key builds a CmsFilterLesserOrEq', () {
      final entry = _entry(mode: CmsFilterDateEntryMode.lesser);
      final JsonMap value = {'date': date};

      expect(entry.filterFromValues(value), CmsFilterLesserOrEq('date', date));
    });

    test('two filterKeys build a CmsFilterOr with one filter per distinct key', () {
      final entry = _entry(filterKeys: const ['a', 'b']);
      final JsonMap value = {'date': date};

      expect(entry.filterFromValues(value), CmsFilterOr([CmsFilterGreaterOrEq('a', date), CmsFilterGreaterOrEq('b', date)]));
    });
  });
}
