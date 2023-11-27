import 'package:isar/isar.dart';

part 'iuserstatus.g.dart';

@Collection()
class IUserStatus{
  Id? id;

  @Index()
  late String ownUserUniqId;

  int status = -1;
}