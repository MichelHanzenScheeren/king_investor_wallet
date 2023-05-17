import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';

void main() {
  group('NumberVO', () {
    test('should pass string value as double', () {
      final item = NumberVO('12.78');
      expect(item.value, equals(12.78));
      expect(item.isValid, isTrue);
    });

    test('should pass string negative value as double', () {
      final item = NumberVO('-.78');
      expect(item.value, equals(-0.78));
      expect(item.isValid, isTrue);
    });

    test('should pass int value as double', () {
      final item = NumberVO(10);
      expect(item.value, equals(10.0));
      expect(item.isValid, isTrue);
    });

    test('should pass double value as double', () {
      final item = NumberVO(0.5);
      expect(item.value, equals(0.5));
      expect(item.isValid, isTrue);
    });

    test('should pass negative double value as double', () {
      final item = NumberVO(-1.987);
      expect(item.value, equals(-1.987));
      expect(item.isValid, isTrue);
    });

    test('should pass null value as 0.0', () {
      final item = NumberVO(null);
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), equals('Valor inválido'));
    });

    test('should pass empty string value as 0.0', () {
      final item = NumberVO('');
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
    });

    test('should pass invalid string with numbers as 0.0', () {
      final item = NumberVO('1A');
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
    });

    test('should pass invalid string number as 0.0', () {
      final item = NumberVO('1,4');
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
    });
  });
}
