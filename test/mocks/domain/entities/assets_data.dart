import 'package:king_investor_wallet/src/domain/entities/asset_data.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

AssetData validAssetDataWeg3() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      type: AssetType.stock,
      averagePrice: PositiveNumberVO(10.0),
      quantity: PositiveIntegerVO(2),
    );

AssetData validAssetDataWeg3WithSale() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      type: AssetType.stock,
      averagePrice: PositiveNumberVO(10.0),
      quantity: PositiveIntegerVO(2),
      quantitySold: PositiveIntegerVO(1),
      averageSalePrice: PositiveNumberVO(15),
    );

AssetData invalidAssetDataWeg3NegativeQuantity() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      type: AssetType.stock,
      averagePrice: PositiveNumberVO(15.0),
      quantity: PositiveIntegerVO(-1),
    );

AssetData validAssetDataWeg3WithIncome() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      type: AssetType.stock,
      averagePrice: PositiveNumberVO(10.0),
      quantity: PositiveIntegerVO(2),
      quantitySold: PositiveIntegerVO(1),
      averageSalePrice: PositiveNumberVO(15),
      income: PositiveNumberVO(20.2),
    );
