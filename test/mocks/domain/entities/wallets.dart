import 'package:king_investor_wallet/src/domain/entities/wallet.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

import 'asset_type_rating_groups.dart';
import 'assets.dart';

Wallet validWallet() => Wallet(
      id: IdVO(null),
      name: TextVO('Carteira principal'),
      isDefault: true,
    );

Wallet validWalletWithAssets() => Wallet(
      id: IdVO(null),
      name: TextVO('Carteira principal'),
      isDefault: false,
      assets: [validAssetWeg3()],
    );

Wallet validWalletWithAssetsAndAssetTypeRatings() => Wallet(
      id: IdVO(null),
      name: TextVO('Carteira principal'),
      isDefault: false,
      assets: [validAssetWeg3(), validAssetHGRU11()],
      typesRatings: validAssetTypeRatingGroup(),
    );

Wallet invalidWalletWithAssetTypeRatings() => Wallet(
      id: IdVO(null),
      name: TextVO('Carteira principal'),
      isDefault: false,
      assets: [validAssetWeg3(), validAssetHGRU11()],
      typesRatings: invalidAssetTypeRatingGroup(),
    );
