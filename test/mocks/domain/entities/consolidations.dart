import 'package:king_investor_wallet/src/domain/entities/consolidation.dart';
import 'assets.dart';

Consolidation consolidationWithValidAndInvalidAssets() => Consolidation(
      assets: [
        validAssetWeg3(),
        invalidAssetWeg3(),
        validAssetHGRU11(),
        validAssetFLRY3(),
        invalidAssetPSSA3(),
      ],
    );

Consolidation consolidationWithOnlyInvalidAssets() => Consolidation(
      assets: [
        invalidAssetPSSA3(),
        invalidAssetWeg3(),
      ],
    );
