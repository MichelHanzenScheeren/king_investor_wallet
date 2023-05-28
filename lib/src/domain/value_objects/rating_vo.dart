import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:result_dart/result_dart.dart';

class RatingVO extends NumberVO {
  RatingVO(super.value);

  RatingVO.asDefault() : this(10.0);

  @override
  Result<RatingVO, String> validate() =>
      super.validate().flatMap((success) => _localValidate()).pure(this);

  Result<RatingVO, String> _localValidate() => (value < 0 || value > 10)
      ? const Failure('A nota precisa ser um número entre 0 e 10')
      : Success(this);
}
