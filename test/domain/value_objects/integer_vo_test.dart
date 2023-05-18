import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/integer_vo.dart';

void main() {
  group('IntegerVO', () {
    test('should be valid when pass int value as string', () {
      final item = IntegerVO('12');
      expect(item.value, equals(12));
      expect(item.isValid, isTrue);
    });

    test('should be valid when pass int value', () {
      final item = IntegerVO(18);
      expect(item.value, equals(18));
      expect(item.isValid, isTrue);
    });

    test('should be invalid when pass null', () {
      final item = IntegerVO(null);
      expect(item.value, equals(0));
      expect(item.isValid, isFalse);
    });

    test('should be invalid when pass double value', () {
      final item = IntegerVO(12.4);
      expect(item.value, equals(0));
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), 'Número inteiro inválido');
    });
  });
}
