import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';

void main() {
  group('EmailVO', () {
    test('should be valid when valid email', () {
      final item = EmailVO('meu_teste@gmail.com');
      expect(item.isValid, isTrue);
      expect(item.value, equals('meu_teste@gmail.com'));
    });

    test('should be invalid when empty string', () {
      final item = EmailVO('');
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), 'Email inválido');
    });

    test('should be invalid when dont have @ symbol', () {
      final item = EmailVO('meu_teste.com');
      expect(item.isValid, isFalse);
    });

    test('should be invalid when dont have @ symbol', () {
      final item = EmailVO('meu_teste.com');
      expect(item.isValid, isFalse);
    });

    test('should be invalid when dont have . symbol', () {
      final item = EmailVO('meu_teste@gmail');
      expect(item.isValid, isFalse);
    });
  });
}
