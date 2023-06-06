import 'package:king_investor_wallet/src/domain/entities/rebalancing.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';

import 'assets.dart';
import 'category_rating_groups.dart';

final assets = [
  validAssetWeg3(),
  validAssetTOTS3(),
  validAssetFLRY3(),
  validAssetHGRU11(),
  validAssetMDIA3(),
  validAssetXPML11(),
  validAssetPSSA3(),
];

Rebalancing validRebalancing() => Rebalancing(
      assets: assets,
      categoriesRatingGroup: validCategoryRatingGroupWithPersonalRatings(),
      maxAssets: PositiveIntegerVO(3),
      totalMoney: PositiveNumberVO(200),
    );

Rebalancing validRebalancing2() => Rebalancing(
      assets: assets,
      categoriesRatingGroup: validCategoryRatingGroupWithPersonalRatings(),
      maxAssets: PositiveIntegerVO(3),
      totalMoney: PositiveNumberVO(240),
    );

Rebalancing validRebalancingWithInsufficientMoney() => Rebalancing(
      assets: assets,
      categoriesRatingGroup: validCategoryRatingGroupWithPersonalRatings(),
      maxAssets: PositiveIntegerVO(2),
      totalMoney: PositiveNumberVO(10),
    );

Rebalancing validRebalancingWithOnlyAssets() => Rebalancing(
      assets: [
        validAssetWeg3(),
        validAssetTOTS3(),
        validAssetFLRY3(),
        validAssetMDIA3(),
        validAssetPSSA3(),
      ],
      categoriesRatingGroup: validCategoryRatingGroupWithPersonalRatings(),
      maxAssets: PositiveIntegerVO(3),
      totalMoney: PositiveNumberVO(35),
    );

Rebalancing validRebalancingWillThrowExceedCostError() => Rebalancing(
      assets: assets,
      categoriesRatingGroup: validCategoryRatingGroupWithPersonalRatings(),
      maxAssets: PositiveIntegerVO(3),
      totalMoney: PositiveNumberVO(64),
    );

Rebalancing invalidRebalancingWithInvalidMaxAssets() => Rebalancing(
      assets: [validAssetWeg3(), validAssetFLRY3(), validAssetHGRU11()],
      categoriesRatingGroup: validDefaultCategoryRatingGroup(),
      maxAssets: PositiveIntegerVO(0),
      totalMoney: PositiveNumberVO(50),
    );
