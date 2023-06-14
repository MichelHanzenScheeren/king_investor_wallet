import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

class User extends Entity {
  TextVO _name;
  EmailVO _email;

  User(
      {super.id,
      required TextVO name,
      required EmailVO email,
      IdVO? sessionToken})
      : _name = name,
        _email = email;

  String get name => _name.value;
  String get email => _email.value;

  @override
  Result<User, String> validate() => super
      .validate()
      .flatMap((_) => _name.validate())
      .flatMap((_) => _email.validate())
      .pure(this);

  Result<User, String> update({TextVO? name, EmailVO? email}) {
    final result = Result<User, String>.success(this)
        .flatMap((_) => _validateField(name))
        .flatMap((_) => _validateField(email))
        .pure(this);
    if (result.isError()) return result;

    _name = name ?? _name;
    _email = email ?? _email;
    return Success(this);
  }

  Result<User, String> _validateField(ValueObject<dynamic>? value) =>
      value?.validate().pure(this) ?? Success(this);
}
