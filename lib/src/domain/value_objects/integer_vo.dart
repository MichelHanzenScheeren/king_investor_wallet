import 'package:king_investor_wallet/src/domain/utils/integer_extractor.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class IntegerVO extends ValueObject<int> {
  int? _value;
  final bool allowNegativeValues;

  IntegerVO(dynamic value, {this.allowNegativeValues = false}) : super(0) {
    _value = integerExtractor(value);
  }

  @override
  int get value => _value ?? 0;

  @override
  Result<IntegerVO, String> validate() {
    final intValue = _value;
    if (intValue == null) {
      return const Failure('Número inteiro inválido');
    }
    if (!allowNegativeValues && intValue < 0) {
      return const Failure('Número não pode ser negativo');
    }
    return Success(this);
  }
}
