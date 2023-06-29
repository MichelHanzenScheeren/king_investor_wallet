import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

const emailRegex =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

class EmailVO extends ValueObject<String> {
  EmailVO(super.value);

  @override
  Result<EmailVO, ValidationException> validate() {
    if (RegExp(emailRegex).hasMatch(value)) {
      return Success(this);
    } else {
      return ValidationException(
        type: EmailVO,
        message: 'Email inválido',
      ).toFailure();
    }
  }
}
