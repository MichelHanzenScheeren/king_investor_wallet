import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/utils/text_formatter.dart';

void main() {
  group('numberExtractor', () {
    test('should return empty string when pass empty string', () {
      final value = textFormatter('');
      expect(value, equals(''));
    });

    test('should return valid string when pass one word lowercase', () {
      final value = textFormatter('text');
      expect(value, equals('Text'));
    });

    test('should return valid string when pass one word uppercase', () {
      final value = textFormatter('TEXT');
      expect(value, equals('Text'));
    });

    test('should return valid string when pass two words lowercase', () {
      final value = textFormatter('text text2');
      expect(value, equals('Text Text2'));
    });

    test('should return valid string when pass words with extra spaces', () {
      final value = textFormatter(' text   text2 ');
      expect(value, equals('Text Text2'));
    });

    test('should return valid string when pass words with connectors', () {
      final value = textFormatter('teste de conectores');
      expect(value, equals('Teste de Conectores'));
    });
  });
}
