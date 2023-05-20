import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:result_dart/result_dart.dart';
import '../../mocks/domain/entities/assets_base.dart';

void main() {
  group('AssetBase', () {
    test('should be valid whit valid data', () {
      final item = validAssetBaseWeg3();
      expect(item.isValid, isTrue);
    });

    test('should have same symbol and id', () {
      final item = validAssetBaseWeg3();
      expect(item.symbol, equals('WEGE3'));
      expect(item.symbol, item.id);
    });

    test('should be invalid when have invalid attribute', () {
      final item = invalidAssetBaseHGRU11EmptyCurrency();
      expect(item.isValid, isFalse);
      expect(item.validate().exceptionOrNull(), equals('Símbolo inválido'));
    });

    test('should correct update when call update() with valid new values', () {
      final item = validAssetBaseHGRU11();
      final result = item.update(
        name: TextVO('novo nome'),
        type: AssetType.stock,
      );
      expect(result, isA<Success>());
      expect(item.name, equals('Novo Nome'));
      expect(item.type, equals(AssetType.stock));
    });

    test('should not update when none was passed', () {
      final item = validAssetBaseWeg3();
      final result = item.update();
      expect(result, isA<Failure>());
      expect(result.exceptionOrNull(), equals('Nenhuma informação modificada'));
    });

    test('should not update when equal values were passed', () {
      final item = validAssetBaseWeg3();
      final result = item.update(
        name: TextVO('WEG S.A.'),
        type: AssetType.stock,
      );
      expect(result, isA<Failure>());
    });

    test('should not update when invalid name was passed', () {
      final item = validAssetBaseWeg3();
      final result = item.update(name: TextVO(null));
      expect(result, isA<Failure>());
    });

    test('should be valid after update with valid value', () {
      final item = invalidAssetBaseWeg3NullName();
      expect(item.isValid, isFalse);
      final result = item.update(name: TextVO('WEG S.A.'));
      expect(result, isA<Success>());
      expect(item.isValid, isTrue);
    });
  });
}
