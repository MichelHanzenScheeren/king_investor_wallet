import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

class AssetBase extends Entity {
  final SymbolVO _symbol;
  final SymbolVO _currency;
  final TextVO _country;
  TextVO _name;
  AssetType _type;

  String get symbol => _symbol.value;
  String get currency => _currency.value;
  String get country => _country.value;
  String get name => _name.value;
  AssetType get type => _type;

  AssetBase({
    required SymbolVO symbol,
    required SymbolVO currency,
    required TextVO country,
    required TextVO name,
    required AssetType type,
  })  : _symbol = symbol,
        _currency = currency,
        _country = country,
        _name = name,
        _type = type,
        super(id: IdVO(symbol.value));

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((success) => _symbol.validate())
        .flatMap((success) => _currency.validate())
        .flatMap((success) => _country.validate())
        .flatMap((success) => _name.validate())
        .pure(this);
  }

  Result<Entity, String> update({TextVO? name, AssetType? type}) {
    bool changed = false;
    if (name != null && !name.isValid) {
      return name.validate().pure(this);
    }
    if (name != null && name != _name) {
      _name = name;
      changed = true;
    }
    if (type != null && type != _type) {
      _type = type;
      changed = true;
    }
    return changed
        ? Success(this)
        : const Failure('Nenhuma informação modificada');
  }
}
