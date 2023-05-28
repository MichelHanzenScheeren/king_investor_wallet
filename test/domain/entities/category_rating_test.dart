import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/category_rating.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';

void main() {
  group('CategoryRating', () {
    test('should be valid if valid data', () {
      final item = CategoryRating(type: Category.stock, rating: RatingVO(8));
      expect(item.isValid, isTrue);
    });

    test('should be valid if create with named constructor', () {
      final item = CategoryRating.asDefault(type: Category.reit);
      expect(item.isValid, isTrue);
      expect(item.rating, RatingVO.asDefault().value);
    });

    test('should be invalid if invalid data', () {
      final item = CategoryRating(type: Category.reit, rating: RatingVO(11));
      expect(item.isValid, isFalse);
    });

    test('should be equal to other class with same asset type', () {
      final item = CategoryRating(type: Category.stock, rating: RatingVO(8));
      final item2 = CategoryRating(type: Category.stock, rating: RatingVO(2));
      expect(item, equals(item2));
    });

    test('should be different to other class with different asset type', () {
      final item = CategoryRating(type: Category.stock, rating: RatingVO(8));
      final item2 = CategoryRating(type: Category.reit, rating: RatingVO(2));
      expect(item, isNot(item2));
    });
  });
}
