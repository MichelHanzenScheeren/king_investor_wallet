import 'package:king_investor_wallet/src/domain/utils/integer_extractor.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class IntegerVO extends ValueObject<int?> {
  IntegerVO(dynamic value) : super(integerExtractor(value));

  @override
  int get value => super.value ?? 0;

  @override
  Result<IntegerVO, String> validate() => super.value != null
      ? Success(this)
      : const Failure('Número inteiro inválido');
}
