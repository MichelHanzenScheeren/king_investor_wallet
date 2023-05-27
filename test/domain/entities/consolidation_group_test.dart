import 'package:flutter_test/flutter_test.dart';

import '../../mocks/domain/entities/consolidation_groups.dart';

void main() {
  group('ConsolidationGroup', () {
    test('should be valid when valid data (total)', () {
      final item = validConsolidationGroup();
      expect(item.isValid, isTrue);
    });

    test('should calculate right totals', () {
      final item = validConsolidationGroup();
      final consolidation = item.totalConsolidation;
      expect(consolidation.id, equals('Símbolo1'));
      expect(consolidation.totalInvested, equals(137));
      expect(consolidation.totalInvestedPercentage, equals(100));
      expect(consolidation.totalToday, equals(39));
      expect(consolidation.totalTodayPercentage, equals(100));
      expect(consolidation.totalIncomes, equals(25));
      expect(consolidation.balanceSales, equals(3));
      expect(consolidation.valorization, equals(-98));
      expect(
        consolidation.valorizationPercentage.toStringAsFixed(2),
        equals('-71.53'),
      );
      expect(consolidation.result, equals(-70));
      expect(
        consolidation.resultPercentage.toStringAsFixed(2),
        equals('-51.09'),
      );
    });

    test('should calculate right partials', () {
      final item = validConsolidationGroup();
      final consolidation = item.assetsConsolidation.first;
      expect(consolidation.id, equals('WEGE3'));
      expect(consolidation.totalInvested, equals(41));
      expect(
        consolidation.totalInvestedPercentage.toStringAsFixed(2),
        equals('29.93'),
      );
      expect(consolidation.totalToday, equals(3));
      expect(
        consolidation.totalTodayPercentage.toStringAsFixed(2),
        equals('7.69'),
      );
      expect(consolidation.totalIncomes, equals(15));
      expect(consolidation.balanceSales, equals(5));
      expect(consolidation.valorization, equals(-38));
      expect(
        consolidation.valorizationPercentage.toStringAsFixed(2),
        equals('-92.68'),
      );
      expect(consolidation.result, equals(-18));
      expect(
        consolidation.resultPercentage.toStringAsFixed(2),
        equals('-43.90'),
      );
    });
  });
}
