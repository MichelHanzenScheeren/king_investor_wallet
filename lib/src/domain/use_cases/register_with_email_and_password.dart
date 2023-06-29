import 'package:king_investor_wallet/src/domain/entities/user.dart';
import 'package:king_investor_wallet/src/domain/entities/user_data.dart';
import 'package:king_investor_wallet/src/domain/exceptions/app_exception.dart';
import 'package:king_investor_wallet/src/domain/services/register_with_email_and_password_service.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/password_vo.dart';
import 'package:result_dart/result_dart.dart';

abstract class IRegisterWithEmailAndPassword {
  AsyncResult<User, AppException> call({
    required EmailVO email,
    required PasswordVO password,
    required UserData userData,
  });
}

class RegisterWithEmailAndPassword implements IRegisterWithEmailAndPassword {
  final IRegisterWithEmailAndPasswordService _service;

  RegisterWithEmailAndPassword(IRegisterWithEmailAndPasswordService service)
      : _service = service;

  @override
  AsyncResult<User, AppException> call({
    required EmailVO email,
    required PasswordVO password,
    required UserData userData,
  }) {
    return email
        .validate()
        .flatMap((_) => password.validate())
        .flatMap((_) => userData.validate())
        .fold(
          (success) => _service(
            email: email.value,
            password: password.value,
            userData: userData,
          ),
          (exception) => AsyncResult.value(exception.toFailure()),
        );
  }
}
