import 'package:king_investor_wallet/src/domain/entities/consolidation_result.dart';

import 'consolidation_groups.dart';
import 'consolidation_items.dart';

ConsolidationResult validConsolidationResult() => ConsolidationResult(
      totalConsolidation: validConsolidationItemWithValorization(),
      allAssetsConsolidation: [
        validConsolidationItemWithDevaluation(),
        validConsolidationItemWithSalesLosses()
      ],
      categoriesConsolidation: [validConsolidationItemWithIncomes()],
      assetsGroupedByCategoryConsolidation: [validConsolidationGroup()],
    );

ConsolidationResult invalidConsolidationResult() => ConsolidationResult(
      totalConsolidation: invalidConsolidationItem(),
      allAssetsConsolidation: [
        validConsolidationItemWithDevaluation(),
        validConsolidationItemWithSalesLosses()
      ],
      categoriesConsolidation: [validConsolidationItemWithIncomes()],
      assetsGroupedByCategoryConsolidation: [validConsolidationGroup()],
    );
