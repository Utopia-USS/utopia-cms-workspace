import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/util/string_extensions.dart';

void main() {
  group('parseBool', () {
    test('parses true in any casing', () {
      expect('true'.parseBool(), isTrue);
      expect('TRUE'.parseBool(), isTrue);
      expect('True'.parseBool(), isTrue);
    });

    test('parses false in any casing', () {
      expect('false'.parseBool(), isFalse);
      expect('FALSE'.parseBool(), isFalse);
    });

    test('throws for a value that is not a boolean literal', () {
      expect(() => 'yes'.parseBool(), throwsA(isA<String>()));
    });

    test('throws for an empty string', () {
      expect(() => ''.parseBool(), throwsA(isA<String>()));
    });
  });

  group('modifyRequired', () {
    test('appends * when required', () {
      expect('Name'.modifyRequired(true), 'Name*');
    });

    test('returns the string unchanged when not required', () {
      expect('Name'.modifyRequired(false), 'Name');
    });
  });
}
