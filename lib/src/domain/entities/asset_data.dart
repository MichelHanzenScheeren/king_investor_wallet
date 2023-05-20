import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_base.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';

class AssetData extends AssetBase {
  PositiveIntegerVO _quantity;
  PositiveNumberVO _averagePrice;

  AssetData({
    required super.symbol,
    required super.currency,
    required super.country,
    required super.name,
    required super.type,
    required PositiveIntegerVO quantity,
    required PositiveNumberVO averagePrice,
  })  : _quantity = quantity,
        _averagePrice = averagePrice;

  int get quantity => _quantity.value;
  double get averagePrice => _averagePrice.value;

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((success) => _quantity.validate())
        .flatMap((success) => _averagePrice.validate())
        .pure(this);
  }

  Result<Entity, String> registerPurchase({
    required PositiveIntegerVO purchasedQuantity,
    required PositiveNumberVO price,
  }) {
    final validQuantity = _validateQuantity(purchasedQuantity);
    final validPrice = _validatePrice(price);
    if (validQuantity.isSuccess() && validPrice.isSuccess()) {
      final currentTotal = _quantity.value * _averagePrice.value;
      final purchasedTotal = purchasedQuantity.value * price.value;
      final newTotal = currentTotal + purchasedTotal;
      final newQuantity = _quantity.value + purchasedQuantity.value;
      final newAverage = (newTotal) / (newQuantity);

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

  Result<Entity, String> registerSale({
    required PositiveIntegerVO soldQuantity,
  }) {
    final validation = _validateSale(soldQuantity);
    if (validation.isSuccess()) {
      final newQuantity = _quantity.value - soldQuantity.value;
      _quantity = PositiveIntegerVO(newQuantity);
    }
    return validation;
  }

  Result<Entity, String> _validateSale(PositiveIntegerVO soldQuantity) {
    final validation = _validateQuantity(soldQuantity);
    if (validation.isError()) {
      return validation;
    } else if (soldQuantity.value > _quantity.value) {
      return const Failure('A quantidade vendida é maior do que a atual');
    } else {
      return Success(this);
    }
  }
}
