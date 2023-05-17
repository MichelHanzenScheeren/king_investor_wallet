import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';

void main() {
  group('IdVO', () {
    test('should keep passed id', () {
      final item = IdVO('123456789');
      expect(item.value, equals('123456789'));
    });

    test('should generate valid Id when none was passed', () {
      final item = IdVO(null);
      expect(item.value, isNot(''));
      expect(item.value.length, isNot(0));
    });

    test('should generate valid Id when empty string was passed', () {
      final item = IdVO('');
      expect(item.value, isNot(''));
      expect(item.value.length, isNot(0));
    });

    test('should be equal if same value', () {
      final item1 = IdVO('1234');
      final item2 = IdVO('1234');
      expect(item1, equals(item2));
    });

    test('should be different if not same value', () {
      final item1 = IdVO('9876');
      final item2 = IdVO('1234');
      expect(item1, isNot(item2));
    });

    test('should generate different values if none was passed', () {
      final item1 = IdVO('');
      final item2 = IdVO(null);
      expect(item1, isNot(item2));
    });
  });
}
