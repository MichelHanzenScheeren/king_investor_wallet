import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_base.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';

class AssetData extends AssetBase {
  PositiveIntegerVO _quantity;
  PositiveNumberVO _averagePrice;
  PositiveIntegerVO _quantitySold;
  PositiveNumberVO _averageSalePrice;
  PositiveNumberVO _income;

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
    PositiveNumberVO? income,
  })  : _quantity = quantity,
        _averagePrice = averagePrice,
        _quantitySold = quantitySold ?? PositiveIntegerVO(0),
        _averageSalePrice = averageSalePrice ?? PositiveNumberVO(0.0),
        _income = income ?? PositiveNumberVO(0.0);

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
  double get income => _income.value;

  @override
  Result<AssetData, String> validate() {
    return super
        .validate()
        .flatMap((success) => _quantity.validate())
        .flatMap((success) => _averagePrice.validate())
        .flatMap((success) => _quantitySold.validate())
        .flatMap((success) => _averageSalePrice.validate())
        .flatMap((success) => _income.validate())
        .pure(this);
  }

  @override
  Result<AssetData, String> update({
    TextVO? name,
    AssetType? type,
    PositiveIntegerVO? quantity,
    PositiveNumberVO? averagePrice,
    PositiveIntegerVO? quantitySold,
    PositiveNumberVO? averageSalePrice,
    PositiveNumberVO? income,
  }) {
    final result = Result<AssetData, String>.success(this)
        .flatMap((_) => _validate(quantity))
        .flatMap((_) => _validate(averagePrice))
        .flatMap((_) => _validate(quantitySold))
        .flatMap((_) => _validate(averageSalePrice))
        .flatMap((_) => _validate(income))
        .pure(this);
    if (result.isError()) return result;
    final fatherUpdate = super.update(name: name, type: type);
    if (fatherUpdate.isError()) return fatherUpdate.pure(this);

    _quantity = quantity ?? _quantity;
    _averagePrice = averagePrice ?? _averagePrice;
    _quantitySold = quantitySold ?? _quantitySold;
    _averageSalePrice = averageSalePrice ?? _averageSalePrice;
    _income = income ?? _income;
    return Success(this);
  }

  Result<AssetData, String> _validate(ValueObject<dynamic>? value) =>
      value?.validate().pure(this) ?? Success(this);

  Result<AssetData, String> registerPurchase({
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

  Result<AssetData, String> _validateQuantity(PositiveIntegerVO quantity) {
    return Result<AssetData, String>.success(this)
        .flatMap((_) => quantity.validate())
        .flatMap((_) => quantity.greaterThanZero())
        .pure(this);
  }

  Result<AssetData, String> _validatePrice(PositiveNumberVO price) {
    return Result<AssetData, String>.success(this)
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

  Result<AssetData, String> registerSale({
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

  Result<AssetData, String> _validateSale(
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

  Result<AssetData, String> registerIncome(PositiveNumberVO newIncome) {
    final result = newIncome.greaterThanZero().pure(this);
    if (result.isError()) return result;
    _income = PositiveNumberVO(_income.value + newIncome.value);
    return Success(this);
  }
}
