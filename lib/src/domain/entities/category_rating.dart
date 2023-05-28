import 'package:king_investor_wallet/src/domain/entities/entity.dart';
import 'package:king_investor_wallet/src/domain/enums/category.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/rating_vo.dart';
import 'package:result_dart/result_dart.dart';

class CategoryRating extends Entity {
  final Category _type;
  final RatingVO _rating;

  CategoryRating({
    required Category type,
    required RatingVO rating,
  })  : _type = type,
        _rating = rating,
        super(id: IdVO(type.abbreviation));

  CategoryRating.asDefault({
    super.id,
    required Category type,
  })  : _type = type,
        _rating = RatingVO.asDefault();

  Category get type => _type;
  double get rating => _rating.value;

  @override
  Result<CategoryRating, String> validate() =>
      super.validate().flatMap((_) => _rating.validate()).pure(this);
}
