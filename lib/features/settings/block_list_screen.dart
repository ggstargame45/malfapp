import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/home/home_page_controller.dart';
import 'package:malf/shared/collections/iblockmeeting.dart';
import 'package:malf/shared/collections/iblockuser.dart';

import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/usecases/block_handle.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

class BlockListScreen extends StatefulWidget {
  const BlockListScreen({super.key});

  @override
  State<BlockListScreen> createState() => _BlockListScreenState();
}

class _BlockListScreenState extends State<BlockListScreen> {
  List<IBlockUser> blockUserList = [];
  List<IBlockMeeting> blockMeetingList = [];

  @override
  void initState() {
    super.initState();
    blockMeetingList = BlockSet().getBlockMeetingList();
    blockUserList = BlockSet().getBlockUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text('block_list'.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'user'.tr(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            if (blockUserList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blockUserList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          elevation: 16,
                          shadowColor: Colors.grey,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        blockUserList[index].blockedNickname),
                                  ),
                                ],
                              )),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "unblock".tr(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () async {
                                        logger.d(blockUserList[index]
                                            .blockedUserUniqId);
                                        BlockSet().removeBlockUser(
                                            blockedUserUniqId:
                                                blockUserList[index]
                                                    .blockedUserUniqId);
                                        pagingController.refresh();
                                        setState(() {
                                          blockUserList =
                                              BlockSet().getBlockUserList();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    }),
              ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'meeting'.tr(),
                  style: TextStyle(fontSize: 20),
                )),
            if (blockMeetingList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blockMeetingList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          elevation: 16,
                          shadowColor: Colors.grey,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Title : ${blockMeetingList[index].blockedTitle}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Host : ${blockMeetingList[index].blockedAuthorNickname}"),
                                  ),
                                ],
                              )),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "unblock".tr(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () async {
                                        BlockSet().removeBlockMeeting(
                                            blockedPostId:
                                                blockMeetingList[index]
                                                    .blockedPostId);
                                        pagingController.refresh();
                                        setState(() {
                                          blockMeetingList =
                                              BlockSet().getBlockMeetingList();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
