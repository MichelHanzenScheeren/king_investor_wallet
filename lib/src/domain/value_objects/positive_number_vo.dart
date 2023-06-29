import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:result_dart/result_dart.dart';

class PositiveNumberVO extends NumberVO {
  PositiveNumberVO(dynamic value) : super(value);

  PositiveNumberVO.asDefault() : super(0.0);

  @override
  double get value => super.value < 0 ? 0.0 : super.value;

  @override
  Result<PositiveNumberVO, ValidationException> validate() {
    return super.validate().flatMap((_) => _localValidate()).pure(this);
  }

  Result<PositiveNumberVO, ValidationException> _localValidate() =>
      super.value < 0
          ? _failure('Número não pode ser negativo')
          : Success(this);

  Result<PositiveNumberVO, ValidationException> greaterThanZero() =>
      super.value <= 0
          ? _failure('Valor deve ser maior do que zero')
          : Success(this);

  Failure<PositiveNumberVO, ValidationException> _failure(String message) =>
      ValidationException(
        type: PositiveNumberVO,
        message: message,
      ).toFailure();
}
