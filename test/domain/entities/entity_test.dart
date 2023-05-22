import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';

void main() {
  group('Entity', () {
    test('should be always valid when created', () {
      final item = Entity(id: IdVO(null));
      expect(item.isValid, isTrue);
    });

    test('should be always valid when created (IdVO null)', () {
      final item = Entity();
      expect(item.isValid, isTrue);
    });

    test('should be always valid when created with static id', () {
      final item = Entity(id: IdVO('1234'));
      expect(item.isValid, isTrue);
    });

    test('should be equal when have the same id', () {
      final item1 = Entity(id: IdVO('1234'));
      final item2 = Entity(id: IdVO('1234'));
      expect(item1, equals(item2));
    });

    test('should be different when generate id', () {
      final item1 = Entity(id: IdVO(''));
      final item2 = Entity(id: IdVO(''));
      expect(item1, isNot(item2));
    });
  });
}
