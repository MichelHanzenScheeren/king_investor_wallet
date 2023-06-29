import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

const minPasswordLength = 8;

class PasswordVO extends ValueObject<String> {
  PasswordVO(super.value);

  bool get hasMinLength => value.length > minPasswordLength;
  bool get hasUppercase => value.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => value.contains(RegExp(r'[a-z]'));
  bool get hasDigits => value.contains(RegExp(r'[0-9]'));
  bool get hasSpecialCharacters =>
      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  bool complyTheRequirements() =>
      hasMinLength &&
      hasUppercase &&
      hasLowercase &&
      hasDigits &&
      hasSpecialCharacters;

  @override
  Result<PasswordVO, ValidationException> validate() {
    if (complyTheRequirements()) {
      return Success(this);
    } else {
      return ValidationException(
        type: PasswordVO,
        message: 'Senha inválida',
      ).toFailure();
    }
  }
}
