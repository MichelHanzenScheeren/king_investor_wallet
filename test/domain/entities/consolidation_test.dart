import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';

import '../../mocks/domain/entities/consolidations.dart';

void main() {
  group('ConsolidationResult', () {
    test('should correct separe valid and invalid assets', () {
      final item = consolidationWithValidAndInvalidAssets();
      expect(item.validAssets, hasLength(2));
      expect(item.invalidAssets, hasLength(3));
    });

    test('should correct validate according to assets', () {
      final item = consolidationWithValidAndInvalidAssets();
      expect(item.isValid, isTrue);
      expect(item.hasInvalidAssets, isTrue);
    });

    test('should be invalid if none valid asset', () {
      final item = consolidationWithOnlyInvalidAssets();
      expect(item.isValid, isFalse);
    });

    test('should correct generate results for passed asset categories', () {
      final item = consolidationWithValidAndInvalidAssets2();
      final consolidation = item.consolidate();
      final categoriesCons = consolidation.assetTypesConsolidation;
      expect(categoriesCons, hasLength(2));
    });

    test('should correct generate results for stocks category', () {
      final item = consolidationWithValidAndInvalidAssets2();
      final consolidation = item.consolidate();
      final categoriesCons = consolidation.assetTypesConsolidation;

      final first = categoriesCons.first;
      final discriminator1 = SymbolVO(AssetType.stock.abbreviation).value;
      expect(first.isValid, isTrue);
      expect(first.discriminator, equals(discriminator1));
      expect(first.totalInvested, equals(225.8));
      expect(first.totalInvestedPercentage.toStringAsFixed(2), equals('70.17'));
      expect(first.totalToday, equals(363.6));
      expect(first.totalTodayPercentage.toStringAsFixed(2), equals('90.99'));
      expect(first.totalIncomes, equals(27));
      expect(first.balanceSales, equals(5));
    });
  });
}
