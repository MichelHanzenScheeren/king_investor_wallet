import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/asset.dart';

import '../../mocks/domain/entities/assets.dart';
import '../../mocks/domain/entities/assets_data.dart';
import '../../mocks/domain/entities/quotes.dart';

void main() {
  group('Asset', () {
    test('should be valid when all values are valid', () {
      final item = validAssetWeg3();
      expect(item.isValid, isTrue);
    });

    test('should be valid when create with name parameter', () {
      final item = Asset.fromData(
        assetData: validAssetDataWeg3(),
        quote: validQuoteWithRandomId1(),
      );
      expect(item.isValid, isTrue);
      expect(item, equals(validAssetWeg3()));
    });

    test('should be invalid when invalid data', () {
      final item = invalidAssetWeg3();
      expect(item.isValid, isFalse);
    });
  });
}
