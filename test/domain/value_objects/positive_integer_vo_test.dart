import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';

void main() {
  group('PositiveIntegerTest', () {
    test('should ve valid when pass valid int', () {
      final item = PositiveIntegerVO(10);
      expect(item.value, equals(10));
      expect(item.isValid, isTrue);
    });

    test('should ve invalidated by super when invalid int', () {
      final item = PositiveIntegerVO('');
      expect(item.value, equals(0));
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), 'Número inteiro inválido');
    });

    test('should ve invalidated itself when negative int', () {
      final item = PositiveIntegerVO('-5');
      expect(item.value, equals(0));
      expect(item.isValid, isFalse);
      const message = 'Número não pode ser negativo';
      expect(item.validate().exceptionOrNull(), equals(message));
    });
  });
}
