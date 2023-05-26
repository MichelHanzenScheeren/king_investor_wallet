import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/symbol_vo.dart';
import 'package:result_dart/result_dart.dart';

class ConsolidationGroup extends Entity {
  final SymbolVO _discriminator;
  late final ConsolidationItem totalConsolidation;
  final List<ConsolidationItem> _assetsConsolidation = [];

  ConsolidationGroup(
      {required SymbolVO discriminator, required List<Asset> filteredAssets})
      : _discriminator = discriminator,
        super(id: IdVO(discriminator.value)) {
    _consolidate(filteredAssets);
    _consolidateAssets(filteredAssets);
  }

  List<ConsolidationItem> get assetsConsolidation =>
      List<ConsolidationItem>.unmodifiable(_assetsConsolidation);

  @override
  Result<Entity, String> validate() {
    return super
        .validate()
        .flatMap((_) => _discriminator.validate())
        .flatMap((_) => totalConsolidation.validate())
        .flatMap((_) => _assetsConsolidation
            .map<Result<Entity, String>>((e) => e.validate())
            .firstWhere((element) => element.isError(),
                orElse: () => Success(this)))
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
      discriminator: _discriminator,
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
        discriminator: SymbolVO(asset.symbol),
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
