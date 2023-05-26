import 'package:king_investor_wallet/src/domain/entities/consolidation_group.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';

import 'assets.dart';

ConsolidationGroup validConsolidationGroup() => ConsolidationGroup(
      discriminator: SymbolVO('Símbolo1'),
      filteredAssets: [validAssetWeg3(), validAssetHGRU11()],
    );

ConsolidationGroup invalidConsolidationGroup() => ConsolidationGroup(
      discriminator: SymbolVO('Símbolo2'),
      filteredAssets: [invalidAssetWithInvalidSymbol()],
    );
