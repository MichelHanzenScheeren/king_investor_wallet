import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import '../../mocks/domain/entities/consolidations.dart';

void main() {
  group('ConsolidationResult', () {
    test('should correct separe valid and invalid assets', () {
      final item = consolidationWithValidAndInvalidAssets();
      expect(item.validAssets, hasLength(3));
      expect(item.invalidAssets, hasLength(2));
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
      final item = consolidationWithValidAndInvalidAssets();
      final consolidation = item.consolidate().getOrThrow();
      final categoriesCons = consolidation.categoriesConsolidation;
      expect(categoriesCons, hasLength(2));
    });

    test('should correct generate results for stock category', () {
      final item = consolidationWithValidAndInvalidAssets();
      final consolidation = item.consolidate().getOrThrow();
      final categoriesCons = consolidation.categoriesConsolidation;

      final first = categoriesCons.first;
      expect(first.isValid, isTrue);
      expect(first.id, equals(Category.stock.abbreviation));
      expect(first.totalInvested, equals(640.22));
      expect(first.totalInvestedPercentage, equals(50.8406));
      expect(first.totalToday, equals(592.41));
      expect(first.totalTodayPercentage, equals(48.7536));
      expect(first.totalIncomes, equals(15));
      expect(first.balanceSales, equals(160));
    });
  });
}
