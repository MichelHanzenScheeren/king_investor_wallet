import 'package:king_investor_wallet/src/domain/utils/round_double.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/utils/number_extractor.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class NumberVO extends ValueObject<double?> {
  NumberVO(dynamic value) : super(numberExtractor(value));

  NumberVO.asDefault() : super(0.0);

  @override
  double get value => roundDouble(super.value ?? 0.0, 4);

  @override
  Result<NumberVO, String> validate() =>
      super.value != null ? Success(this) : const Failure('Número inválido');
}
