import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_base.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';

class AssetData extends AssetBase {
  PositiveIntegerVO _quantity;
  PositiveNumberVO _averagePrice;
  PositiveIntegerVO _quantitySold;
  PositiveNumberVO _averageSalePrice;

  AssetData({
    required super.symbol,
    required super.currency,
    required super.country,
    required super.name,
    required super.type,
    required PositiveIntegerVO quantity,
    required PositiveNumberVO averagePrice,
    PositiveIntegerVO? quantitySold,
    PositiveNumberVO? averageSalePrice,
  })  : _quantity = quantity,
        _averagePrice = averagePrice,
        _quantitySold = quantitySold ?? PositiveIntegerVO(0),
        _averageSalePrice = averageSalePrice ?? PositiveNumberVO(0.0);

  AssetData.fromBase(
      {required AssetBase assetBase,
      required PositiveIntegerVO quantity,
      required PositiveNumberVO averagePrice,
      PositiveIntegerVO? quantitySold,
      PositiveNumberVO? averageSalePrice})
      : this(
          symbol: SymbolVO(assetBase.symbol),
          currency: SymbolVO(assetBase.currency),
          country: TextVO(assetBase.country),
          name: TextVO(assetBase.name),
          type: assetBase.type,
          quantity: quantity,
          averagePrice: averagePrice,
          quantitySold: quantitySold,
          averageSalePrice: averageSalePrice,
        );

  int get quantity => _quantity.value;
  double get averagePrice => _averagePrice.value;
  int get quantitySold => _quantitySold.value;
  double get averageSalePrice => _averageSalePrice.value;

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((success) => _quantity.validate())
        .flatMap((success) => _averagePrice.validate())
        .pure(this);
  }

  Result<Entity, String> registerPurchase({
    required PositiveIntegerVO transactionQuantity,
    required PositiveNumberVO price,
  }) {
    final validQuantity = _validateQuantity(transactionQuantity);
    final validPrice = _validatePrice(price);
    if (validQuantity.isSuccess() && validPrice.isSuccess()) {
      final newQuantity = _quantity.value + transactionQuantity.value;
      final newAverage = _calculateNewPrice(
        _averagePrice.value,
        _quantity.value,
        price.value,
        transactionQuantity.value,
      );
      _quantity = PositiveIntegerVO(newQuantity);
      _averagePrice = PositiveNumberVO(newAverage);
    }
    return validQuantity.flatMap((_) => validPrice);
  }

  Result<Entity, String> _validateQuantity(PositiveIntegerVO quantity) {
    return Result<Entity, String>.success(this)
        .flatMap((_) => quantity.validate())
        .flatMap((_) => quantity.greaterThanZero())
        .pure(this);
  }

  Result<Entity, String> _validatePrice(PositiveNumberVO price) {
    return Result<Entity, String>.success(this)
        .flatMap((_) => price.validate())
        .flatMap((_) => price.greaterThanZero())
        .pure(this);
  }

  double _calculateNewPrice(
    double currentPrice,
    int currentQuantity,
    double transactionPrice,
    int transactionQuantity,
  ) {
    final currentTotal = currentPrice * currentQuantity;
    final transactionTotal = transactionPrice * transactionQuantity;
    final newTotal = currentTotal + transactionTotal;
    final newAverage = (newTotal) / (currentQuantity + transactionQuantity);
    return newAverage;
  }

  Result<Entity, String> registerSale({
    required PositiveIntegerVO transactionQuantity,
    required PositiveNumberVO price,
  }) {
    final validation = _validateSale(transactionQuantity, price);
    if (validation.isSuccess()) {
      final newQuantity = _quantity.value - transactionQuantity.value;
      _quantity = PositiveIntegerVO(newQuantity);

      final newSoldQuantity = _quantitySold.value + transactionQuantity.value;
      final newAverageSoldPrice = _calculateNewPrice(
        _averageSalePrice.value,
        _quantitySold.value,
        price.value,
        transactionQuantity.value,
      );
      _quantitySold = PositiveIntegerVO(newSoldQuantity);
      _averageSalePrice = PositiveNumberVO(newAverageSoldPrice);
    }
    return validation;
  }

  Result<Entity, String> _validateSale(
    PositiveIntegerVO soldAmount,
    PositiveNumberVO price,
  ) {
    final quantityValidation = _validateQuantity(soldAmount);
    final priceValidation = _validatePrice(price);

    if (quantityValidation.isError()) {
      return quantityValidation;
    } else if (priceValidation.isError()) {
      return priceValidation;
    } else if (soldAmount.value > _quantity.value) {
      return const Failure('A quantidade vendida é maior do que a atual');
    } else {
      return Success(this);
    }
  }
}
