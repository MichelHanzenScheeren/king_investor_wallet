import 'package:king_investor_wallet/src/domain/entities/user.dart';
import 'package:king_investor_wallet/src/domain/value_objects/email_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';
import 'package:king_investor_wallet/src/domain/value_objects/text_vo.dart';

User validUser1() => User(
      name: TextVO('Michel Scheeren'),
      email: EmailVO('michel@gmail.com'),
    );

User validUserWithToken() => User(
      name: TextVO('Michel Scheeren'),
      email: EmailVO('michel@gmail.com'),
      sessionToken: IdVO('abc12345678'),
    );

User invalidUserWithInvalidEmail() => User(
      name: TextVO('Michel Scheeren'),
      email: EmailVO('michel.com'),
    );
