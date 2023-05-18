// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:result_dart/result_dart.dart';

import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

class Asset extends Entity {
  SymbolVO symbol;
  SymbolVO currency;
  TextVO name;
  TextVO country;
  AssetType type;
  IntegerVO quantity;
  NumberVO averagePrice;

  Asset({
    required super.id,
    required this.symbol,
    required this.currency,
    required this.name,
    required this.country,
    required this.type,
    required this.quantity,
    required this.averagePrice,
  });

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((success) => symbol.validate())
        .flatMap((success) => currency.validate())
        .flatMap((success) => name.validate())
        .flatMap((success) => country.validate())
        .pure(this);
  }
}
