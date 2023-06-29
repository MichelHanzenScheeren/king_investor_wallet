import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_movement.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/rebalancing_error.dart';
import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:result_dart/result_dart.dart';

class RebalancingResult extends Entity {
  final PositiveIntegerVO _maxAssets;
  final PositiveNumberVO _totalMoney;
  final List<AssetMovement> _movements = [];
  int _purchasedQuantity = 0;
  double _purchasedAmount = 0.0;

  RebalancingResult({
    super.id,
    required PositiveIntegerVO maxAssets,
    required PositiveNumberVO totalMoney,
  })  : _maxAssets = maxAssets,
        _totalMoney = totalMoney;

  int get maxAssets => _maxAssets.value;
  double get totalMoney => _totalMoney.value;
  List<AssetMovement> get movements => List.unmodifiable(_movements);
  int get purchasedQuantity => _purchasedQuantity;
  double get purchasedAmount => _purchasedAmount;

  @override
  Result<RebalancingResult, ValidationException> validate() {
    return super
        .validate()
        .flatMap((_) => _totalMoney.validate())
        .flatMap((_) => _totalMoney.greaterThanZero())
        .flatMap((_) => _maxAssets.validate())
        .flatMap((_) => _maxAssets.greaterThanZero())
        .pure(this);
  }

  Result<AssetMovement, RebalancingError> registerMovement(Asset asset) {
    if (!asset.isValid) {
      return const Failure(RebalancingError.invalidAsset);
    } else if (asset.quote.price + purchasedAmount > totalMoney) {
      return const Failure(RebalancingError.exceededCost);
    }
    if (_movements.any((e) => e.symbol == asset.symbol)) {
      final movement = _movements.firstWhere((e) => e.symbol == asset.symbol);
      movement.increaseQuantity(PositiveIntegerVO(1));
      _increasePurchasedAmount(movement.price);
      return Success(movement);
    } else {
      if (_purchasedQuantity + 1 > maxAssets) {
        return const Failure(RebalancingError.exceededQuantity);
      }
      final newMovement = AssetMovement(
        symbol: SymbolVO(asset.symbol),
        price: PositiveNumberVO(asset.quote.price),
        quantity: PositiveIntegerVO(1),
      );
      _addMovement(newMovement);
      _increasePurchasedQuantity();
      _increasePurchasedAmount(asset.quote.price);
      return Success(newMovement);
    }
  }

  void _addMovement(AssetMovement movement) => _movements.add(movement);

  void _increasePurchasedQuantity() => _purchasedQuantity += 1;

  void _increasePurchasedAmount(double price) => _purchasedAmount += price;
}
