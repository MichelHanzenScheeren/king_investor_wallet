import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/integer_vo.dart';
import 'package:result_dart/result_dart.dart';

class PositiveIntegerVO extends IntegerVO {
  PositiveIntegerVO(super.value);

  @override
  int get value => super.value < 0 ? 0 : super.value;

  @override
  Result<PositiveIntegerVO, ValidationException> validate() {
    return super.validate().flatMap((_) => _localValidate()).pure(this);
  }

  Result<PositiveIntegerVO, ValidationException> _localValidate() =>
      super.value < 0
          ? _failure('Número não pode ser negativo')
          : Success(this);

  Result<PositiveIntegerVO, ValidationException> greaterThanZero() =>
      super.value <= 0
          ? _failure('Valor deve ser maior do que zero')
          : Success(this);

  Failure<PositiveIntegerVO, ValidationException> _failure(String message) =>
      ValidationException(
        type: PositiveIntegerVO,
        message: message,
      ).toFailure();
}
