import 'package:king_investor_wallet/src/domain/entities/user.dart';
import 'package:king_investor_wallet/src/domain/entities/user_data.dart';
import 'package:king_investor_wallet/src/domain/exceptions/app_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IRegisterWithEmailAndPasswordService {
  AsyncResult<User, AppException> call({
    required String email,
    required String password,
    required UserData userData,
  });
}
