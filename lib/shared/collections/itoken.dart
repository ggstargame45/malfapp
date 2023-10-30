import 'package:isar/isar.dart';


part 'itoken.g.dart';


@Collection()
class IToken{
  Id? id = 1;

  late String refreshToken;
  late String accessToken;
  late String userUniqId;

}