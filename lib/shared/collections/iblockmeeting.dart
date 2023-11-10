import 'package:isar/isar.dart';
import 'package:malf/shared/collections/fast_hash.dart';


part 'iblockmeeting.g.dart';


@Collection()
class IBlockMeeting{
  Id? id;

  @Index()
  late String ownUserUniqId;

  late int blockedPostId;

  late String blockedTitle;
  late String blockedAuthorNickname;
}
