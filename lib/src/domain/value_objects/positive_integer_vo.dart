import 'package:king_investor_wallet/src/domain/value_objects/integer_vo.dart';
import 'package:result_dart/result_dart.dart';

class PositiveIntegerVO extends IntegerVO {
  PositiveIntegerVO(super.value);

  @override
  int get value => super.value < 0 ? 0 : super.value;

  @override
  Result<PositiveIntegerVO, String> validate() {
    return super.validate().flatMap((_) => _localValidate()).pure(this);
  }

  Result<PositiveIntegerVO, String> _localValidate() => super.value < 0
      ? const Failure('Número não pode ser negativo')
      : Success(this);

  Result<PositiveIntegerVO, String> greaterThanZero() => super.value <= 0
      ? const Failure('Valor deve ser maior do que zero')
      : Success(this);
}
