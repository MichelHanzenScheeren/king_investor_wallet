import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/utils/integer_extractor.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class IntegerVO extends ValueObject<int?> {
  IntegerVO(dynamic value) : super(integerExtractor(value));

  @override
  int get value => super.value ?? 0;

  @override
  Result<IntegerVO, ValidationException> validate() {
    if (super.value != null) {
      return Success(this);
    } else {
      return ValidationException(
        type: IntegerVO,
        message: 'Número inteiro inválido',
      ).toFailure();
    }
  }
}
