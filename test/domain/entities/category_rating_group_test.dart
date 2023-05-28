import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/category_rating_group.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import '../../mocks/domain/entities/category_rating_groups.dart';

void main() {
  group('CategoryRatingGroup', () {
    test('should be valid if valid data', () {
      final item = validCategoryRatingGroup();
      expect(item.isValid, isTrue);
      expect(item.categoriesRating.length, Category.values.length);
    });

    test('should be valid if created with default constructor', () {
      final item = CategoryRatingGroup.fromDefault();
      expect(item.isValid, isTrue);
      expect(item.categoriesRating.length, Category.values.length);
    });

    test('should fix assetsCategoryRating if some data is Less', () {
      final item = partialCategoryRatingGroup();
      expect(item.isValid, isTrue);
      expect(item.categoriesRating.length, Category.values.length);
    });

    test('should be invalid if invalid data', () {
      final item = invalidCategoryRatingGroup();
      expect(item.isValid, isFalse);
    });
  });
}
