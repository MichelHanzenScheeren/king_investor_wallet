import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class SymbolVO extends ValueObject<String> {
  SymbolVO(String value)
      : super(value.replaceAll(RegExp('[.|,|:|;|-|/| ].*'), '').toUpperCase());

  @override
  Result<SymbolVO, ValidationException> validate() {
    if (value.length >= 3) {
      return Success(this);
    } else {
      return ValidationException(
        type: SymbolVO,
        message: 'Símbolo inválido',
      ).toFailure();
    }
  }
}
