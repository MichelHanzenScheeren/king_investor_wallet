import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
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
  PositiveNumberVO _totalIncomes;
  NumberVO _balanceSales;

  AssetData({
    required super.symbol,
    required super.currency,
    required super.country,
    required super.name,
    required super.type,
    required PositiveIntegerVO quantity,
    required PositiveNumberVO averagePrice,
    PositiveNumberVO? totalIncomes,
    NumberVO? balanceSales,
  })  : _quantity = quantity,
        _averagePrice = averagePrice,
        _totalIncomes = totalIncomes ?? PositiveNumberVO(0.0),
        _balanceSales = balanceSales ?? NumberVO(0.0);

  AssetData.fromBase({
    required AssetBase assetBase,
    required PositiveIntegerVO quantity,
    required PositiveNumberVO averagePrice,
    PositiveNumberVO? totalIncomes,
    NumberVO? balanceSales,
  }) : this(
          symbol: SymbolVO(assetBase.symbol),
          currency: SymbolVO(assetBase.currency),
          country: TextVO(assetBase.country),
          name: TextVO(assetBase.name),
          type: assetBase.type,
          quantity: quantity,
          averagePrice: averagePrice,
          totalIncomes: totalIncomes,
          balanceSales: balanceSales,
        );

  int get quantity => _quantity.value;
  double get averagePrice => _averagePrice.value;
  double get totalIncomes => _totalIncomes.value;
  double get balanceSales => _balanceSales.value;

  @override
  Result<AssetData, String> validate() {
    return super
        .validate()
        .flatMap((success) => _quantity.validate())
        .flatMap((success) => _averagePrice.validate())
        .flatMap((success) => _totalIncomes.validate())
        .flatMap((success) => _balanceSales.validate())
        .pure(this);
  }

  @override
  Result<AssetData, String> update({
    TextVO? name,
    AssetType? type,
    PositiveIntegerVO? quantity,
    PositiveNumberVO? averagePrice,
    PositiveNumberVO? totalIncomes,
    NumberVO? balanceSales,
  }) {
    final result = Result<AssetData, String>.success(this)
        .flatMap((_) => _validate(quantity))
        .flatMap((_) => _validate(averagePrice))
        .flatMap((_) => _validate(totalIncomes))
        .flatMap((_) => _validate(balanceSales))
        .pure(this);
    if (result.isError()) return result;
    final fatherUpdate = super.update(name: name, type: type);
    if (fatherUpdate.isError()) return fatherUpdate.pure(this);

    _quantity = quantity ?? _quantity;
    _averagePrice = averagePrice ?? _averagePrice;
    _totalIncomes = totalIncomes ?? _totalIncomes;
    _balanceSales = balanceSales ?? _balanceSales;
    return Success(this);
  }

  Result<AssetData, String> _validate(ValueObject<dynamic>? value) =>
      value?.validate().pure(this) ?? Success(this);

  Result<AssetData, String> registerIncome(PositiveNumberVO newIncome) {
    final result = newIncome.greaterThanZero().pure(this);
    if (result.isError()) return result;
    _totalIncomes = PositiveNumberVO(_totalIncomes.value + newIncome.value);
    return Success(this);
  }

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

      final soldValue = transactionQuantity.value * price.value;
      final boughtValue = transactionQuantity.value * _averagePrice.value;
      _balanceSales = NumberVO(balanceSales + soldValue - boughtValue);
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
}
