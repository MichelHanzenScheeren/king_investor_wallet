import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';

ConsolidationItem validConsolidationItemWithValorization() => ConsolidationItem(
      id: IdVO(SymbolVO('wege3').value),
      totalInvested: PositiveNumberVO(250.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(300),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

ConsolidationItem validConsolidationItemWithDevaluation() => ConsolidationItem(
      id: IdVO('Total'),
      totalInvested: PositiveNumberVO(150.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(120),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

ConsolidationItem validConsolidationItemWithSalesLosses() => ConsolidationItem(
      id: IdVO('Total'),
      totalInvested: PositiveNumberVO(420.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(510),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(-230),
    );

ConsolidationItem validConsolidationItemWithIncomes() => ConsolidationItem(
      id: IdVO('Total'),
      totalInvested: PositiveNumberVO(500.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(800),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(300),
      balanceSales: NumberVO(-100),
    );

ConsolidationItem invalidConsolidationItem() => ConsolidationItem(
      id: IdVO('Total'),
      totalInvested: PositiveNumberVO(-500.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(800),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(300),
      balanceSales: NumberVO(-100),
    );
