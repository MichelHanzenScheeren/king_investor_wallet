import 'package:king_investor_wallet/src/domain/entities/category_rating.dart';
import 'package:king_investor_wallet/src/domain/entities/category_rating_group.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';

CategoryRatingGroup validCategoryRatingGroup() => CategoryRatingGroup(
      categoriesRating: [
        CategoryRating.asDefault(type: Category.stock),
        CategoryRating.asDefault(type: Category.reit),
      ],
    );

CategoryRatingGroup partialCategoryRatingGroup() => CategoryRatingGroup(
      categoriesRating: [
        CategoryRating.asDefault(type: Category.stock),
      ],
    );

CategoryRatingGroup invalidCategoryRatingGroup() => CategoryRatingGroup(
      categoriesRating: [
        CategoryRating.asDefault(type: Category.stock),
        CategoryRating(type: Category.reit, rating: RatingVO(-1)),
      ],
    );
