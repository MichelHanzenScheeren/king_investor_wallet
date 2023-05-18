import 'package:king_investor_wallet/src/domain/utils/integer_extractor.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class IntegerVO extends ValueObject<int> {
  int? _value;

  IntegerVO(dynamic value) : super(0) {
    _value = integerExtractor(value);
  }

  @override
  int get value => _value ?? 0;

  @override
  Result<IntegerVO, String> validate() =>
      _value != null ? Success(this) : const Failure('Número inteiro inválido');
}
