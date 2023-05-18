import 'package:flutter_test/flutter_test.dart';
import '../../mocks/domain/entities/assets.dart';

void main() {
  group('Asset', () {
    test('should be valid when all values are valid', () {
      final item = validAssetWeg3;
      expect(item.isValid, isTrue);
      expect(item.hasQuote, isTrue);
      expect(item.hasValidQuote, isTrue);
      expect(item.hasBasicFinance, isTrue);
    });

    test('should be valid when quote is null', () {
      final item = validAssetWeg3WithNullQuote;
      expect(item.isValid, isTrue);
      expect(item.hasQuote, isFalse);
      expect(item.hasValidQuote, isFalse);
      expect(item.hasBasicFinance, isFalse);
    });

    test('should be valid when quote is invalid', () {
      final item = validAssetWeg3WithInvalidQuoteAndValidPrice;
      expect(item.isValid, isTrue);
      expect(item.hasQuote, isTrue);
      expect(item.hasValidQuote, isFalse);
      expect(item.hasBasicFinance, isTrue);
    });

    test('hasBasicFinance should be false when invalid price', () {
      final item = validAssetWeg3WithInvalidQuoteAndInvalidPrice;
      expect(item.isValid, isTrue);
      expect(item.hasQuote, isTrue);
      expect(item.hasValidQuote, isFalse);
      expect(item.hasBasicFinance, isFalse);
    });

    test('should be invalid when invalid value', () {
      final item = validAssetWeg3WithInvalidQuoteAndInvalidPrice;
      expect(item.isValid, isTrue);
      expect(item.hasQuote, isTrue);
      expect(item.hasValidQuote, isFalse);
      expect(item.hasBasicFinance, isFalse);
    });
  });
}
