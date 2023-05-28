// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:result_dart/result_dart.dart';

class AssetMovement extends Entity {
  final SymbolVO _symbol;
  final PositiveNumberVO _price;
  PositiveIntegerVO _quantity;

  AssetMovement({
    required SymbolVO symbol,
    required PositiveNumberVO price,
    required PositiveIntegerVO quantity,
  })  : _symbol = symbol,
        _price = price,
        _quantity = quantity,
        super(id: IdVO(symbol.value));

  String get symbol => _symbol.value;
  double get price => _price.value;
  int get quantity => _quantity.value;
  double get total => price * quantity;

  @override
  Result<AssetMovement, String> validate() => super
      .validate()
      .flatMap((_) => _symbol.validate())
      .flatMap((_) => _price.validate())
      .flatMap((_) => _quantity.validate())
      .pure(this);

  void increaseQuantity(PositiveIntegerVO increaseQuantity) {
    _quantity = PositiveIntegerVO(quantity + increaseQuantity.value);
  }
}
