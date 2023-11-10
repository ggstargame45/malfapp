import 'package:isar/isar.dart';

part 'iblockuser.g.dart';

@Collection()
class IBlockUser{
  Id? id;

  @Index()
  late String ownUserUniqId;

  late String blockedUserUniqId;
  late String blockedNickname;
}