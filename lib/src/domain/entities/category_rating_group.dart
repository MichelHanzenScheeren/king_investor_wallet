import 'package:king_investor_wallet/src/domain/entities/category_rating.dart';
import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
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
      (category) => categoriesRating.firstWhere(
        (item) => item.category == category,
        orElse: () => CategoryRating.asDefault(category: category),
      ),
    ));
  }

  List<CategoryRating> _generateDefaultCategoriesRating() {
    return List.from(
      Category.values.map<CategoryRating>(
        (e) => CategoryRating.asDefault(category: e),
      ),
    );
  }

  @override
  Result<CategoryRatingGroup, ValidationException> validate() {
    return super.validate().flatMap((_) => _localValidate()).pure(this);
  }

  Result<CategoryRatingGroup, ValidationException> _localValidate() {
    return _categoriesRating.map((e) => e.validate().pure(this)).firstWhere(
          (element) => element.isError(),
          orElse: () => Success(this),
        );
  }
}
