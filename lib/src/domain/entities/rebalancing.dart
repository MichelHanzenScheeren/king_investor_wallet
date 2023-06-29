import 'package:king_investor_wallet/src/domain/entities/asset.dart';
import 'package:king_investor_wallet/src/domain/entities/asset_movement.dart';
import 'package:king_investor_wallet/src/domain/entities/category_rating.dart';
import 'package:king_investor_wallet/src/domain/entities/category_rating_group.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/entities/rebalancing_result.dart';
import 'package:king_investor_wallet/src/domain/enums/rebalancing_error.dart';
import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_integer_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';
import 'package:result_dart/result_dart.dart';

class Rebalancing extends Entity {
  late List<Asset> _assets;
  final CategoryRatingGroup _categoriesRatingGroup;
  late final RebalancingResult _result;

  Rebalancing({
    super.id,
    required List<Asset> assets,
    required CategoryRatingGroup categoriesRatingGroup,
    required PositiveIntegerVO maxAssets,
    required PositiveNumberVO totalMoney,
  }) : _categoriesRatingGroup = categoriesRatingGroup {
    _assets = List<Asset>.from(assets.where((element) => element.isValid));
    _result = RebalancingResult(
      maxAssets: maxAssets,
      totalMoney: totalMoney,
    );
  }

  List<Asset> get assets => List.unmodifiable(_assets);
  List<CategoryRating> get categoriesRating =>
      _categoriesRatingGroup.categoriesRating;

  @override
  Result<Rebalancing, ValidationException> validate() {
    return super
        .validate()
        .flatMap((_) => _categoriesRatingGroup.validate())
        .flatMap((_) => _result.validate())
        .flatMap((_) => Consolidation(assets: _assets).validate())
        .pure(this);
  }

  Result<RebalancingResult, ValidationException> rebalance() {
    return validate().flatMap((_) => Success(_rebalance()));
  }

  RebalancingResult _rebalance() {
    bool alreadyExceededCost = false;
    final idealCategories = calculateIdealCategories(categoriesRating);
    final idealAssets = calculateIdealAssets(_assets);
    while (true) {
      final Asset candidate = _getAssetCandidate(idealCategories, idealAssets);
      final response = _result.registerMovement(candidate);
      if (response.isSuccess()) {
        increaseAssetQuantity(_assets, candidate);
      } else {
        if (_result.purchasedQuantity == 0) break;

        final error = response.exceptionOrNull();
        if (error == RebalancingError.exceededCost && !alreadyExceededCost) {
          alreadyExceededCost = true;
          limitedRebalance(_assets, _result.movements);
        } else if (error == RebalancingError.exceededQuantity) {
          limitedRebalance(_assets, _result.movements);
        } else {
          break;
        }
      }
    }
    return _result;
  }

  Asset _getAssetCandidate(
    Map<String, RatingVO> idealCategories,
    Map<String, RatingVO> idealAssets,
  ) {
    final consolidationClass = Consolidation(assets: _assets);
    final consolidation = consolidationClass.consolidate().getOrThrow();
    final validCategoriesConsolidation = filterExpressiveConsolidations(
      consolidation.categoriesConsolidation,
    );
    final categoryKey = biggestDifferenceKey(
      idealCategories,
      validCategoriesConsolidation,
    );
    final filteredAssetResults = filterConsolidationItemByCategory(
      categoryKey,
      _assets,
      consolidation.allAssetsConsolidation,
    );
    final assetKey = biggestDifferenceKey(idealAssets, filteredAssetResults);
    return getAsset(assetKey, _assets);
  }

  Map<String, RatingVO> calculateIdealCategories(
    List<CategoryRating> categoriesRating,
  ) {
    final total = categoriesRating.fold(0.0, (prev, e) => prev + e.rating);
    return Map.fromEntries(categoriesRating.map(
      (e) => MapEntry(
        e.category.abbreviation,
        RatingVO(e.rating * 100 / total),
      ),
    ));
  }

  Map<String, RatingVO> calculateIdealAssets(
    List<Asset> assets,
  ) {
    final total = assets.fold(0.0, (prev, e) => prev + e.rating);
    return Map.fromEntries(assets.map(
      (e) => MapEntry(e.symbol, RatingVO(e.rating * 100 / total)),
    ));
  }

  List<ConsolidationItem> filterExpressiveConsolidations(
    List<ConsolidationItem> consolidations,
  ) {
    final result = List<ConsolidationItem>.from(consolidations);
    result.removeWhere((e) => e.totalInvested == 0.0);
    return result;
  }

  String biggestDifferenceKey(
    Map<String, RatingVO> ideal,
    List<ConsolidationItem> consolidationItems,
  ) {
    final newList = List<ConsolidationItem>.from(consolidationItems);
    newList.sort(
      (a, b) => (a.totalTodayPercentage - (ideal[a.id]?.value ?? 0.0))
          .compareTo(b.totalTodayPercentage - (ideal[b.id]?.value ?? 0.0)),
    );
    return newList.first.id;
  }

  Asset getAsset(String symbol, List<Asset> assets) =>
      assets.firstWhere((e) => e.symbol == symbol);

  List<ConsolidationItem> filterConsolidationItemByCategory(
    String category,
    List<Asset> assets,
    List<ConsolidationItem> consolidationItems,
  ) {
    final filtered = assets.where((e) => e.category.abbreviation == category);
    return List.from(consolidationItems.where(
      (e1) => filtered.any((e2) => e2.symbol == e1.id),
    ));
  }

  void limitedRebalance(
    List<Asset> assets,
    List<AssetMovement> movements,
  ) {
    assets.removeWhere(
      (asset) => !movements.any((movement) => movement.symbol == asset.symbol),
    );
  }

  void increaseAssetQuantity(
    List<Asset> assets,
    Asset asset,
  ) {
    final index = assets.indexWhere((e) => e.symbol == asset.symbol);
    final newAsset = Asset.copy(asset: assets[index]);
    newAsset.registerPurchase(
      transactionQuantity: PositiveIntegerVO(1),
      price: PositiveNumberVO(asset.quote.price),
    );
    assets[index] = newAsset;
  }
}
