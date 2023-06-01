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
      expect(consolidation.totalInvested, equals(1967.25));
      expect(consolidation.totalInvestedPercentage, equals(100));
      expect(consolidation.totalToday, equals(2022.56));
      expect(consolidation.totalTodayPercentage, equals(100));
      expect(consolidation.totalIncomes, equals(40));
      expect(consolidation.balanceSales, equals(-20));
      expect(consolidation.valorization, equals(55.31));
      expect(consolidation.valorizationPercentage, 2.8115);
      expect(consolidation.result, equals(75.31));
      expect(consolidation.resultPercentage, 3.8282);
    });

    test('should calculate right partials', () {
      final item = validConsolidationGroup();
      final consolidation = item.assetsConsolidation.first;
      expect(consolidation.id, equals('WEGE3'));
      expect(consolidation.totalInvested, equals(228.06));
      expect(consolidation.totalInvestedPercentage, equals(11.5928));
      expect(consolidation.totalToday, equals(338.49));
      expect(consolidation.totalTodayPercentage, equals(16.7357));
      expect(consolidation.totalIncomes, equals(15));
      expect(consolidation.balanceSales, equals(-20));
      expect(consolidation.valorization, equals(110.43));
      expect(consolidation.valorizationPercentage, equals(48.4215));
      expect(consolidation.result, equals(105.43));
      expect(consolidation.resultPercentage, equals(46.2291));
    });
  });
}
