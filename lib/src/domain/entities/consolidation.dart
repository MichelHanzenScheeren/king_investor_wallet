// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_group.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_result.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
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
  Result<Consolidation, ValidationException> validate() {
    if (_validAssets.isNotEmpty) {
      return Success(this);
    } else {
      return ValidationException(
        type: Consolidation,
        message: 'Nenhum ativo válido',
      ).toFailure();
    }
  }

  void _filterAssets(List<Asset> assets) {
    for (Asset asset in assets) {
      if (asset.isValid) {
        _validAssets.add(asset);
      } else {
        _invalidAssets.add(asset);
      }
    }
  }

  Result<ConsolidationResult, ValidationException> consolidate() {
    final validationResult = validate();
    if (validationResult.isError()) {
      return Failure(validationResult.exceptionOrNull()!);
    }
    final totalRelatedToAllAssets = _consolidateTotals();
    final totalConsolidation = totalRelatedToAllAssets.totalConsolidation;
    final allAssetsConsolidation = totalRelatedToAllAssets.assetsConsolidation;
    final categoriesConsolidation = _consolidateCategories(totalConsolidation);
    final assetsGroupedByCategoryConsolidation =
        _consolidateAssetsGroupedByCategory();
    return Success(ConsolidationResult(
      totalConsolidation: totalConsolidation,
      allAssetsConsolidation: allAssetsConsolidation,
      categoriesConsolidation: categoriesConsolidation,
      assetsGroupedByCategoryConsolidation:
          assetsGroupedByCategoryConsolidation,
    ));
  }

  ConsolidationGroup _consolidateTotals() {
    return ConsolidationGroup(
      id: IdVO('Total'),
      filteredAssets: validAssets,
    );
  }

  List<ConsolidationItem> _consolidateCategories(ConsolidationItem totals) {
    final List<ConsolidationItem> result = [];
    for (var category in Category.values) {
      final consolidation = _consolidateCategory(
        category: category,
        filtered: _filterByCategory(category, _validAssets),
        totals: totals,
      );
      result.add(consolidation);
    }
    return result;
  }

  ConsolidationItem _consolidateCategory({
    required Category category,
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
      id: IdVO(category.abbreviation),
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

  List<ConsolidationGroup> _consolidateAssetsGroupedByCategory() {
    final List<ConsolidationGroup> results = [];
    for (Category category in Category.values) {
      final consolidation = ConsolidationGroup(
        id: IdVO(category.abbreviation),
        filteredAssets: _filterByCategory(category, _validAssets),
      );
      results.add(consolidation);
    }
    return results;
  }

  List<Asset> _filterByCategory(Category category, List<Asset> original) {
    return List.from(original.where((element) => element.category == category));
  }
}
