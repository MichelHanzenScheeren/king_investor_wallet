// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_group.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_result.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/asset_type.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:result_dart/result_dart.dart';

class Consolidation extends Entity {
  final List<Asset> _validAssets = [];
  final List<Asset> _invalidAssets = [];

  Consolidation({
    super.id,
    required List<Asset> assets,
  }) {
    _filterAssets(assets);
  }

  List<Asset> get validAssets => List<Asset>.unmodifiable(_validAssets);
  List<Asset> get invalidAssets => List<Asset>.unmodifiable(_invalidAssets);

  bool get hasInvalidAssets => _invalidAssets.isNotEmpty;

  @override
  Result<Consolidation, String> validate() => _validAssets.isEmpty
      ? const Failure('Nenhum ativo válido')
      : Success(this);

  void _filterAssets(List<Asset> assets) {
    for (Asset asset in assets) {
      if (asset.isValid) {
        _validAssets.add(asset);
      } else {
        _invalidAssets.add(asset);
      }
    }
  }

  Result<ConsolidationResult, String> consolidate() {
    if (!isValid) {
      return Failure(validate().exceptionOrNull() ?? '');
    }
    final totalRelatedToAllAssets = _consolidateTotals();
    final totalConsolidation = totalRelatedToAllAssets.totalConsolidation;
    final allAssetsConsolidation = totalRelatedToAllAssets.assetsConsolidation;
    final assetTypesConsolidation = _consolidateAssetTypes(totalConsolidation);
    final assetsGroupedByTypeConsolidation = _consolidateAssetsGroupedByType();
    return Success(ConsolidationResult(
      totalConsolidation: totalConsolidation,
      allAssetsConsolidation: allAssetsConsolidation,
      assetTypesConsolidation: assetTypesConsolidation,
      assetsGroupedByTypeConsolidation: assetsGroupedByTypeConsolidation,
    ));
  }

  ConsolidationGroup _consolidateTotals() {
    return ConsolidationGroup(
      id: IdVO('Total'),
      filteredAssets: validAssets,
    );
  }

  List<ConsolidationItem> _consolidateAssetTypes(ConsolidationItem totals) {
    final List<ConsolidationItem> result = [];
    for (var type in AssetType.values) {
      final consolidation = _consolidateType(
        type: type,
        filtered: _filterByAssetType(type, _validAssets),
        totals: totals,
      );
      result.add(consolidation);
    }
    return result;
  }

  ConsolidationItem _consolidateType({
    required AssetType type,
    required List<Asset> filtered,
    required ConsolidationItem totals,
  }) {
    double totalInvested = 0.0;
    double totalToday = 0.0;
    double totalIncomes = 0.0;
    double balanceSales = 0.0;
    for (Asset asset in filtered) {
      totalInvested += (asset.quantity * asset.averagePrice);
      totalToday += (asset.quantity * asset.quote.price);
      totalIncomes += asset.totalIncomes;
      balanceSales += asset.balanceSales;
    }
    return ConsolidationItem(
      id: IdVO(type.abbreviation),
      totalInvested: PositiveNumberVO(totalInvested),
      totalInvestedPercentage: PositiveNumberVO(
        totalInvested * 100 / totals.totalInvested,
      ),
      totalToday: PositiveNumberVO(totalToday),
      totalTodayPercentage: PositiveNumberVO(
        totalToday * 100 / totals.totalToday,
      ),
      totalIncomes: PositiveNumberVO(totalIncomes),
      balanceSales: NumberVO(balanceSales),
    );
  }

  List<ConsolidationGroup> _consolidateAssetsGroupedByType() {
    final List<ConsolidationGroup> results = [];
    for (AssetType type in AssetType.values) {
      final consolidation = ConsolidationGroup(
        id: IdVO(type.abbreviation),
        filteredAssets: _filterByAssetType(type, _validAssets),
      );
      results.add(consolidation);
    }
    return results;
  }

  List<Asset> _filterByAssetType(AssetType type, List<Asset> original) {
    return List.from(original.where((element) => element.type == type));
  }
}
