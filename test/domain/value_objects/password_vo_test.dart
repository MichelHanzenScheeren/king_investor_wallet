import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/password_vo.dart';

void main() {
  group('PasswordVo', () {
    test('should be valid if all requirements are ok', () {
      final item = PasswordVO('12345678qW@');
      expect(item.isValid, isTrue);
    });

    test('should be invalid if less than minPasswordLength', () {
      final item = PasswordVO('3678qW@');
      expect(item.isValid, isFalse);
    });

    test('should be invalid if dont have a-z letter', () {
      final item = PasswordVO('1234678W@');
      expect(item.isValid, isFalse);
    });

    test('should be invalid if dont have A-Z letter', () {
      final item = PasswordVO('1234678q@');
      expect(item.isValid, isFalse);
    });

    test('should be invalid if dont have symbol', () {
      final item = PasswordVO('1234678qW');
      expect(item.isValid, isFalse);
    });

    test('should be invalid if dont have 0-9 number', () {
      final item = PasswordVO('abcdeFGWa');
      expect(item.isValid, isFalse);
    });
  });
}
