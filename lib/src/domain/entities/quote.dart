import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';

class Quote extends Entity {
  final PositiveNumberVO _price;
  final PositiveNumberVO _high;
  final PositiveNumberVO _low;
  final PositiveNumberVO _yearHigh;
  final PositiveNumberVO _yearLow;
  final NumberVO _changePercentage;
  final NumberVO _changePercentageMonth;
  final NumberVO _changePercentageYear;

  Quote({
    super.id,
    required PositiveNumberVO price,
    required PositiveNumberVO high,
    required PositiveNumberVO low,
    required PositiveNumberVO yearHigh,
    required PositiveNumberVO yearLow,
    required NumberVO changePercentage,
    required NumberVO changePercentageMonth,
    required NumberVO changePercentageYear,
  })  : _price = price,
        _high = high,
        _low = low,
        _yearHigh = yearHigh,
        _yearLow = yearLow,
        _changePercentage = changePercentage,
        _changePercentageMonth = changePercentageMonth,
        _changePercentageYear = changePercentageYear;

  double get price => _price.value;
  double get high => _high.value;
  double get low => _low.value;
  double get yearHigh => _yearHigh.value;
  double get yearLow => _yearLow.value;
  double get changePercentage => _changePercentage.value;
  double get changePercentageMonth => _changePercentageMonth.value;
  double get changePercentageYear => _changePercentageYear.value;
  bool get hasValidPrice => _price.isValid;

  @override
  Result<Quote, String> validate() {
    return super
        .validate()
        .flatMap((success) => _price.validate().pure(this))
        .flatMap((success) => _high.validate().pure(this))
        .flatMap((success) => _low.validate().pure(this))
        .flatMap((success) => _yearHigh.validate().pure(this))
        .flatMap((success) => _yearLow.validate().pure(this))
        .flatMap((success) => _changePercentage.validate().pure(this))
        .flatMap((success) => _changePercentageMonth.validate().pure(this))
        .flatMap((success) => _changePercentageYear.validate().pure(this))
        .pure(this);
  }
}
