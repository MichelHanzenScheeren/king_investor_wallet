import 'package:king_investor_wallet/src/domain/entities/wallet.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

import 'category_rating_groups.dart';
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

Wallet validWalletWithAssetsAndCategoryRatings() => Wallet(
      id: IdVO(null),
      name: TextVO('Carteira principal'),
      isDefault: false,
      assets: [validAssetWeg3(), validAssetHGRU11()],
      categoriesRatings: validDefaultCategoryRatingGroup(),
    );

Wallet invalidWalletWithCategoryRatings() => Wallet(
      id: IdVO(null),
      name: TextVO('Carteira principal'),
      isDefault: false,
      assets: [validAssetWeg3(), validAssetHGRU11()],
      categoriesRatings: invalidCategoryRatingGroup(),
    );
