import 'package:isar/isar.dart';


part 'iblockposting.g.dart';


@Collection()
class IBlockPosting{
  Id? id;

  @Index()
  late String ownUserUniqId;

  late int blockedPostId;

  late String blockedTitle;
  late String blockedAuthorNickname;
}
