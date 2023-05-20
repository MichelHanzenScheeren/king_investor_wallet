import 'package:king_investor_wallet/src/domain/entities/asset_base.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

AssetBase validAssetBaseWeg3() => AssetBase(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('WEG S.A.'),
      type: AssetType.stock,
    );

AssetBase invalidAssetBaseWeg3NullName() => AssetBase(
      symbol: SymbolVO('WEGE3.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO(null),
      type: AssetType.stock,
    );

AssetBase validAssetBaseHGRU11() => AssetBase(
      symbol: SymbolVO('HGRU11.SAO'),
      currency: SymbolVO('BRL'),
      country: TextVO('Brazil'),
      name: TextVO('CSHG Renda Urbana Fundo Investimento Imobiliário - FII'),
      type: AssetType.reit,
    );

AssetBase invalidAssetBaseHGRU11EmptyCurrency() => AssetBase(
      symbol: SymbolVO('HGRU11.SAO'),
      currency: SymbolVO(''),
      country: TextVO('Brazil'),
      name: TextVO('CSHG Renda Urbana Fundo Investimento Imobiliário - FII'),
      type: AssetType.reit,
    );
