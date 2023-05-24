import 'package:king_investor_wallet/src/domain/value_objects/integer_vo.dart';
import 'package:result_dart/result_dart.dart';

class RatingVO extends IntegerVO {
  RatingVO(super.value);

  @override
  Result<RatingVO, String> validate() =>
      super.validate().flatMap((success) => _localValidate()).pure(this);

  Result<RatingVO, String> _localValidate() => (value < 0 || value > 10)
      ? const Failure('A nota precisa ser um número inteiro entre 0 e 10')
      : Success(this);
}
