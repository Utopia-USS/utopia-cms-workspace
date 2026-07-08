import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/util/json_map.dart';
import 'package:utopia_cms/src/util/map_extensions.dart';

void main() {
  group('getAtPath', () {
    test('single-segment key returns the value', () {
      final JsonMap map = {'a': 1};

      expect(map.getAtPath('a'), 1);
    });

    test('nested path returns the deep value', () {
      final JsonMap map = {
        'a': {
          'b': {'c': 42},
        },
      };

      expect(map.getAtPath('a.b.c'), 42);
    });

    test('null intermediate value short-circuits instead of throwing', () {
      final JsonMap map = {'a': null};

      expect(() => map.getAtPath('a.b.c'), returnsNormally);
      expect(map.getAtPath('a.b.c'), isNull);
    });

    test('missing leaf returns null', () {
      final JsonMap map = {
        'a': {'b': 1},
      };

      expect(map.getAtPath('a.c'), isNull);
    });
  });

  group('setAtPath', () {
    test('top-level path sets a new value', () {
      final JsonMap map = {};
      map.setAtPath('a', 1);

      expect(map, {'a': 1});
    });

    test('top-level path overwrites an existing value', () {
      final JsonMap map = {'a': 1};
      map.setAtPath('a', 2);

      expect(map, {'a': 2});
    });

    test('nested path writes into an existing inner map without clobbering siblings', () {
      final JsonMap map = {
        'a': {'b': 1, 'c': 2},
      };
      map.setAtPath('a.b', 99);

      expect(map, {
        'a': {'b': 99, 'c': 2},
      });
    });
  });
}
