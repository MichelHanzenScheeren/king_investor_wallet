import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

import 'quotes.dart';

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

Asset invalidAssetPSSA3() => Asset(
      symbol: SymbolVO('PSSA3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('Porto seguro'),
      category: Category.stock,
      quantity: PositiveIntegerVO(null),
      averagePrice: PositiveNumberVO(26.88),
      quote: validQuotePSSA3(),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

Asset validAssetWeg3() => Asset(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A'),
      category: Category.stock,
      quantity: PositiveIntegerVO(9),
      averagePrice: PositiveNumberVO(25.34),
      quote: validQuoteWEGE3(),
      totalIncomes: PositiveNumberVO(15.0),
      balanceSales: NumberVO(-20),
    );

Asset validAssetPSSA3() => Asset(
      symbol: SymbolVO('PSSA3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('Porto seguro'),
      category: Category.stock,
      quantity: PositiveIntegerVO(19),
      averagePrice: PositiveNumberVO(26.88),
      quote: validQuotePSSA3(),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

Asset validAssetMDIA3() => Asset(
      symbol: SymbolVO('MDIA3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('M dias'),
      category: Category.stock,
      quantity: PositiveIntegerVO(10),
      averagePrice: PositiveNumberVO(32.45),
      quote: validQuoteMDIA3(),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

Asset validAssetTOTS3() => Asset(
      symbol: SymbolVO('TOTS3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('TOTS Tecnologia'),
      category: Category.stock,
      quantity: PositiveIntegerVO(10),
      averagePrice: PositiveNumberVO(26.76),
      quote: validQuoteTOTS3(),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

Asset validAssetFLRY3() => Asset(
      symbol: SymbolVO('FLRY3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('Fleury Saúde'),
      category: Category.stock,
      quantity: PositiveIntegerVO(16),
      averagePrice: PositiveNumberVO(25.76),
      quote: validQuoteFLRY3(),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(180),
    );

Asset validAssetHGRU11() => Asset(
      symbol: SymbolVO('HGRU11.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('HGRU Fundos'),
      category: Category.reit,
      quantity: PositiveIntegerVO(5),
      averagePrice: PositiveNumberVO(123.81),
      quote: validQuoteHGRU11(),
      totalIncomes: PositiveNumberVO(25),
      balanceSales: NumberVO(0),
    );

Asset validAssetXPML11() => Asset(
      symbol: SymbolVO('XPML11.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('XPML Fundos'),
      category: Category.reit,
      quantity: PositiveIntegerVO(6),
      averagePrice: PositiveNumberVO(101.57),
      quote: validQuoteXPML11(),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );
