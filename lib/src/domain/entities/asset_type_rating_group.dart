import 'package:king_investor_wallet/src/domain/entities/asset_type_rating.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:result_dart/result_dart.dart';

class AssetTypeRatingGroup extends Entity {
  late List<AssetTypeRating> _typesRating;

  AssetTypeRatingGroup({super.id, required List<AssetTypeRating> typesRating}) {
    _typesRating = _fixTypesRating(typesRating);
  }

  AssetTypeRatingGroup.fromDefault() {
    _typesRating = _generateDefaultTypesRating();
  }

  List<AssetTypeRating> get typesRating => List.unmodifiable(_typesRating);

  List<AssetTypeRating> _fixTypesRating(List<AssetTypeRating> typesRating) {
    if (typesRating.toSet().length == AssetType.values.length) {
      return typesRating;
    }
    return List.from(AssetType.values.map<AssetTypeRating>(
      (type) => typesRating.firstWhere(
        (item) => item.type == type,
        orElse: () => AssetTypeRating.asDefault(type: type),
      ),
    ));
  }

  List<AssetTypeRating> _generateDefaultTypesRating() {
    return List.from(
      AssetType.values.map<AssetTypeRating>(
        (e) => AssetTypeRating.asDefault(type: e),
      ),
    );
  }

  @override
  Result<AssetTypeRatingGroup, String> validate() {
    return super.validate().flatMap((_) => _localValidate()).pure(this);
  }

  Result<AssetTypeRatingGroup, String> _localValidate() {
    return _typesRating.map((e) => e.validate().pure(this)).firstWhere(
          (element) => element.isError(),
          orElse: () => Success(this),
        );
  }
}
