import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/utils/number_extractor.dart';

void main() {
  group('numberExtractor', () {
    test('should return double if double was passed', () {
      final value = numberExtractor(1.5);
      expect(value, equals(1.5));
    });

    test('should return double if int was passed', () {
      final value = numberExtractor(1);
      expect(value, equals(1.0));
    });

    test('should return double if string with valid double was passed', () {
      final value = numberExtractor('0.9');
      expect(value, equals(0.9));
    });

    test('should return double if negative double was passed', () {
      final value = numberExtractor(-1.15);
      expect(value, equals(-1.15));
    });

    test('should return double if string with negative double was passed', () {
      final value = numberExtractor('-6');
      expect(value, equals(-6));
    });

    test('should return null if invalid string was passed', () {
      final value = numberExtractor('abc');
      expect(value, equals(null));
    });

    test('should return null if invalid string with number was passed', () {
      final value = numberExtractor('12.a');
      expect(value, equals(null));
    });

    test('should return null if empty string was passed', () {
      final value = numberExtractor('');
      expect(value, equals(null));
    });

    test('should return null if null was passed', () {
      final value = numberExtractor(null);
      expect(value, equals(null));
    });
  });
}
