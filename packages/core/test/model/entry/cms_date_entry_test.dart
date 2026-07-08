import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_date_entry.dart';

void main() {
  final entry = CmsDateEntry(key: 'date');
  final date = DateTime(2026, 7, 2, 13, 30);

  group('toJson', () {
    test('returns DateTime.toString()', () {
      expect(entry.toJson(date), date.toString());
    });

    test('returns null for a null value', () {
      expect(entry.toJson(null), isNull);
    });
  });

  group('fromJson', () {
    test('parses an ISO-8601 string back into the same DateTime', () {
      expect(entry.fromJson(date.toString()), date);
    });

    test('returns null for a null value', () {
      expect(entry.fromJson(null), isNull);
    });
  });

  test('roundtrip fromJson(toJson(date)) == date', () {
    expect(entry.fromJson(entry.toJson(date)), date);
  });
}
