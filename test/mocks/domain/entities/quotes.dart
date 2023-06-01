import 'package:king_investor_wallet/src/domain/entities/quote.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/number_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/positive_number_vo.dart';

Quote validQuoteWithRandomId1() => Quote(
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
      price: PositiveNumberVO(''),
      changePercentage: NumberVO(2.7),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(8.6),
      high: PositiveNumberVO(45.7),
      low: PositiveNumberVO(001.45),
      yearHigh: PositiveNumberVO(1),
      yearLow: PositiveNumberVO(12.0),
    );

Quote validQuoteWithRandomId2() => Quote(
      price: PositiveNumberVO(60.1),
      high: PositiveNumberVO(65),
      low: PositiveNumberVO(45),
      yearHigh: PositiveNumberVO(70),
      yearLow: PositiveNumberVO(40),
      changePercentage: NumberVO(15),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );

Quote validQuoteWEGE3() => Quote(
      price: PositiveNumberVO(37.61),
      high: PositiveNumberVO(38.34),
      low: PositiveNumberVO(37.61),
      yearHigh: PositiveNumberVO(42.42),
      yearLow: PositiveNumberVO(22.82),
      changePercentage: NumberVO(-1.90),
      changePercentageMonth: NumberVO(-8.54),
      changePercentageYear: NumberVO(-2.34),
    );

Quote validQuotePSSA3() => Quote(
      price: PositiveNumberVO(23.97),
      high: PositiveNumberVO(65),
      low: PositiveNumberVO(45),
      yearHigh: PositiveNumberVO(70),
      yearLow: PositiveNumberVO(40),
      changePercentage: NumberVO(15),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );

Quote validQuoteMDIA3() => Quote(
      price: PositiveNumberVO(39.01),
      high: PositiveNumberVO(65),
      low: PositiveNumberVO(45),
      yearHigh: PositiveNumberVO(70),
      yearLow: PositiveNumberVO(40),
      changePercentage: NumberVO(15),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );

Quote validQuoteTOTS3() => Quote(
      price: PositiveNumberVO(29.09),
      high: PositiveNumberVO(65),
      low: PositiveNumberVO(45),
      yearHigh: PositiveNumberVO(70),
      yearLow: PositiveNumberVO(40),
      changePercentage: NumberVO(15),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );

Quote validQuoteFLRY3() => Quote(
      price: PositiveNumberVO(15.87),
      high: PositiveNumberVO(65),
      low: PositiveNumberVO(45),
      yearHigh: PositiveNumberVO(70),
      yearLow: PositiveNumberVO(40),
      changePercentage: NumberVO(15),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );

Quote validQuoteHGRU11() => Quote(
      price: PositiveNumberVO(124.54),
      high: PositiveNumberVO(65),
      low: PositiveNumberVO(45),
      yearHigh: PositiveNumberVO(70),
      yearLow: PositiveNumberVO(40),
      changePercentage: NumberVO(15),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );

Quote validQuoteXPML11() => Quote(
      price: PositiveNumberVO(100.99),
      high: PositiveNumberVO(65),
      low: PositiveNumberVO(45),
      yearHigh: PositiveNumberVO(70),
      yearLow: PositiveNumberVO(40),
      changePercentage: NumberVO(15),
      changePercentageMonth: NumberVO(3),
      changePercentageYear: NumberVO(7.9),
    );
