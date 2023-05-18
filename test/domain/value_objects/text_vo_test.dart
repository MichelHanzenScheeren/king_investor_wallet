import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

void main() {
  group('TextVO', () {
    test('should save valid string and be valid', () {
      final item = TextVO('banco itaú');
      expect(item.value, equals('Banco Itaú'));
      expect(item.isValid, isTrue);
    });

    test('should be invalid if null was passed', () {
      final item = TextVO(null);
      expect(item.value, equals(''));
      expect(item.isValid, isFalse);
    });

    test('should be invalid if empty string was passed', () {
      final item = TextVO('');
      expect(item.value, equals(''));
      expect(item.isValid, isFalse);
    });
  });
}
