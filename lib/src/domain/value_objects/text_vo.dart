import 'package:king_investor_wallet/src/domain/utils/text_formatter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/value_object.dart';

class TextVO extends ValueObject<String> {
  TextVO(dynamic value) : super(textFormatter(value?.toString() ?? ''));

  @override
  Result<TextVO, String> validate() =>
      value != '' ? Success(this) : const Failure('Texto inválido');
}
