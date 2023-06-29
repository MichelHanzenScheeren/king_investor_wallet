import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

class UserData extends Entity {
  TextVO _name;

  UserData({super.id, required TextVO name}) : _name = name;

  String get name => _name.value;

  @override
  Result<UserData, String> validate() =>
      super.validate().flatMap((_) => _name.validate()).pure(this);

  Result<UserData, String> update({TextVO? name}) {
    final result = Result<UserData, String>.success(this)
        .flatMap((_) => _validateField(name))
        .pure(this);
    if (result.isError()) return result;

    _name = name ?? _name;
    return Success(this);
  }

  Result<UserData, String> _validateField(ValueObject<dynamic>? value) =>
      value?.validate().pure(this) ?? Success(this);
}
