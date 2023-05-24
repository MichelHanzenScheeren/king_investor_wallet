import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';

const invalidIntMessage = 'Número inteiro inválido';
const outOfRangeMessage = 'A nota precisa ser um número inteiro entre 0 e 10';

void main() {
  group('RatingVO', () {
    test('should be valid if rating = 0', () {
      final item = RatingVO(0);
      expect(item.isValid, isTrue);
    });

    test('should be valid if rating = 10', () {
      final item = RatingVO(0);
      expect(item.isValid, isTrue);
    });

    test('should cbe invalid if invalid int (super validation)', () {
      final item = RatingVO(7.5);
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), equals(invalidIntMessage));
    });

    test('should be invalid if out of range', () {
      final item = RatingVO(11);
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), equals(outOfRangeMessage));
    });
  });
}
