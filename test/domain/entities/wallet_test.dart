import 'package:flutter_test/flutter_test.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';
import 'package:result_dart/result_dart.dart';

import '../../mocks/domain/entities/assets.dart';
import '../../mocks/domain/entities/wallets.dart';

const repeatedAsset = 'O ativo já esta cadastrado';

void main() {
  group('Wallet', () {
    test('should be valid if valid initialization', () {
      final item = validWallet();
      expect(item.isValid, isTrue);
      expect(item.assets, isA<List>());
    });

    test('should be valid if valid initialization', () {
      final item = validWalletWithAssets();
      expect(item.isValid, isTrue);
      expect(item.assets.length, equals(1));
    });

    test('should not update when invalid value', () {
      final item = validWallet();
      final initName = item.name;
      final initIsDefault = item.isDefault;
      final result = item.update(isDefault: false, name: TextVO(''));
      expect(result, isA<Failure>());
      expect(item.name, equals(initName));
      expect(item.isDefault, equals(initIsDefault));
    });

    test('should update when pass valid name', () {
      final item = validWallet();
      final initIsDefault = item.isDefault;
      final result = item.update(name: TextVO('Meu nome'));
      expect(result, isA<Success>());
      expect(item.name, equals('Meu Nome'));
      expect(item.isDefault, initIsDefault);
    });

    test('should update when pass valid isDefault', () {
      final item = validWallet();
      final initName = item.name;
      final initIsDefault = item.isDefault;
      final result = item.update(isDefault: !initIsDefault);
      expect(result, isA<Success>());
      expect(item.name, equals(initName));
      expect(item.isDefault, !initIsDefault);
    });

    test('should not add invalid asset', () {
      final item = validWalletWithAssets();
      final result = item.addAsset(invalidAssetWeg3());
      expect(result, isA<Failure>());
    });

    test('should not add repeated asset', () {
      final item = validWalletWithAssets();
      final result = item.addAsset(validAssetWeg3());
      expect(result, isA<Failure>());
      expect(
        result.exceptionOrNull(),
        equals('$repeatedAsset (${validAssetWeg3().symbol})'),
      );
    });

    test('should add asset when valid', () {
      final item = validWalletWithAssets();
      final initLength = item.assets.length;
      final result = item.addAsset(validAssetHGRU11());
      expect(result, isA<Success>());
      expect(item.assets.length, equals(initLength + 1));
    });

    test('should not remove if unknown asset', () {
      final item = validWalletWithAssets();
      final initLength = item.assets.length;
      final result = item.removeAsset(validAssetHGRU11().symbol);
      expect(result, isA<Failure>());
      expect(item.assets.length, equals(initLength));
    });

    test('should remove if valid asset', () {
      final item = validWalletWithAssets();
      final initLength = item.assets.length;
      final result = item.removeAsset(validAssetWeg3().symbol);
      expect(result, isA<Success>());
      expect(item.assets.length, equals(initLength - 1));
    });

    test('should be valid if pass CategoryRatings', () {
      final item = validWalletWithAssetsAndCategoryRatings();
      expect(item.isValid, isTrue);
    });

    test('should be invalid if receive invalid CategoryRating', () {
      final item = invalidWalletWithCategoryRatings();
      expect(item.isValid, isFalse);
    });
  });
}
