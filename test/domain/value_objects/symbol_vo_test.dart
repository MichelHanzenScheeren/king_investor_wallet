import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';

void main() {
  group('SymbolVO', () {
    test('should save valid string unchanged', () {
      final item = SymbolVO('ITUB3');
      expect(item.value, equals('ITUB3'));
    });

    test('should remove all after symbol', () {
      final item = SymbolVO('HGRU11.SAO');
      expect(item.value, equals('HGRU11'));
    });

    test('should remove all after white space', () {
      final item = SymbolVO('HGRU11 SAO');
      expect(item.value, equals('HGRU11'));
    });

    test('should save uppercase', () {
      final item = SymbolVO('wege3');
      expect(item.value, equals('WEGE3'));
    });

    test('should be valid if valid value was passed', () {
      final item = SymbolVO('HGRU11 SAO');
      expect(item.isValid, isTrue);
    });

    test('should be invalid if invalid value was passed', () {
      final item = SymbolVO('');
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), equals('Símbolo inválido'));
    });
  });
}
