import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

class AssetBase extends Entity {
  final SymbolVO _symbol;
  final SymbolVO _currency;
  final TextVO _country;
  TextVO _name;
  Category _category;

  String get symbol => _symbol.value;
  String get currency => _currency.value;
  String get country => _country.value;
  String get name => _name.value;
  Category get category => _category;

  AssetBase({
    required SymbolVO symbol,
    required SymbolVO currency,
    required TextVO country,
    required TextVO name,
    required Category category,
  })  : _symbol = symbol,
        _currency = currency,
        _country = country,
        _name = name,
        _category = category,
        super(id: IdVO(symbol.value));

  @override
  Result<AssetBase, ValidationException> validate() {
    return super
        .validate()
        .flatMap((success) => _symbol.validate())
        .flatMap((success) => _currency.validate())
        .flatMap((success) => _country.validate())
        .flatMap((success) => _name.validate())
        .pure(this);
  }

  Result<AssetBase, ValidationException> update({
    TextVO? name,
    Category? category,
  }) {
    if (name != null && !name.isValid) {
      return name.validate().pure(this);
    } else {
      _name = name ?? _name;
      _category = category ?? _category;
      return Success(this);
    }
  }
}
