import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:result_dart/result_dart.dart';

import '../../mocks/domain/entities/users.dart';

void main() {
  group('User', () {
    test('should be valid if valid data without session token', () {
      final item = validUser1();
      expect(item.isValid, isTrue);
    });

    test('should return false in isAuthenticated when none was passed', () {
      final item = validUser1();
      expect(item.isAuthenticated, isFalse);
    });

    test('should return empty string when none session token', () {
      final item = validUser1();
      expect(item.sessionToken, equals(''));
    });

    test('should be invalid when invalid data', () {
      final item = invalidUserWithInvalidEmail();
      expect(item.isValid, isFalse);
    });

    test('should update correctly if all data passed is valid', () {
      final item = validUser1();
      final newSessionToken = IdVO(null);
      final result = item.update(sessionToken: newSessionToken);
      expect(result, isA<Success>());
      expect(item.sessionToken, equals(newSessionToken.value));
    });

    test('should not update if invalid data was passed', () {
      final item = validUser1();
      final initialEmail = item.email;
      final result = item.update(
        sessionToken: IdVO(''),
        email: EmailVO('teste@teste'),
      );
      expect(result, isA<Failure>());
      expect(item.email, equals(initialEmail));
    });
  });
}
