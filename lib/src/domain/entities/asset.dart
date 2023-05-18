import 'package:king_investor_wallet/src/domain/entities/quote.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

class Asset extends Entity {
  final SymbolVO symbol;
  final SymbolVO currency;
  final TextVO country;
  final TextVO name;
  final AssetType type;
  PositiveIntegerVO quantity;
  NumberVO averagePrice;
  Quote? quote;

  Asset({
    required super.id,
    required this.symbol,
    required this.currency,
    required this.country,
    required this.name,
    required this.type,
    required this.quantity,
    required this.averagePrice,
    this.quote,
  });

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((success) => symbol.validate())
        .flatMap((success) => currency.validate())
        .flatMap((success) => country.validate())
        .flatMap((success) => name.validate())
        .flatMap((success) => quantity.validate())
        .flatMap((success) => averagePrice.validate())
        .pure(this);
  }

  bool get hasQuote => quote != null;

  bool get hasValidQuote => quote?.isValid == true;

  // can be used in wallet balancing
  bool get hasBasicFinance =>
      quantity.isValid &&
      quantity.value > 0 &&
      averagePrice.isValid &&
      quote?.hasValidPrice == true;
}
