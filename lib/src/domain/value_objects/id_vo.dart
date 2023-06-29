import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/utils/generate_id.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class IdVO extends ValueObject<String> {
  IdVO(String? value)
      : super(value != null && value.isNotEmpty ? value : generateId());

  @override
  Result<IdVO, ValidationException> validate() => Success(this);
}
