import 'package:isar/isar.dart';
import 'package:malf/shared/collections/imeetinglist.dart';
import 'package:malf/shared/network/token.dart';

class MeetingHandler{
  static final MeetingHandler _singletonModel = MeetingHandler._internal();
  factory MeetingHandler() => _singletonModel;
  MeetingHandler._internal();

  void applyMeeting({required String postId}){
    final isar = Isar.getInstance();
    final meeting = IMeetingList();
    meeting.postId = postId;
    meeting.ownUserUniqId = Token().userUniqId;
    isar!.writeTxnSync(() {
      isar.iMeetingLists.putSync(meeting);
    });
  }

  void updateMeeting(){
    
  }

  void updateAcceptMeeting(){

  }

  void updateReviewMeeting(){
    
  }
}