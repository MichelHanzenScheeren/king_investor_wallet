import 'package:king_investor_wallet/src/domain/exceptions/app_exception.dart';

class ValidationException extends AppException {
  ValidationException({
    required Type objectType,
    required String message,
  }) : super(code: objectType.toString(), message: message);
}
