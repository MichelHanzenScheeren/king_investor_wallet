import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

import 'quotes.dart';

Asset validAssetWeg3() => Asset(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A'),
      category: Category.stock,
      quantity: PositiveIntegerVO(2),
      averagePrice: PositiveNumberVO(20.5),
      quote: validQuoteWithRandomId1(),
      totalIncomes: PositiveNumberVO(15.0),
      balanceSales: NumberVO(5),
    );

Asset invalidAssetWeg3() => Asset(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A'),
      category: Category.stock,
      quantity: PositiveIntegerVO(-1),
      averagePrice: PositiveNumberVO(20.5),
      quote: invalidQuoteWithInvalidPrice(),
    );

Asset validAssetHGRU11() => Asset(
      symbol: SymbolVO('HGRU11.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('CSHG Renda Urbana Fundo Investimento Imobiliário - FII'),
      category: Category.reit,
      averagePrice: PositiveNumberVO(12.0),
      quantity: PositiveIntegerVO(8),
      quote: validQuoteWithStaticId2(),
      totalIncomes: PositiveNumberVO(10.0),
      balanceSales: NumberVO(-2),
    );

Asset invalidAssetWithInvalidSymbol() => Asset(
      symbol: SymbolVO(''),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A'),
      category: Category.stock,
      quantity: PositiveIntegerVO(-1),
      averagePrice: PositiveNumberVO(20.5),
      quote: invalidQuoteWithInvalidPrice(),
    );

Asset validAssetItub3() => Asset(
      symbol: SymbolVO('ITUB3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('Itaú Unibanco'),
      category: Category.stock,
      quantity: PositiveIntegerVO(6),
      averagePrice: PositiveNumberVO(30.8),
      quote: validQuoteWithRandomId2(),
      totalIncomes: PositiveNumberVO(12.0),
      balanceSales: NumberVO(0),
    );
