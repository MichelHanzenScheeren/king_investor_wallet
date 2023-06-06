import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation.dart';
import 'package:king_investor_wallet/src/domain/entities/rebalancing_result.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/utils/round_double.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';
// import '../../mocks/domain/entities/assets.dart';
import '../../mocks/domain/entities/assets.dart';
import '../../mocks/domain/entities/category_rating_groups.dart';
import '../../mocks/domain/entities/rebalances.dart';

void main() {
  group('Rebalancing', () {
    test('should be invalid if created with invalid data', () {
      final item = invalidRebalancingWithInvalidMaxAssets();
      expect(item.isValid, isFalse);
    });

    test('should return failure in rebalance() if created with invalid data',
        () {
      final item = invalidRebalancingWithInvalidMaxAssets();
      final response = item.rebalance();
      expect(response, isA<Failure>());
    });

    test('should be valid if created with valid data', () {
      final item = validRebalancing();
      expect(item.isValid, isTrue);
    });

    test('should return correct ideal rating to categories', () {
      final item = validRebalancing();
      final ideal = item.calculateIdealCategories(
        validDefaultCategoryRatingGroup().categoriesRating,
      );
      expect(ideal, hasLength(Category.values.length));
      expect(ideal[Category.stock.abbreviation]?.value, equals(50));
      expect(ideal[Category.reit.abbreviation]?.value, equals(50));
    });

    test('should return correct rating to cat. when different ratings', () {
      final item = validRebalancing();
      final ideal = item.calculateIdealCategories(item.categoriesRating);
      expect(ideal[Category.stock.abbreviation]?.value, equals(70));
      expect(ideal[Category.reit.abbreviation]?.value, equals(30));
    });

    test('should return correct rating to assets', () {
      final item = validRebalancing();
      final assets = item.assets;
      final ideal = item.calculateIdealAssets(assets);
      expect(
        ideal[assets.first.symbol]?.value,
        equals(roundDouble(100 / assets.length, 4)),
      );
    });

    test('should return correct rating to assets', () {
      final item = validRebalancing();
      final assets = [validAssetWeg3WithDifferentRating(), validAssetPSSA3()];
      final ideal = item.calculateIdealAssets(assets);
      expect(
        ideal[assets[0].symbol]?.value,
        equals(41.1765),
      );
      expect(
        ideal[assets[1].symbol]?.value,
        equals(58.8235),
      );
    });

    test('should keep all categories when ok filterExpressive...', () {
      final item = validRebalancing();
      final result = Consolidation(assets: item.assets).consolidate();
      final consolidation = result.getOrThrow().categoriesConsolidation;
      final valid = item.filterExpressiveConsolidations(consolidation);
      expect(valid, hasLength(2));
    });

    test('should keep valid categories when call filterExpressive...', () {
      final item = validRebalancing();
      final assets = [validAssetWeg3(), validAssetTOTS3(), validAssetFLRY3()];
      final result = Consolidation(assets: assets).consolidate();
      final consolidation = result.getOrThrow().categoriesConsolidation;
      final valid = item.filterExpressiveConsolidations(consolidation);
      expect(valid, hasLength(1));
      expect(valid.first.id, Category.stock.abbreviation);
    });

    test('should return correct biggestDifferenceKey to categories', () {
      final item = validRebalancing();
      final ideal = item.calculateIdealCategories(item.categoriesRating);
      final result = Consolidation(assets: item.assets).consolidate();
      final consolidation = result.getOrThrow().categoriesConsolidation;
      final biggest = item.biggestDifferenceKey(ideal, consolidation);
      expect(biggest, equals(Category.stock.abbreviation));
    });

    test('should correct filterConsolidationItemByCategory - stocks', () {
      final item = validRebalancing();
      final result = Consolidation(assets: item.assets).consolidate();
      final consolidation = result.getOrThrow().allAssetsConsolidation;
      final filtered = item.filterConsolidationItemByCategory(
        Category.stock.abbreviation,
        item.assets,
        consolidation,
      );
      expect(filtered, hasLength(5));
      expect(filtered.any((e) => e.id == validAssetWeg3().symbol), isTrue);
      expect(filtered.any((e) => e.id == validAssetPSSA3().symbol), isTrue);
      expect(filtered.any((e) => e.id == validAssetMDIA3().symbol), isTrue);
      expect(filtered.any((e) => e.id == validAssetTOTS3().symbol), isTrue);
      expect(filtered.any((e) => e.id == validAssetFLRY3().symbol), isTrue);
    });

    test('should correct filterConsolidationItemByCategory - reits', () {
      final item = validRebalancing();
      final result = Consolidation(assets: item.assets).consolidate();
      final consolidation = result.getOrThrow().allAssetsConsolidation;
      final filtered = item.filterConsolidationItemByCategory(
        Category.reit.abbreviation,
        item.assets,
        consolidation,
      );
      expect(filtered, hasLength(2));
      expect(filtered.any((e) => e.id == validAssetHGRU11().symbol), isTrue);
      expect(filtered.any((e) => e.id == validAssetXPML11().symbol), isTrue);
    });

    test('should return correct biggestDifferenceKey to assets', () {
      final item = validRebalancing();
      final ideal = item.calculateIdealAssets(item.assets);
      final result = Consolidation(assets: item.assets).consolidate();
      final consolidation = result.getOrThrow().allAssetsConsolidation;
      final biggest = item.biggestDifferenceKey(ideal, consolidation);
      expect(biggest, equals(validAssetFLRY3().symbol));
    });

    test('should correct limit rebalance', () {
      final item = validRebalancing();
      final assets = List<Asset>.from(item.assets);
      final firstAsset = assets[0];
      final secondAsset = assets[1];
      final rebalanceResult = RebalancingResult(
        maxAssets: PositiveIntegerVO(3),
        totalMoney: PositiveNumberVO(200),
      );
      rebalanceResult.registerMovement(firstAsset);
      rebalanceResult.registerMovement(firstAsset);
      rebalanceResult.registerMovement(secondAsset);
      item.limitedRebalance(assets, rebalanceResult.movements);
      expect(assets, hasLength(2));
      expect(assets.any((e) => e.symbol == firstAsset.symbol), isTrue);
      expect(assets.any((e) => e.symbol == secondAsset.symbol), isTrue);
    });

    test('should correct register movement', () {
      final item = validRebalancing();
      final assets = List<Asset>.from(item.assets);
      final originalAsset = assets[0];
      item.increaseAssetQuantity(assets, assets[0]);
      item.increaseAssetQuantity(assets, assets[0]);
      expect(assets[0].quantity, equals(originalAsset.quantity + 2));
    });

    test('should return success on consolidate with valid data', () {
      final item = validRebalancing();
      final result = item.rebalance();
      expect(result, isA<Success>());
    });

    test('should return correct rebalancing values', () {
      final item = validRebalancing();
      final result = item.rebalance().getOrThrow();
      final movements = result.movements;

      expect(result.purchasedQuantity, equals(3));
      expect(result.purchasedAmount, equals(191.01));

      expect(movements[0].symbol, equals('FLRY3'));
      expect(movements[0].quantity, equals(6));

      expect(movements[1].symbol, equals('TOTS3'));
      expect(movements[1].quantity, equals(2));

      expect(movements[2].symbol, equals('WEGE3'));
      expect(movements[2].quantity, equals(1));
    });

    test('should return correct rebalancing values 2', () {
      final item = validRebalancing2();
      final result = item.rebalance().getOrThrow();
      final movements = result.movements;

      expect(result.purchasedQuantity, equals(3));
      expect(result.purchasedAmount, equals(235.97));

      expect(movements[0].symbol, equals('FLRY3'));
      expect(movements[0].quantity, equals(7));

      expect(movements[1].symbol, equals('TOTS3'));
      expect(movements[1].quantity, equals(3));

      expect(movements[2].symbol, equals('WEGE3'));
      expect(movements[2].quantity, equals(1));
    });

    test('should return correct rebalancing when insufficient money', () {
      final item = validRebalancingWithInsufficientMoney();
      final result = item.rebalance().getOrThrow();
      final movements = result.movements;

      expect(result.purchasedQuantity, equals(0));
      expect(result.purchasedAmount, equals(0.0));
      expect(movements, hasLength(0));
    });

    test('should return correct rebalancing when only stocks', () {
      final item = validRebalancingWithOnlyAssets();
      final result = item.rebalance().getOrThrow();
      final movements = result.movements;

      expect(result.purchasedQuantity, equals(1));
      expect(result.purchasedAmount, equals(31.74));
      expect(movements, hasLength(1));
    });

    test('should return correct rebalancing when throw cost error', () {
      final item = validRebalancingWillThrowExceedCostError();
      final result = item.rebalance().getOrThrow();
      final movements = result.movements;

      expect(result.purchasedQuantity, equals(1));
      expect(result.purchasedAmount, equals(63.48));
      expect(movements, hasLength(1));
      expect(movements.first.quantity, equals(4));
    });
  });
}
