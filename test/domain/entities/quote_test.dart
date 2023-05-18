import 'package:flutter_test/flutter_test.dart';
import '../../mocks/domain/entities/quotes.dart';

void main() {
  group('Quote', () {
    test('should be valid when all values are valid', () {
      final item = validQuoteWithRandomId1;
      expect(item.isValid, isTrue);
    });

    test('should be invalid when has invalid value', () {
      final item = invalidQuoteWithRandomId1;
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), equals('Número inválido'));
    });

    test('should be different when has different id', () {
      final item1 = validQuoteWithRandomId1;
      final item2 = invalidQuoteWithRandomId1;
      expect(item1, isNot(item2));
    });

    test('should be equal when has same id', () {
      final item1 = validQuoteWithStaticId1;
      final item2 = validQuoteWithStaticId2;
      expect(item1, equals(item2));
    });
  });
}
