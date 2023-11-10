import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:malf/shared/collections/iblockmeeting.dart';
import 'package:malf/shared/collections/iblockuser.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/token.dart';

//singleton
class BlockSet {
  Set<String> blockUserUniqIdSet = {};
  Set<int> blockMeetingPostIdSet = {};
  static final BlockSet _singletonModel = BlockSet._internal();
  factory BlockSet() => _singletonModel;
  BlockSet._internal();

  void setInit() {
    blockUserUniqIdSet = getBlockUserUniqIdSet();
    blockMeetingPostIdSet = getBlockMeetingPostIdSet();
  }

  void addBlockUser({
    required String uniqId,
    required String nickname,
  }) {
    blockUserUniqIdSet.add(uniqId);
    setBlockUser(blockedUserUniqId: uniqId, blockedNickname: nickname);
  }

  void addBlockMeeting({
    required int postId,
    required String title,
    required String authorNickname,
  }) {
    blockMeetingPostIdSet.add(postId);
    setBlockMeeting(
        blockedPostId: postId,
        blockedTitle: title,
        blockedAuthorNickname: authorNickname);
  }

  void setBlockUser({
    required String blockedUserUniqId,
    required String blockedNickname,
  }) {
    final isar = Isar.getInstance();
    final blockUser = IBlockUser();
    blockUser.ownUserUniqId = Token().userUniqId;
    blockUser.blockedUserUniqId = blockedUserUniqId;
    blockUser.blockedNickname = blockedNickname;
    isar!.writeTxnSync(() {
      isar.iBlockUsers.putSync(blockUser);
    });
  }

  void setBlockMeeting({
    required int blockedPostId,
    required String blockedTitle,
    required String blockedAuthorNickname,
  }) {
    final isar = Isar.getInstance();
    final blockMeeting = IBlockMeeting();
    blockMeeting.ownUserUniqId = Token().userUniqId;
    blockMeeting.blockedPostId = blockedPostId;
    blockMeeting.blockedTitle = blockedTitle;
    blockMeeting.blockedAuthorNickname = blockedAuthorNickname;
    isar!.writeTxnSync(() {
      isar.iBlockMeetings.putSync(blockMeeting);
    });
  }

  void removeBlockUser({
    required String blockedUserUniqId,
  }) {
    final isar = Isar.getInstance();
    blockUserUniqIdSet.remove(blockedUserUniqId);
    
    isar!.writeTxnSync(() {
      isar.iBlockUsers
          .where()
          .ownUserUniqIdEqualTo(Token().userUniqId)
          .filter()
          .blockedUserUniqIdEqualTo(blockedUserUniqId)
          .deleteAllSync();
    });
  }

  void removeBlockMeeting({
    required int blockedPostId,
  }) {
    final isar = Isar.getInstance();
    blockMeetingPostIdSet.remove(blockedPostId);
    isar!.writeTxnSync(() {
      isar.iBlockMeetings
          .where()
          .ownUserUniqIdEqualTo(Token().userUniqId)
          .filter()
          .blockedPostIdEqualTo(blockedPostId)
          .deleteAllSync();
    });
  }

  Set<String> getBlockUserUniqIdSet() {
    final isar = Isar.getInstance();
    final blockUserList = isar!.iBlockUsers
        .where()
        .ownUserUniqIdEqualTo(Token().userUniqId)
        .findAllSync();
    final blockUserUniqIdSet = <String>{};
    for (final blockUser in blockUserList) {
      blockUserUniqIdSet.add(blockUser.blockedUserUniqId);
    }
    return blockUserUniqIdSet;
  }

  Set<int> getBlockMeetingPostIdSet() {
    final isar = Isar.getInstance();
    final blockMeetingList = isar!.iBlockMeetings
        .where()
        .ownUserUniqIdEqualTo(Token().userUniqId)
        .findAllSync();
    final blockMeetingUniqIdSet = <int>{};
    for (final blockMeeting in blockMeetingList) {
      blockMeetingUniqIdSet.add(blockMeeting.blockedPostId);
    }
    return blockMeetingUniqIdSet;
  }

  List<IBlockMeeting> getBlockMeetingList() {
    final isar = Isar.getInstance();
    return isar!.iBlockMeetings
        .where()
        .ownUserUniqIdEqualTo(Token().userUniqId)
        .findAllSync();
  }

  List<IBlockUser> getBlockUserList() {
    final isar = Isar.getInstance();
    return isar!.iBlockUsers
        .where()
        .ownUserUniqIdEqualTo(Token().userUniqId)
        .findAllSync();
  }
}
