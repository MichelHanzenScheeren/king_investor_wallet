import 'package:king_investor_wallet/src/domain/entities/asset_data.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

AssetData validAssetDataWeg3() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      category: Category.stock,
      averagePrice: PositiveNumberVO(10.0),
      quantity: PositiveIntegerVO(2),
    );

AssetData validAssetDataWeg3WithSale() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      category: Category.stock,
      averagePrice: PositiveNumberVO(10.0),
      quantity: PositiveIntegerVO(10),
      balanceSales: PositiveNumberVO(20.0),
    );

AssetData invalidAssetDataWeg3NegativeQuantity() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      category: Category.stock,
      averagePrice: PositiveNumberVO(15.0),
      quantity: PositiveIntegerVO(-1),
    );

AssetData validAssetDataWeg3WithIncome() => AssetData(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      category: Category.stock,
      averagePrice: PositiveNumberVO(10.0),
      quantity: PositiveIntegerVO(2),
      balanceSales: PositiveNumberVO(15),
      totalIncomes: PositiveNumberVO(20.2),
    );
