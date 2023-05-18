import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/utils/integer_extractor.dart';

void main() {
  group('integerExtractor', () {
    test('should return int value if int was passed', () {
      final value = integerExtractor(1);
      expect(value, equals(1));
    });

    test('should return int value if int value was passed as string', () {
      final value = integerExtractor('56');
      expect(value, equals(56));
    });

    test('should return int value if string with space was passed', () {
      final value = integerExtractor(' 2');
      expect(value, equals(2));
    });

    test('should return int value if negative int value was passed', () {
      final value = integerExtractor(-22);
      expect(value, equals(-22));
    });

    test('should return int value if negative value was passed as string', () {
      final value = integerExtractor('-17');
      expect(value, equals(-17));
    });

    test('should return null if null was passed', () {
      final value = integerExtractor(null);
      expect(value, isNull);
    });

    test('should return null if double value was passed', () {
      final value = integerExtractor(2.5);
      expect(value, isNull);
    });

    test('should return null if empty string was passed', () {
      final value = integerExtractor('');
      expect(value, isNull);
    });

    test('should return null if string was passed', () {
      final value = integerExtractor('abc');
      expect(value, isNull);
    });

    test('should return null if string with invalid value was passed', () {
      final value = integerExtractor('2a');
      expect(value, isNull);
    });
  });
}
