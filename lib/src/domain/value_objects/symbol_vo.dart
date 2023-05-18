import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class SymbolVO extends ValueObject<String> {
  SymbolVO(String value)
      : super(value.replaceAll(RegExp('[.|,|:|;|-|/| ].*'), '').toUpperCase());

  @override
  Result<SymbolVO, String> validate() =>
      value.length >= 3 ? Success(this) : const Failure('Símbolo inválido');
}
