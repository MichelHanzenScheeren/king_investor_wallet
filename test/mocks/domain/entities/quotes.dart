import 'package:king_investor_wallet/src/domain/entities/quote.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';

Quote validQuoteWithRandomId1() => Quote(
      id: IdVO(null),
      price: PositiveNumberVO(1.5),
      high: PositiveNumberVO(45.7),
      low: PositiveNumberVO(001.45),
      yearHigh: PositiveNumberVO(85),
      yearLow: PositiveNumberVO(12.0),
      changePercentage: NumberVO(2.7),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(.9),
    );

Quote invalidQuoteWithRandomId1() => Quote(
      id: IdVO(null),
      price: PositiveNumberVO(1.5),
      changePercentage: NumberVO(2.7),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(null),
      high: PositiveNumberVO(45.7),
      low: PositiveNumberVO(001.45),
      yearHigh: PositiveNumberVO(''),
      yearLow: PositiveNumberVO(12.0),
    );

Quote validQuoteWithStaticId1() => Quote(
      id: IdVO('12345'),
      price: PositiveNumberVO(1.5),
      high: PositiveNumberVO(45.7),
      low: PositiveNumberVO(001.45),
      yearHigh: PositiveNumberVO(85),
      yearLow: PositiveNumberVO(12.0),
      changePercentage: NumberVO(2.7),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(.9),
    );

Quote validQuoteWithStaticId2() => Quote(
      id: IdVO('12345'),
      price: PositiveNumberVO(4.5),
      high: PositiveNumberVO(4.7),
      low: PositiveNumberVO(01.45),
      yearHigh: PositiveNumberVO(85),
      yearLow: PositiveNumberVO(12.0),
      changePercentage: NumberVO(2.7),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );

Quote invalidQuoteWithInvalidPrice() => Quote(
      id: IdVO(null),
      price: PositiveNumberVO(''),
      changePercentage: NumberVO(2.7),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(8.6),
      high: PositiveNumberVO(45.7),
      low: PositiveNumberVO(001.45),
      yearHigh: PositiveNumberVO(1),
      yearLow: PositiveNumberVO(12.0),
    );
