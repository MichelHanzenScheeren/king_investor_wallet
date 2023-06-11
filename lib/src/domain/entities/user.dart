import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

class User extends Entity {
  TextVO _name;
  EmailVO _email;
  IdVO? _sessionToken;

  User(
      {super.id,
      required TextVO name,
      required EmailVO email,
      IdVO? sessionToken})
      : _name = name,
        _email = email,
        _sessionToken = sessionToken;

  String get name => _name.value;
  String get email => _email.value;
  String get sessionToken => _sessionToken?.value ?? '';

  bool get isAuthenticated => _sessionToken != null;

  @override
  Result<User, String> validate() => super
      .validate()
      .flatMap((_) => _name.validate())
      .flatMap((_) => _email.validate())
      .pure(this);

  Result<User, String> update(
      {TextVO? name, EmailVO? email, IdVO? sessionToken}) {
    final result = Result<User, String>.success(this)
        .flatMap((_) => _validateField(name))
        .flatMap((_) => _validateField(email))
        .flatMap((_) => _validateField(sessionToken))
        .pure(this);
    if (result.isError()) return result;

    _name = name ?? _name;
    _email = email ?? _email;
    _sessionToken = sessionToken ?? _sessionToken;
    return Success(this);
  }

  Result<User, String> _validateField(ValueObject<dynamic>? value) =>
      value?.validate().pure(this) ?? Success(this);
}
