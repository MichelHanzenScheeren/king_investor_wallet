import 'package:king_investor_wallet/src/domain/entities/asset_data.dart';
import 'package:king_investor_wallet/src/domain/entities/quote.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:result_dart/result_dart.dart';

class Asset extends AssetData {
  final Quote quote;

  Asset({
    required SymbolVO symbol,
    required SymbolVO currency,
    required TextVO country,
    required TextVO name,
    required AssetType type,
    required PositiveIntegerVO quantity,
    required PositiveNumberVO averagePrice,
    PositiveNumberVO? totalSold,
    PositiveNumberVO? totalIncomes,
    required this.quote,
  }) : super(
          symbol: symbol,
          currency: currency,
          country: country,
          name: name,
          type: type,
          quantity: quantity,
          averagePrice: averagePrice,
          totalSold: totalSold,
          totalIncomes: totalIncomes,
        );

  Asset.fromData({
    required AssetData assetData,
    required this.quote,
  }) : super(
          symbol: SymbolVO(assetData.symbol),
          currency: SymbolVO(assetData.currency),
          country: TextVO(assetData.country),
          name: TextVO(assetData.name),
          type: assetData.type,
          quantity: PositiveIntegerVO(assetData.quantity),
          averagePrice: PositiveNumberVO(assetData.averagePrice),
          totalSold: PositiveNumberVO(assetData.totalSold),
          totalIncomes: PositiveNumberVO(assetData.totalIncomes),
        );

  @override
  Result<AssetData, String> validate() {
    return super.validate().flatMap((success) => quote.validate()).pure(this);
  }
}
