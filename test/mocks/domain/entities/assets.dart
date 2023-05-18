import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'quotes.dart';

final validAssetWeg3 = Asset(
  id: IdVO(null),
  symbol: SymbolVO('WEGE3.SAO'),
  currency: SymbolVO('BRL'),
  country: TextVO('Brazil'),
  name: TextVO('WEG S.A'),
  type: AssetType.stock,
  quantity: PositiveIntegerVO(2),
  averagePrice: NumberVO(20.5),
  quote: validQuoteWithRandomId1,
);

final validAssetWeg3WithNullQuote = Asset(
  id: IdVO(null),
  symbol: SymbolVO('WEGE3.SAO'),
  currency: SymbolVO('BRL'),
  country: TextVO('Brazil'),
  name: TextVO('WEG S.A'),
  type: AssetType.stock,
  quantity: PositiveIntegerVO(2),
  averagePrice: NumberVO(20.5),
);

final validAssetWeg3WithInvalidQuoteAndValidPrice = Asset(
  id: IdVO(null),
  symbol: SymbolVO('WEGE3.SAO'),
  currency: SymbolVO('BRL'),
  country: TextVO('Brazil'),
  name: TextVO('WEG S.A'),
  type: AssetType.stock,
  quantity: PositiveIntegerVO(2),
  averagePrice: NumberVO(20.5),
  quote: invalidQuoteWithRandomId1,
);

final validAssetWeg3WithInvalidQuoteAndInvalidPrice = Asset(
  id: IdVO(null),
  symbol: SymbolVO('WEGE3.SAO'),
  currency: SymbolVO('BRL'),
  country: TextVO('Brazil'),
  name: TextVO('WEG S.A'),
  type: AssetType.stock,
  quantity: PositiveIntegerVO(2),
  averagePrice: NumberVO(20.5),
  quote: invalidQuoteWithInvalidPrice,
);

final invalidAssetWeg3 = Asset(
  id: IdVO(null),
  symbol: SymbolVO('WEGE3.SAO'),
  currency: SymbolVO('BRL'),
  country: TextVO('Brazil'),
  name: TextVO('WEG S.A'),
  type: AssetType.stock,
  quantity: PositiveIntegerVO(-1),
  averagePrice: NumberVO(20.5),
  quote: invalidQuoteWithInvalidPrice,
);
