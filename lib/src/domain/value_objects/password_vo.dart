import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

const minPasswordLength = 8;

class PasswordVO extends ValueObject<String> {
  PasswordVO(super.value);

  @override
  Result<PasswordVO, String> validate() => hasMinLength &&
          hasUppercase &&
          hasLowercase &&
          hasDigits &&
          hasSpecialCharacters
      ? Success(this)
      : const Failure('Senha inválida');

  bool get hasMinLength => value.length > minPasswordLength;
  bool get hasUppercase => value.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => value.contains(RegExp(r'[a-z]'));
  bool get hasDigits => value.contains(RegExp(r'[0-9]'));
  bool get hasSpecialCharacters =>
      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
}
