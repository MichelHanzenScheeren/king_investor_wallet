import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:result_dart/result_dart.dart';

class RatingVO extends NumberVO {
  RatingVO(super.value);

  RatingVO.asDefault() : this(10.0);

  @override
  Result<RatingVO, ValidationException> validate() =>
      super.validate().flatMap((success) => _localValidate()).pure(this);

  Result<RatingVO, ValidationException> _localValidate() {
    if (value >= 0 && value <= 10) {
      return Success(this);
    } else {
      return ValidationException(
        type: RatingVO,
        message: 'A nota precisa ser um número entre 0 e 10',
      ).toFailure();
    }
  }
}
