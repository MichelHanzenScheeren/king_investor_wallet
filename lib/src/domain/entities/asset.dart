import 'package:king_investor_wallet/src/domain/entities/asset_data.dart';
import 'package:king_investor_wallet/src/domain/entities/quote.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';

class Asset extends AssetData {
  final Quote quote;

  Asset({
    required super.symbol,
    required super.currency,
    required super.country,
    required super.name,
    required super.type,
    required super.quantity,
    required super.averagePrice,
    required this.quote,
  });

  Asset.fromData({
    required AssetData assetData,
    required Quote quote,
  }) : this(
          symbol: SymbolVO(assetData.symbol),
          currency: SymbolVO(assetData.currency),
          country: TextVO(assetData.country),
          name: TextVO(assetData.name),
          type: assetData.type,
          quantity: PositiveIntegerVO(assetData.quantity),
          averagePrice: PositiveNumberVO(assetData.averagePrice),
          quote: quote,
        );

  @override
  Result<Entity, String> validate() {
    return super.validate().flatMap((success) => quote.validate()).pure(this);
  }
}
