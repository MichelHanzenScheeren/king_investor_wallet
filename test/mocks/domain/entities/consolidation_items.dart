import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

ConsolidationItem validConsolidationItemWithValorization() => ConsolidationItem(
      discriminator: TextVO('Total'),
      totalInvested: PositiveNumberVO(250.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(300),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

ConsolidationItem validConsolidationItemWithDevaluation() => ConsolidationItem(
      discriminator: TextVO('Total'),
      totalInvested: PositiveNumberVO(150.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(120),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(0),
    );

ConsolidationItem validConsolidationItemWithSalesLosses() => ConsolidationItem(
      discriminator: TextVO('Total'),
      totalInvested: PositiveNumberVO(420.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(510),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(0),
      balanceSales: NumberVO(-230),
    );

ConsolidationItem validConsolidationItemWithIncomes() => ConsolidationItem(
      discriminator: TextVO('Total'),
      totalInvested: PositiveNumberVO(500.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(800),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(300),
      balanceSales: NumberVO(-100),
    );

ConsolidationItem invalidConsolidation() => ConsolidationItem(
      discriminator: TextVO('Total'),
      totalInvested: PositiveNumberVO(-500.0),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(800),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(300),
      balanceSales: NumberVO(-100),
    );
