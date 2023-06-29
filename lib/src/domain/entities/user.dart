import 'package:king_investor_wallet/src/domain/entities/user_data.dart';
import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

class User extends UserData {
  EmailVO _email;

  User(
      {super.id,
      required EmailVO email,
      required TextVO name,
      IdVO? sessionToken})
      : _email = email,
        super(name: name);

  User.fromData({IdVO? id, required EmailVO email, required UserData userData})
      : this(id: id, email: email, name: TextVO(userData.name));

  String get email => _email.value;

  @override
  Result<User, ValidationException> validate() =>
      super.validate().flatMap((_) => _email.validate()).pure(this);

  @override
  Result<User, ValidationException> update({TextVO? name, EmailVO? email}) {
    final result = Result<User, ValidationException>.success(this)
        .flatMap((_) => _validateField(email))
        .flatMap((_) => super.update(name: name))
        .pure(this);
    if (result.isError()) return result;

    _email = email ?? _email;
    return Success(this);
  }

  Result<User, ValidationException> _validateField(ValueObject? value) =>
      value?.validate().pure(this) ?? Success(this);
}
