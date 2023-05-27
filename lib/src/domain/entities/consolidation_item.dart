// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';

class ConsolidationItem extends Entity {
  final PositiveNumberVO _totalInvested;
  final PositiveNumberVO _totalInvestedPercentage;
  final PositiveNumberVO _totalToday;
  final PositiveNumberVO _totalTodayPercentage;
  final PositiveNumberVO _totalIncomes;
  final NumberVO _balanceSales;
  late final NumberVO _valorization;
  late final NumberVO _valorizationPercentage;
  late final NumberVO _result;
  late final NumberVO _resultPercentage;

  ConsolidationItem({
    required super.id,
    required PositiveNumberVO totalInvested,
    required PositiveNumberVO totalInvestedPercentage,
    required PositiveNumberVO totalToday,
    required PositiveNumberVO totalTodayPercentage,
    required PositiveNumberVO totalIncomes,
    required NumberVO balanceSales,
  })  : _totalInvested = totalInvested,
        _totalInvestedPercentage = totalInvestedPercentage,
        _totalToday = totalToday,
        _totalTodayPercentage = totalTodayPercentage,
        _totalIncomes = totalIncomes,
        _balanceSales = balanceSales {
    final double invested = totalInvested.value;
    final double valorization = totalToday.value - invested;
    _valorization = NumberVO(valorization);
    _valorizationPercentage = NumberVO(valorization * 100 / invested);
    _result = NumberVO(valorization + totalIncomes.value + balanceSales.value);
    _resultPercentage = NumberVO(_result.value * 100 / invested);
  }

  double get totalInvested => _totalInvested.value;
  double get totalInvestedPercentage => _totalInvestedPercentage.value;
  double get totalToday => _totalToday.value;
  double get totalTodayPercentage => _totalTodayPercentage.value;
  double get totalIncomes => _totalIncomes.value;
  double get balanceSales => _balanceSales.value;
  double get valorization => _valorization.value;
  double get valorizationPercentage => _valorizationPercentage.value;
  double get result => _result.value;
  double get resultPercentage => _resultPercentage.value;

  @override
  Result<ConsolidationItem, String> validate() {
    return super
        .validate()
        .flatMap((_) => _totalInvested.validate())
        .flatMap((_) => _totalInvestedPercentage.validate())
        .flatMap((_) => _totalToday.validate())
        .flatMap((_) => _totalTodayPercentage.validate())
        .flatMap((_) => _valorization.validate())
        .flatMap((_) => _valorizationPercentage.validate())
        .flatMap((_) => _totalIncomes.validate())
        .flatMap((_) => _balanceSales.validate())
        .flatMap((_) => _result.validate())
        .flatMap((_) => _resultPercentage.validate())
        .pure(this);
  }
}
