// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:king_investor_wallet/src/domain/entities/consolidation_group.dart';
import 'package:king_investor_wallet/src/domain/entities/consolidation_item.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:result_dart/result_dart.dart';

class ConsolidationResult extends Entity {
  final ConsolidationItem totalConsolidation;
  final List<ConsolidationItem> _allAssetsConsolidation;
  final List<ConsolidationItem> _categoriesConsolidation;
  final List<ConsolidationGroup> _assetsGroupedByCategoryConsolidation;

  ConsolidationResult({
    super.id,
    required this.totalConsolidation,
    required List<ConsolidationItem> allAssetsConsolidation,
    required List<ConsolidationItem> categoriesConsolidation,
    required List<ConsolidationGroup> assetsGroupedByCategoryConsolidation,
  })  : _allAssetsConsolidation = allAssetsConsolidation,
        _categoriesConsolidation = categoriesConsolidation,
        _assetsGroupedByCategoryConsolidation =
            assetsGroupedByCategoryConsolidation;

  List<ConsolidationItem> get allAssetsConsolidation =>
      List<ConsolidationItem>.unmodifiable(_allAssetsConsolidation);

  List<ConsolidationItem> get categoriesConsolidation =>
      List<ConsolidationItem>.unmodifiable(_categoriesConsolidation);

  List<ConsolidationGroup> get assetsGroupedByCategoryConsolidation =>
      List<ConsolidationGroup>.unmodifiable(
          _assetsGroupedByCategoryConsolidation);

  @override
  Result<ConsolidationResult, String> validate() {
    return super
        .validate()
        .flatMap((_) => totalConsolidation.validate())
        .flatMap((_) => _validateList(_allAssetsConsolidation))
        .flatMap((_) => _validateList(_categoriesConsolidation))
        .flatMap((_) => _validateList(_assetsGroupedByCategoryConsolidation))
        .pure(this);
  }

  Result<ConsolidationResult, String> _validateList(List<Entity> entities) {
    return entities.map((e) => e.validate().pure(this)).firstWhere(
          (element) => element.isError(),
          orElse: () => Success(this),
        );
  }
}
