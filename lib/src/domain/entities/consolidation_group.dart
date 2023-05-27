import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';

class ConsolidationGroup extends Entity {
  late final ConsolidationItem totalConsolidation;
  final List<ConsolidationItem> _assetsConsolidation = [];

  ConsolidationGroup({required super.id, required List<Asset> filteredAssets}) {
    _consolidate(filteredAssets);
    _consolidateAssets(filteredAssets);
  }

  List<ConsolidationItem> get assetsConsolidation =>
      List<ConsolidationItem>.unmodifiable(_assetsConsolidation);

  @override
  Result<ConsolidationGroup, String> validate() {
    return super
        .validate()
        .flatMap((_) => totalConsolidation.validate())
        .flatMap((_) => _assetsConsolidation
            .map<Result<ConsolidationGroup, String>>(
                (e) => e.validate().pure(this))
            .firstWhere((e) => e.isError(), orElse: () => Success(this)))
        .pure(this);
  }

  void _consolidate(List<Asset> assets) {
    double totalInvested = 0.0;
    double totalToday = 0.0;
    double totalIncomes = 0.0;
    double balanceSales = 0.0;
    for (Asset asset in assets) {
      totalInvested += (asset.quantity * asset.averagePrice);
      totalToday += (asset.quantity * asset.quote.price);
      totalIncomes += asset.totalIncomes;
      balanceSales += asset.balanceSales;
    }
    totalConsolidation = ConsolidationItem(
      id: IdVO(id),
      totalInvested: PositiveNumberVO(totalInvested),
      totalInvestedPercentage: PositiveNumberVO(100),
      totalToday: PositiveNumberVO(totalToday),
      totalTodayPercentage: PositiveNumberVO(100),
      totalIncomes: PositiveNumberVO(totalIncomes),
      balanceSales: NumberVO(balanceSales),
    );
  }

  void _consolidateAssets(List<Asset> assets) {
    for (Asset asset in assets) {
      final totalInvested = asset.averagePrice * asset.quantity;
      final totalToday = asset.quote.price * asset.quantity;
      final assetConsolidation = ConsolidationItem(
        id: IdVO(asset.symbol),
        totalInvested: PositiveNumberVO(totalInvested),
        totalInvestedPercentage: PositiveNumberVO(
          totalInvested * 100 / totalConsolidation.totalInvested,
        ),
        totalToday: PositiveNumberVO(totalToday),
        totalTodayPercentage: PositiveNumberVO(
          totalToday * 100 / totalConsolidation.totalToday,
        ),
        totalIncomes: PositiveNumberVO(asset.totalIncomes),
        balanceSales: NumberVO(asset.balanceSales),
      );
      _assetsConsolidation.add(assetConsolidation);
    }
  }
}
