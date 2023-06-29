import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';

void main() {
  group('ValidationException', () {
    test('should have valid toString value', () {
      final item = ValidationException(objectType: IdVO, message: 'Teste ab');
      expect('$item', equals('Teste ab'));
      expect(item.code, equals('IdVO'));
    });

    test('should have valid code value', () {
      final item = ValidationException(objectType: IdVO, message: 'Teste ab');
      expect(item.code, equals('IdVO'));
    });

    test('should return valid completeLog value', () {
      final item = ValidationException(objectType: IdVO, message: 'Teste ab');
      expect(item.completeLog(), equals('code IdVO: Teste ab'));
    });
  });
}
