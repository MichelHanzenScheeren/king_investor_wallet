import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/user_data.dart';
import 'package:king_investor_wallet/src/domain/use_cases/register_with_email_and_password.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/password_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:king_investor_wallet/src/domain/services/register_with_email_and_password_service.dart';
import 'package:result_dart/result_dart.dart';

import '../../mocks/domain/entities/users.dart';

class RegisterWithEmailAndPasswordServiceMock extends Mock
    implements IRegisterWithEmailAndPasswordService {}

class UserDataFake extends Fake implements UserData {}

class EmailVOFake extends Fake implements EmailVO {}

class PasswordVOFake extends Fake implements PasswordVO {}

void main() {
  group('RegisterWithEmailAndPassword', () {
    final service = RegisterWithEmailAndPasswordServiceMock();
    final registerUseCase = RegisterWithEmailAndPassword(service);

    setUpAll(() {
      registerFallbackValue(UserDataFake());
      registerFallbackValue(EmailVOFake());
      registerFallbackValue(PasswordVOFake());
    });

    test('should return Failure if invalid email was passed', () async {
      final result = await registerUseCase.call(
        email: EmailVO('teste'),
        password: PasswordVO('12345678qW@'),
        userData: UserData(name: TextVO('Teste')),
      );
      expect(result, isA<Failure>());
    });

    test('should return Failure if invalid password was passed', () async {
      final result = await registerUseCase.call(
        email: EmailVO('teste@email.com'),
        password: PasswordVO('12345678'),
        userData: UserData(name: TextVO('Teste')),
      );
      expect(result, isA<Failure>());
    });

    test('should return Failure if invalid name was passed', () async {
      final result = await registerUseCase.call(
        email: EmailVO('teste@email.com'),
        password: PasswordVO('12345678qW@'),
        userData: UserData(name: TextVO('')),
      );
      expect(result, isA<Failure>());
    });

    test('should return Success if valid data was passed', () async {
      when(() => service.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            userData: any(named: 'userData'),
          )).thenAnswer((_) => AsyncResult.value(Success(validUser1())));

      final result = await registerUseCase.call(
        email: EmailVO('teste@email.com'),
        password: PasswordVO('12345678qW@'),
        userData: UserData(name: TextVO('Meu nome')),
      );
      expect(result, isA<Success>());
    });
  });
}
