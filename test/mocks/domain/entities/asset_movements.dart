import 'package:king_investor_wallet/src/domain/entities/asset_movement.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';

AssetMovement validAssetMovement() => AssetMovement(
      symbol: SymbolVO('itub3'),
      price: PositiveNumberVO(15.5),
      quantity: PositiveIntegerVO(2),
    );

AssetMovement invalidAssetMovementWithInvalidQuantity() => AssetMovement(
      symbol: SymbolVO('itub3'),
      price: PositiveNumberVO(15.5),
      quantity: PositiveIntegerVO(''),
    );
