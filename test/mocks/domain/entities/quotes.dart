import 'package:king_investor_wallet/src/domain/entities/quote.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';

final validQuoteWithRandomId1 = Quote(
  id: IdVO(null),
  price: NumberVO(1.5),
  high: NumberVO(45.7),
  low: NumberVO(001.45),
  yearHigh: NumberVO(85),
  yearLow: NumberVO(12.0),
  changePercentage: NumberVO(2.7),
  changePercentageMonth: NumberVO(3),
  changePercentageYear: NumberVO(.9),
);

final invalidQuoteWithRandomId1 = Quote(
  id: IdVO(null),
  price: NumberVO(1.5),
  changePercentage: NumberVO(2.7),
  changePercentageMonth: NumberVO(3),
  changePercentageYear: NumberVO(null),
  high: NumberVO(45.7),
  low: NumberVO(001.45),
  yearHigh: NumberVO(''),
  yearLow: NumberVO(12.0),
);

final validQuoteWithStaticId1 = Quote(
  id: IdVO('12345'),
  price: NumberVO(1.5),
  high: NumberVO(45.7),
  low: NumberVO(001.45),
  yearHigh: NumberVO(85),
  yearLow: NumberVO(12.0),
  changePercentage: NumberVO(2.7),
  changePercentageMonth: NumberVO(3),
  changePercentageYear: NumberVO(.9),
);

final validQuoteWithStaticId2 = Quote(
  id: IdVO('12345'),
  price: NumberVO(4.5),
  high: NumberVO(4.7),
  low: NumberVO(01.45),
  yearHigh: NumberVO(85),
  yearLow: NumberVO(12.0),
  changePercentage: NumberVO(2.7),
  changePercentageMonth: NumberVO(3),
  changePercentageYear: NumberVO(7.9),
);
