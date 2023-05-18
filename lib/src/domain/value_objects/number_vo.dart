import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/utils/number_extractor.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class NumberVO extends ValueObject<double> {
  double? _value;

  NumberVO(dynamic value) : super(0.0) {
    _value = numberExtractor(value);
  }

  @override
  double get value => _value ?? 0.0;

  @override
  Result<NumberVO, String> validate() =>
      _value != null ? Success(this) : const Failure('Número inválido');
}
