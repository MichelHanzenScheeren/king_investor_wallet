import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';

void main() {
  group('NumberVO', () {
    test('should save valid string as double', () {
      final item = NumberVO('12.78');
      expect(item.value, equals(12.78));
      expect(item.isValid, isTrue);
    });

    test('should save negative string value as double', () {
      final item = NumberVO('-7.78');
      expect(item.value, equals(-7.78));
      expect(item.isValid, isTrue);
    });

    test('should save int value as double', () {
      final item = NumberVO(10);
      expect(item.value, equals(10.0));
      expect(item.isValid, isTrue);
    });

    test('should save double value as double', () {
      final item = NumberVO(0.5);
      expect(item.value, equals(0.5));
      expect(item.isValid, isTrue);
    });

    test('should save negative double value as negative double', () {
      final item = NumberVO(-1.987);
      expect(item.value, equals(-1.987));
      expect(item.isValid, isTrue);
    });

    test('should be invalid and save 0.0 if pass null value', () {
      final item = NumberVO(null);
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
    });

    test('should be invalid and save 0.0 if pass empty string', () {
      final item = NumberVO('');
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
    });

    test('should be invalid if pass invalid string with number', () {
      final item = NumberVO('1A');
      expect(item.isValid, isFalse);
    });

    test('should be invalid if pass number with comma separator', () {
      final item = NumberVO('1,4');
      expect(item.isValid, isFalse);
    });
  });
}
