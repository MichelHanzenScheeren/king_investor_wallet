import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';

class Quote extends Entity {
  final PositiveNumberVO price;
  final PositiveNumberVO high;
  final PositiveNumberVO low;
  final PositiveNumberVO yearHigh;
  final PositiveNumberVO yearLow;
  final NumberVO changePercentage;
  final NumberVO changePercentageMonth;
  final NumberVO changePercentageYear;

  Quote({
    required super.id,
    required this.price,
    required this.high,
    required this.low,
    required this.yearHigh,
    required this.yearLow,
    required this.changePercentage,
    required this.changePercentageMonth,
    required this.changePercentageYear,
  });

  bool get hasValidPrice => price.isValid;

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((success) => price.validate().pure(this))
        .flatMap((success) => high.validate().pure(this))
        .flatMap((success) => low.validate().pure(this))
        .flatMap((success) => yearHigh.validate().pure(this))
        .flatMap((success) => yearLow.validate().pure(this))
        .flatMap((success) => changePercentage.validate().pure(this))
        .flatMap((success) => changePercentageMonth.validate().pure(this))
        .flatMap((success) => changePercentageYear.validate().pure(this))
        .pure(this);
  }
}
