import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';

import '../../mocks/domain/entities/asset_movements.dart';

void main() {
  group('AssetMovement', () {
    test('should be valid if pass valid data', () {
      final item = validAssetMovement();
      expect(item.isValid, isTrue);
      expect(item.total, equals(31.0));
    });

    test('should increase quantity correctly', () {
      final item = validAssetMovement();
      final initialQuantity = item.quantity;
      item.increaseQuantity(PositiveIntegerVO(3));
      expect(item.quantity, initialQuantity + 3);
    });

    test('should be invalid if pass invalid data', () {
      final item = invalidAssetMovementWithInvalidQuantity();
      expect(item.isValid, isFalse);
    });
  });
}
