import 'package:king_investor_wallet/src/domain/entities/consolidation.dart';
import 'assets.dart';

Consolidation consolidationWithValidAndInvalidAssets() => Consolidation(
      assets: [
        validAssetWeg3(),
        invalidAssetWithInvalidSymbol(),
        invalidAssetWeg3(),
        validAssetHGRU11(),
        invalidAssetWeg3(),
      ],
    );

Consolidation consolidationWithOnlyInvalidAssets() => Consolidation(
      assets: [
        invalidAssetWithInvalidSymbol(),
        invalidAssetWeg3(),
      ],
    );

Consolidation consolidationWithValidAndInvalidAssets2() => Consolidation(
      assets: [
        validAssetWeg3(),
        invalidAssetWeg3(),
        validAssetHGRU11(),
        validAssetItub3(),
      ],
    );
