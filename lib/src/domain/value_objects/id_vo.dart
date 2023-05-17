import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:uuid/uuid.dart';

class IdVO extends ValueObject<String> {
  IdVO(String? value)
      : super(value != null && value.isNotEmpty
            ? value
            : const Uuid().v4().replaceAll('-', '').substring(0, 20));

  @override
  Result<IdVO, String> validate() => Success(this);

  @override
  String toString() {
    return '$runtimeType: $value';
  }
}
