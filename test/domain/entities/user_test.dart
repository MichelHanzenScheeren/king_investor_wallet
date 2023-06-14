import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:result_dart/result_dart.dart';

import '../../mocks/domain/entities/users.dart';

void main() {
  group('User', () {
    test('should be valid if valid data without session token', () {
      final item = validUser1();
      expect(item.isValid, isTrue);
    });

    test('should be invalid when invalid data', () {
      final item = invalidUserWithInvalidEmail();
      expect(item.isValid, isFalse);
    });

    test('should update correctly if all data passed is valid', () {
      final item = validUser1();
      final newName = TextVO('Novo Nome');
      final result = item.update(name: newName);
      expect(result, isA<Success>());
      expect(item.name, equals(newName.value));
    });

    test('should not update if invalid data was passed', () {
      final item = validUser1();
      final initialEmail = item.email;
      final result = item.update(
        name: TextVO(''),
        email: EmailVO('teste@teste'),
      );
      expect(result, isA<Failure>());
      expect(item.email, equals(initialEmail));
    });
  });
}
