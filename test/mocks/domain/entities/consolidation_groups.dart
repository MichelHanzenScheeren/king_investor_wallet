import 'package:king_investor_wallet/src/domain/entities/consolidation_group.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';

import 'assets.dart';

ConsolidationGroup validConsolidationGroup() => ConsolidationGroup(
      id: IdVO('Símbolo1'),
      filteredAssets: [
        validAssetWeg3(),
        validAssetHGRU11(),
        validAssetPSSA3(),
        validAssetXPML11(),
      ],
    );

ConsolidationGroup invalidConsolidationGroup() => ConsolidationGroup(
      id: IdVO('Símbolo2'),
      filteredAssets: [invalidAssetWeg3(), invalidAssetPSSA3()],
    );
