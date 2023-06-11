import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:result_dart/result_dart.dart';

class EmailVO extends ValueObject<String> {
  EmailVO(super.value);

  @override
  Result<EmailVO, String> validate() =>
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)
          ? Success(this)
          : const Failure('Email inválido');
}
