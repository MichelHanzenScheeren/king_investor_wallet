import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_data.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';
import '../../mocks/domain/entities/assets_base.dart';
import '../../mocks/domain/entities/assets_data.dart';

const greaterThanZero = 'Valor deve ser maior do que zero';
const greaterThanCurrent = 'A quantidade vendida é maior do que a atual';

void main() {
  group('AssetsData', () {
    test('should be valid when created with valid data', () {
      final item = validAssetDataWeg3();
      expect(item.isValid, isTrue);
    });

    test('should be invalid when created with invalid data', () {
      final item = invalidAssetDataWeg3NegativeQuantity();
      expect(item.isValid, isFalse);
    });

    test('should be valid when create with named parameter', () {
      final item = AssetData.fromBase(
        assetBase: validAssetBaseWeg3(),
        averagePrice: PositiveNumberVO(50.0),
        quantity: PositiveIntegerVO(15),
      );
      expect(item.isValid, isTrue);
      expect(item, equals(validAssetDataWeg3()));
    });

    test('should have default values to sales when none was passed', () {
      final item = validAssetDataWeg3();
      expect(item.quantitySold, equals(0));
      expect(item.averageSalePrice, equals(0.0));
    });

    test('should have default values to sales (named constructor)', () {
      final item = AssetData.fromBase(
        assetBase: validAssetBaseWeg3(),
        averagePrice: PositiveNumberVO(50.0),
        quantity: PositiveIntegerVO(15),
      );
      expect(item.quantitySold, equals(0));
      expect(item.averageSalePrice, equals(0.0));
    });

    test('should save values when passed', () {
      final item = validAssetDataWeg3WithSale();
      expect(item.quantitySold, equals(1));
      expect(item.averageSalePrice, equals(15));
    });

    test('should not update when pass invalid qtd to registerPurchase', () {
      final item = validAssetDataWeg3();
      final response = item.registerPurchase(
        transactionQuantity: PositiveIntegerVO(0),
        price: PositiveNumberVO(10.4),
      );
      expect(response, isA<Failure>());
      expect(response.exceptionOrNull(), equals(greaterThanZero));
      expect(item.quantity, equals(2));
      expect(item.averagePrice, equals(10.0));
    });

    test('should not update when pass invalid price to registerPurchase', () {
      final item = validAssetDataWeg3();
      final response = item.registerPurchase(
        transactionQuantity: PositiveIntegerVO(2),
        price: PositiveNumberVO(0),
      );
      expect(response, isA<Failure>());
      expect(response.exceptionOrNull(), equals(greaterThanZero));
      expect(item.quantity, equals(2));
      expect(item.averagePrice, equals(10.0));
    });

    test('should update when pass valid data to registerPurchase', () {
      final item = validAssetDataWeg3();
      final response = item.registerPurchase(
        transactionQuantity: PositiveIntegerVO(6),
        price: PositiveNumberVO(20),
      );
      expect(response, isA<Success>());
      expect(item.quantity, equals(8));
      expect(item.averagePrice, equals(17.5));
    });

    test('should not update when pass invalid qtd to registerSale', () {
      final item = validAssetDataWeg3();
      final response = item.registerSale(
        transactionQuantity: PositiveIntegerVO(0),
        price: PositiveNumberVO(15.0),
      );
      expect(response, isA<Failure>());
      expect(response.exceptionOrNull(), equals(greaterThanZero));
      expect(item.quantity, equals(2));
    });

    test('should not update when pass invalid price to registerSale', () {
      final item = validAssetDataWeg3();
      final response = item.registerSale(
        transactionQuantity: PositiveIntegerVO(1),
        price: PositiveNumberVO(0),
      );
      expect(response, isA<Failure>());
      expect(response.exceptionOrNull(), equals(greaterThanZero));
      expect(item.quantity, equals(2));
    });

    test('should not update when pass quantity bigger than current', () {
      final item = validAssetDataWeg3();
      final response = item.registerSale(
        transactionQuantity: PositiveIntegerVO(15),
        price: PositiveNumberVO(15.0),
      );
      expect(response, isA<Failure>());
      expect(response.exceptionOrNull(), equals(greaterThanCurrent));
      expect(item.quantity, equals(2));
    });

    test('should update values when pass valid quantity', () {
      final item = validAssetDataWeg3();
      final response = item.registerSale(
        transactionQuantity: PositiveIntegerVO(1),
        price: PositiveNumberVO(15.0),
      );
      expect(response, isA<Success>());
      expect(item.quantity, equals(1));
      expect(item.quantitySold, equals(1));
      expect(item.averageSalePrice, equals(15.0));
    });
  });
}
