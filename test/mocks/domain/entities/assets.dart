import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

import 'quotes.dart';

final validAssetWeg3 = Asset(
  symbol: SymbolVO('WEGE3.SAO'),
  currency: SymbolVO('BRL'),
  country: TextVO('Brazil'),
  name: TextVO('WEG S.A'),
  type: AssetType.stock,
  quantity: PositiveIntegerVO(2),
  averagePrice: PositiveNumberVO(20.5),
  quote: validQuoteWithRandomId1(),
);

final invalidAssetWeg3 = Asset(
  symbol: SymbolVO('WEGE3.SAO'),
  currency: SymbolVO('BRL'),
  country: TextVO('Brazil'),
  name: TextVO('WEG S.A'),
  type: AssetType.stock,
  quantity: PositiveIntegerVO(-1),
  averagePrice: PositiveNumberVO(20.5),
  quote: invalidQuoteWithInvalidPrice(),
);
