import 'package:flutter_test/flutter_test.dart';
import '../../mocks/domain/entities/assets_base.dart';
import '../../mocks/domain/entities/consolidation_items.dart';

void main() {
  group('ConsolidationItem', () {
    test('should be valid when created (incomes=sales=0; valorization +)', () {
      final item = validConsolidationItemWithValorization();
      expect(item.isValid, isTrue);
      expect(item.valorization, equals(50));
      expect(item.valorizationPercentage, equals(20));
      expect(item.result, equals(50));
      expect(item.resultPercentage, equals(20));
    });

    test('should be valid when created (incomes=sales=0; valorization -)', () {
      final item = validConsolidationItemWithDevaluation();
      expect(item.isValid, isTrue);
      expect(item.valorization, equals(-30));
      expect(item.valorizationPercentage, equals(-20));
      expect(item.result, equals(-30));
      expect(item.resultPercentage, equals(-20));
    });

    test('should be valid when created (with sales)', () {
      final item = validConsolidationItemWithSalesLosses();
      expect(item.isValid, isTrue);
      expect(item.valorization, equals(90));
      expect(item.valorizationPercentage.toStringAsFixed(2), equals('21.43'));
      expect(item.result, equals(-140));
      expect(item.resultPercentage.toStringAsFixed(2), equals('-33.33'));
    });

    test('should be valid when created (with incomes)', () {
      final item = validConsolidationItemWithIncomes();
      expect(item.isValid, isTrue);
      expect(item.valorization, equals(300));
      expect(item.valorizationPercentage, equals(60));
      expect(item.result, equals(500));
      expect(item.resultPercentage, equals(100));
    });

    test('should be valid when created (with incomes)', () {
      final item = invalidConsolidation();
      expect(item.isValid, isFalse);
    });

    test('should return true on comparison with correspondent asset', () {
      final item = validConsolidationItemWithValorization();
      expect(item, equals(validAssetBaseWeg3()));
    });
  });
}
