import 'package:flutter_test/flutter_test.dart';

import '../../mocks/domain/entities/consolidation_results.dart';

void main() {
  group('ConsolidationResult', () {
    test('should be valid when all valid data was passed', () {
      final item = validConsolidationResult();
      expect(item.isValid, isTrue);
    });
  });
}
