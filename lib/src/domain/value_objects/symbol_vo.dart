import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:multiple_result/multiple_result.dart';

class SymbolVO extends ValueObject<String> {
  SymbolVO(String value)
      : super(value.replaceAll(RegExp('[.|,|:|;|-| ].*'), '').toUpperCase());

  @override
  Result<SymbolVO, String> validate() =>
      value.length < 3 ? const Error('Ativo inválido') : Success(this);
}
