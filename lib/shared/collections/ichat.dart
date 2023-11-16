import 'package:isar/isar.dart';

part 'ichat.g.dart';

@Collection()
class IChat{
  Id? id;

  @Index()
  late String ownUserUniqId;
  
  @Index()
  late String postId;

  List<IMessage>? messages;

}


@Embedded()
class IMessage {
  String? id;
  String? room;
  String? message;
  DateTime? sendAt;
  int? type;
}

