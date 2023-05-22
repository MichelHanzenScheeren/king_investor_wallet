import 'package:king_investor_wallet/src/domain/entities/wallet.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

Wallet validWallet1() => Wallet(
      id: IdVO(null),
      name: TextVO('Carteira principal'),
      isDefault: true,
    );
