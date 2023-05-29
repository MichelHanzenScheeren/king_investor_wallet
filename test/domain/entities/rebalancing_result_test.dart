import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/rebalancing_result.dart';
import 'package:king_investor_wallet/src/domain/enums/rebalancing_error.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';

import '../../mocks/domain/entities/assets.dart';

void main() {
  group('RebalancingResult', () {
    test('should be valid if all valid data', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(1),
        totalMoney: PositiveNumberVO(20),
      );
      expect(item.isValid, isTrue);
    });

    test('should be invalid if maxAssets=0', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(0),
        totalMoney: PositiveNumberVO(20),
      );
      expect(item.isValid, isFalse);
    });

    test('should be invalid if totalMoney=0', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(2),
        totalMoney: PositiveNumberVO(0),
      );
      expect(item.isValid, isFalse);
    });

    test('should register movement if valid situation', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(2),
        totalMoney: PositiveNumberVO(80),
      );
      final asset = validAssetWeg3();
      final response = item.registerMovement(asset);
      expect(response, isA<Success>());
      expect(item.purchasedQuantity, 1);
      expect(item.purchasedAmount, asset.quote.price);
    });

    test(
        'should not increase purchasedQuantity in second purchase of same asset',
        () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(2),
        totalMoney: PositiveNumberVO(80),
      );
      final asset = validAssetWeg3();
      item.registerMovement(asset);
      final response = item.registerMovement(asset);
      expect(response, isA<Success>());
      expect(item.purchasedQuantity, 1);
      expect(item.purchasedAmount, asset.quote.price * 2);
      expect(item.movements.first.quantity, equals(2));
    });

    test('should not register movement if not enough quantity', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(1),
        totalMoney: PositiveNumberVO(80),
      );
      item.registerMovement(validAssetWeg3());
      final response = item.registerMovement(validAssetHGRU11());
      expect(response, isA<Failure>());
      expect(
        response.exceptionOrNull(),
        equals(RebalancingError.exceededQuantity),
      );
      expect(item.purchasedQuantity, 1);
    });

    test('should not register movement if invalid asset', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(1),
        totalMoney: PositiveNumberVO(80),
      );
      final response = item.registerMovement(invalidAssetWeg3());
      expect(response, isA<Failure>());
      expect(
        response.exceptionOrNull(),
        equals(RebalancingError.invalidAsset),
      );
    });

    test('should not register movement if not enough money', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(1),
        totalMoney: PositiveNumberVO(0.5),
      );
      final response = item.registerMovement(validAssetWeg3());
      expect(response, isA<Failure>());
      expect(
        response.exceptionOrNull(),
        equals(RebalancingError.exceededCost),
      );
    });

    test('should correct register movements', () {
      final item = RebalancingResult(
        maxAssets: PositiveIntegerVO(2),
        totalMoney: PositiveNumberVO(100),
      );
      item.registerMovement(validAssetWeg3());
      item.registerMovement(validAssetHGRU11());
      expect(
        item.purchasedAmount,
        equals(validAssetWeg3().quote.price + validAssetHGRU11().quote.price),
      );
      expect(item.purchasedQuantity, equals(2));
      expect(item.movements, hasLength(2));
    });
  });
}
