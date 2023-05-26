import 'package:king_investor_wallet/src/domain/entities/asset_type_rating.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_type_rating_group.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';

AssetTypeRatingGroup validAssetTypeRatingGroup() => AssetTypeRatingGroup(
      typesRating: [
        AssetTypeRating.asDefault(type: AssetType.stock),
        AssetTypeRating.asDefault(type: AssetType.reit),
      ],
    );

AssetTypeRatingGroup partialAssetTypeRatingGroup() => AssetTypeRatingGroup(
      typesRating: [
        AssetTypeRating.asDefault(type: AssetType.stock),
      ],
    );

AssetTypeRatingGroup invalidAssetTypeRatingGroup() => AssetTypeRatingGroup(
      typesRating: [
        AssetTypeRating.asDefault(type: AssetType.stock),
        AssetTypeRating(type: AssetType.reit, rating: RatingVO(-1)),
      ],
    );
