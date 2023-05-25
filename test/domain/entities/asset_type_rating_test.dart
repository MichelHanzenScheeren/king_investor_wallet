import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_type_rating.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';

void main() {
  group('AssetTypeRating', () {
    test('should be valid if valid data', () {
      final item = AssetTypeRating(type: AssetType.stock, rating: RatingVO(8));
      expect(item.isValid, isTrue);
    });

    test('should be valid if create with named constructor', () {
      final item = AssetTypeRating.asDefault(type: AssetType.reit);
      expect(item.isValid, isTrue);
      expect(item.rating, RatingVO.asDefault().value);
    });

    test('should be invalid if invalid data', () {
      final item = AssetTypeRating(type: AssetType.reit, rating: RatingVO(11));
      expect(item.isValid, isFalse);
    });

    test('should be equal to other class with same asset type', () {
      final item = AssetTypeRating(type: AssetType.stock, rating: RatingVO(8));
      final item2 = AssetTypeRating(type: AssetType.stock, rating: RatingVO(2));
      expect(item, equals(item2));
    });

    test('should be different to other class with different asset type', () {
      final item = AssetTypeRating(type: AssetType.stock, rating: RatingVO(8));
      final item2 = AssetTypeRating(type: AssetType.reit, rating: RatingVO(2));
      expect(item, isNot(item2));
    });
  });
}
