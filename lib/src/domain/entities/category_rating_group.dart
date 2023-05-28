import 'package:king_investor_wallet/src/domain/entities/category_rating.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:result_dart/result_dart.dart';

class CategoryRatingGroup extends Entity {
  late List<CategoryRating> _categoriesRating;

  CategoryRatingGroup(
      {super.id, required List<CategoryRating> categoriesRating}) {
    _categoriesRating = _fixCategoriesRating(categoriesRating);
  }

  CategoryRatingGroup.fromDefault() {
    _categoriesRating = _generateDefaultCategoriesRating();
  }

  List<CategoryRating> get categoriesRating =>
      List.unmodifiable(_categoriesRating);

  List<CategoryRating> _fixCategoriesRating(
      List<CategoryRating> categoriesRating) {
    if (categoriesRating.toSet().length == Category.values.length) {
      return categoriesRating;
    }
    return List.from(Category.values.map<CategoryRating>(
      (type) => categoriesRating.firstWhere(
        (item) => item.type == type,
        orElse: () => CategoryRating.asDefault(type: type),
      ),
    ));
  }

  List<CategoryRating> _generateDefaultCategoriesRating() {
    return List.from(
      Category.values.map<CategoryRating>(
        (e) => CategoryRating.asDefault(type: e),
      ),
    );
  }

  @override
  Result<CategoryRatingGroup, String> validate() {
    return super.validate().flatMap((_) => _localValidate()).pure(this);
  }

  Result<CategoryRatingGroup, String> _localValidate() {
    return _categoriesRating.map((e) => e.validate().pure(this)).firstWhere(
          (element) => element.isError(),
          orElse: () => Success(this),
        );
  }
}
