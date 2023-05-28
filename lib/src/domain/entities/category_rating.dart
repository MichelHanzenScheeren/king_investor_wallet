import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';
import 'package:result_dart/result_dart.dart';

class CategoryRating extends Entity {
  final Category _category;
  final RatingVO _rating;

  CategoryRating({
    required Category category,
    required RatingVO rating,
  })  : _category = category,
        _rating = rating,
        super(id: IdVO(category.abbreviation));

  CategoryRating.asDefault({
    super.id,
    required Category category,
  })  : _category = category,
        _rating = RatingVO.asDefault();

  Category get category => _category;
  double get rating => _rating.value;

  @override
  Result<CategoryRating, String> validate() =>
      super.validate().flatMap((_) => _rating.validate()).pure(this);
}
