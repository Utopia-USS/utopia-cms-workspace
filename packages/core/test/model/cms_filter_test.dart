import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/model/cms_filter.dart';

void main() {
  const a = CmsFilterEquals('a', 1);
  const b = CmsFilterEquals('b', 2);
  const c = CmsFilterEquals('c', 3);
  const d = CmsFilterEquals('d', 4);

  group('operator &', () {
    test('plain & plain builds a CmsFilterAnd', () {
      final result = a & b;

      expect(result, isA<CmsFilterAnd>());
      expect(result, equals(const CmsFilterAnd([a, b])));
    });

    test('and & plain flattens into a single CmsFilterAnd', () {
      const and = CmsFilterAnd([a, b]);
      final result = and & c;

      expect(result, isA<CmsFilterAnd>());
      expect(result, equals(const CmsFilterAnd([a, b, c])));
    });

    test('plain & and flattens into a single CmsFilterAnd', () {
      const and = CmsFilterAnd([b, c]);
      final result = a & and;

      expect(result, isA<CmsFilterAnd>());
      expect(result, equals(const CmsFilterAnd([a, b, c])));
    });

    test('and & and flattens both sides', () {
      const left = CmsFilterAnd([a, b]);
      const right = CmsFilterAnd([c, d]);
      final result = left & right;

      expect(result, isA<CmsFilterAnd>());
      expect(result, equals(const CmsFilterAnd([a, b, c, d])));
    });
  });

  group('operator |', () {
    test('plain | plain builds a CmsFilterOr', () {
      final result = a | b;

      expect(result, isA<CmsFilterOr>());
      expect(result, equals(const CmsFilterOr([a, b])));
    });

    test('or | plain flattens into a single CmsFilterOr', () {
      const or = CmsFilterOr([a, b]);
      final result = or | c;

      expect(result, isA<CmsFilterOr>());
      expect(result, equals(const CmsFilterOr([a, b, c])));
    });

    test('plain | or flattens into a single CmsFilterOr', () {
      const or = CmsFilterOr([b, c]);
      final result = a | or;

      expect(result, isA<CmsFilterOr>());
      expect(result, equals(const CmsFilterOr([a, b, c])));
    });

    test('or | or flattens both sides', () {
      const left = CmsFilterOr([a, b]);
      const right = CmsFilterOr([c, d]);
      final result = left | right;

      expect(result, isA<CmsFilterOr>());
      expect(result, equals(const CmsFilterOr([a, b, c, d])));
    });
  });

  group('mixed & and |', () {
    test('and & or keeps the or filter as a single child', () {
      const and = CmsFilterAnd([a, b]);
      const or = CmsFilterOr([c, d]);
      final result = and & or;

      expect(result, equals(const CmsFilterAnd([a, b, or])));
    });
  });

  group('operator ~ (not)', () {
    test('~plain wraps it in a CmsFilterNot', () {
      final result = ~a;

      expect(result, isA<CmsFilterNot>());
      expect(result, equals(const CmsFilterNot(a)));
    });

    test('~CmsFilterAnd applies De Morgan into a CmsFilterOr of nots', () {
      const and = CmsFilterAnd([a, b]);
      final result = ~and;

      expect(result, equals(const CmsFilterOr([CmsFilterNot(a), CmsFilterNot(b)])));
    });

    test('~CmsFilterOr applies De Morgan into a CmsFilterAnd of nots', () {
      const or = CmsFilterOr([a, b]);
      final result = ~or;

      expect(result, equals(const CmsFilterAnd([CmsFilterNot(a), CmsFilterNot(b)])));
    });

    test('~ recurses through nested and/or', () {
      const nested = CmsFilterAnd([CmsFilterOr([a, b]), c]);
      final result = ~nested;

      expect(
        result,
        equals(
          const CmsFilterOr([
            CmsFilterAnd([CmsFilterNot(a), CmsFilterNot(b)]),
            CmsFilterNot(c),
          ]),
        ),
      );
    });

    test('~~plain double-wraps since not() is not special-cased', () {
      final result = ~~a;

      expect(result, equals(const CmsFilterNot(CmsFilterNot(a))));
    });
  });
}
