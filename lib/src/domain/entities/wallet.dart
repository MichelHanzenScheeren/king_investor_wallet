import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_type_rating_group.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:result_dart/result_dart.dart';

class Wallet extends Entity {
  TextVO _name;
  bool _isDefault;
  final List<Asset> _assets;
  final AssetTypeRatingGroup _typesRatings;

  Wallet({
    super.id,
    required TextVO name,
    required bool isDefault,
    List<Asset>? assets,
    AssetTypeRatingGroup? typesRatings,
  })  : _name = name,
        _isDefault = isDefault,
        _assets = assets ?? [],
        _typesRatings = typesRatings ?? AssetTypeRatingGroup.fromDefault();

  String get name => _name.value;
  bool get isDefault => _isDefault;
  List<Asset> get assets => List<Asset>.unmodifiable(_assets);
  AssetTypeRatingGroup get typesRatings => _typesRatings;

  @override
  Result<Wallet, String> validate() {
    return super
        .validate()
        .flatMap((_) => _name.validate())
        .flatMap((_) => _typesRatings.validate())
        .pure(this);
  }

  Result<Wallet, String> update({
    TextVO? name,
    bool? isDefault,
  }) {
    if (name != null && !name.isValid) return name.validate().pure(this);
    _name = name ?? _name;
    _isDefault = isDefault ?? _isDefault;
    return Success(this);
  }

  Result<Wallet, String> addAsset(Asset newAsset) {
    if (!newAsset.isValid) {
      return newAsset.validate().pure(this);
    } else if (_assets.contains(newAsset)) {
      return Failure('O ativo já esta cadastrado (${newAsset.symbol})');
    }
    _assets.add(newAsset);
    return Success(this);
  }

  Result<Wallet, String> removeAsset(String symbol) {
    if (_assets.any((element) => element.symbol == symbol)) {
      _assets.removeWhere((element) => element.symbol == symbol);
      return Success(this);
    }
    return const Failure('Ativo não encontrado');
  }
}
