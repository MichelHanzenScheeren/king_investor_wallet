import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_type_rating_group.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import '../../mocks/domain/entities/asset_type_rating_groups.dart';

void main() {
  group('AssetTypeRatingGroup', () {
    test('should be valid if valid data', () {
      final item = validAssetTypeRatingGroup();
      expect(item.isValid, isTrue);
      expect(item.typesRating.length, AssetType.values.length);
    });

    test('should be valid if created with default constructor', () {
      final item = AssetTypeRatingGroup.fromDefault();
      expect(item.isValid, isTrue);
      expect(item.typesRating.length, AssetType.values.length);
    });

    test('should fix assetsTypeRating if some data is Less', () {
      final item = partialAssetTypeRatingGroup();
      expect(item.isValid, isTrue);
      expect(item.typesRating.length, AssetType.values.length);
    });

    test('should be invalid if invalid data', () {
      final item = invalidAssetTypeRatingGroup();
      expect(item.isValid, isFalse);
    });
  });
}
