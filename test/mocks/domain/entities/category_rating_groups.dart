import 'package:king_investor_wallet/src/domain/entities/category_rating.dart';
import 'package:king_investor_wallet/src/domain/entities/category_rating_group.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';

CategoryRatingGroup validDefaultCategoryRatingGroup() => CategoryRatingGroup(
      categoriesRating: [
        CategoryRating.asDefault(category: Category.stock),
        CategoryRating.asDefault(category: Category.reit),
      ],
    );

CategoryRatingGroup validCategoryRatingGroupWithPersonalRatings() =>
    CategoryRatingGroup(
      categoriesRating: [
        CategoryRating(category: Category.stock, rating: RatingVO(7)),
        CategoryRating(category: Category.reit, rating: RatingVO(3)),
      ],
    );

CategoryRatingGroup partialCategoryRatingGroup() => CategoryRatingGroup(
      categoriesRating: [
        CategoryRating.asDefault(category: Category.stock),
      ],
    );

CategoryRatingGroup invalidCategoryRatingGroup() => CategoryRatingGroup(
      categoriesRating: [
        CategoryRating.asDefault(category: Category.stock),
        CategoryRating(category: Category.reit, rating: RatingVO(-1)),
      ],
    );
