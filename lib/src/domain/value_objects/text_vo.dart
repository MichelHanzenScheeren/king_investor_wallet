import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/utils/text_formatter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class TextVO extends ValueObject<String> {
  TextVO(dynamic value) : super(textFormatter(value?.toString() ?? ''));

  @override
  Result<TextVO, ValidationException> validate() {
    if (value != '') {
      return Success(this);
    } else {
      return ValidationException(
        type: TextVO,
        message: 'Texto inválido',
      ).toFailure();
    }
  }
}
