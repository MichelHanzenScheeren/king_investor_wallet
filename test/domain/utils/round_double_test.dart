import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/utils/round_double.dart';

void main() {
  group('roundDouble', () {
    const places = 2;

    test('Should return same number if double with 2 decimal values', () {
      final item = roundDouble(5.34, places);
      expect(item, equals(5.34));
    });

    test('should round correctly when more decimal values', () {
      final item = roundDouble(5.344, places);
      expect(item, equals(5.34));
    });

    test('should round correctly when more decimal values', () {
      final item = roundDouble(5.346, places);
      expect(item, equals(5.35));
    });

    test('should round correctly when more decimal values', () {
      final item = roundDouble(399.9 / 10, places);
      expect(item, equals(39.99));
    });

    test('should round correctly when more decimal values', () {
      final item = roundDouble(0.0, places);
      expect(item, equals(0.0));
    });
  });
}
