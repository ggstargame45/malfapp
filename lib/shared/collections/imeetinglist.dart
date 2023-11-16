import 'package:isar/isar.dart';

part 'imeetinglist.g.dart';

@Collection()
class IMeetingList{
  Id? id;

  @Index()
  late String ownUserUniqId;

  @Index()
  late String postId;

  @enumerated
  Status status = Status.WAITING;

}


enum Status{
  WAITING,
  ACCEPTED,
  REJECTED,
  CANCELED,
  FINISHED,
  DELETED
}