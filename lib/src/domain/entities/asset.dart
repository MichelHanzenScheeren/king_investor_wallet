import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:result_dart/result_dart.dart';

class Asset extends Entity {
  SymbolVO symbol;
  String name;
  String country;
  SymbolVO currency;
  AssetType type;

  Asset({
    required super.id,
    required this.symbol,
    required this.name,
    required this.country,
    required this.currency,
    required this.type,
  });

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((success) => symbol.validate())
        .flatMap((success) => currency.validate())
        .pure(this);
  }
}
