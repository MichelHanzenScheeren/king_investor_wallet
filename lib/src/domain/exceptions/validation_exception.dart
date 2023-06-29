import 'package:king_investor_wallet/src/domain/exceptions/app_exception.dart';

class ValidationException extends AppException {
  ValidationException({
    required Type type,
    required String message,
  }) : super(code: type.toString(), message: message);
}
