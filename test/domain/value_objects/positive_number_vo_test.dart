import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';

void main() {
  group('PositiveNumberVO', () {
    test('should save double positive value as double and be valid', () {
      final item = PositiveNumberVO(0.5);
      expect(item.value, equals(0.5));
      expect(item.isValid, isTrue);
    });

    test('should be invalid if invalid double with super message', () {
      final item = PositiveNumberVO('a');
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), equals('Número inválido'));
    });

    test('should be invalid if negative double with class validation', () {
      final item = PositiveNumberVO(-4.1);
      expect(item.value, equals(0.0));
      expect(item.isValid, isFalse);
      const message = 'Número não pode ser negativo';
      expect(item.validate().exceptionOrNull(), equals(message));
    });
  });
}
