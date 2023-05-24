import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:result_dart/result_dart.dart';

class PositiveNumberVO extends NumberVO {
  PositiveNumberVO(dynamic value) : super(value);

  PositiveNumberVO.asDefault() : super(0.0);

  @override
  double get value => super.value < 0 ? 0.0 : super.value;

  @override
  Result<PositiveNumberVO, String> validate() {
    return super.validate().flatMap((_) => _localValidate()).pure(this);
  }

  Result<PositiveNumberVO, String> _localValidate() => super.value < 0
      ? const Failure('Número não pode ser negativo')
      : Success(this);

  Result<PositiveNumberVO, String> greaterThanZero() => super.value <= 0
      ? const Failure('Valor deve ser maior do que zero')
      : Success(this);
}
