import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';
import 'package:result_dart/result_dart.dart';

class AssetTypeRating extends Entity {
  final AssetType _type;
  final RatingVO _rating;

  AssetTypeRating({
    super.id,
    required AssetType type,
    required RatingVO rating,
  })  : _type = type,
        _rating = rating;

  AssetTypeRating.asDefault({
    super.id,
    required AssetType type,
  })  : _type = type,
        _rating = RatingVO.asDefault();

  AssetType get type => _type;
  int get rating => _rating.value;

  @override
  Result<AssetTypeRating, String> validate() =>
      super.validate().flatMap((_) => _rating.validate()).pure(this);
}
