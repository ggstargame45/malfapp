import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/community/community_model.dart';
import 'package:malf/features/home/home_screen.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/svg_strings.dart';

class CommunityListScreen extends StatefulWidget {
  const CommunityListScreen(
      {super.key, required this.kind, this.kindId = 1, this.extraData});
  final String kind;
  final int kindId;
  final Object? extraData;

  @override
  State<CommunityListScreen> createState() => _CommunityListScreenState();
}

class _CommunityListScreenState extends State<CommunityListScreen> {
  List<CommunityData> communityList = [];

  @override
  void initState() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': Token().refreshToken,
        },
        responseType: ResponseType.json,
      ),
    );

    dio
        .get("/user/${Token().userUniqId}/community-${widget.kind}list")
        .then((value) {
      if ((value.statusCode ?? 201) == 200) {
        communityList = (value.data["data"] as List<dynamic>)
            .map((e) => CommunityData.fromJson(e))
            .toList();
        logger.d(communityList);
        setState(() {});
      } else {
        logger.d(value.data);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: false,
        title: Text(
          widget.kind == "write"
              ? "my_posting".tr()
              : widget.kind == "scrap"
                  ? "my_scrap_posting".tr()
                  : "my_scrap_posting".tr(),
          // style: TextStyle(
          //   color: Colors.black,
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: communityList.length,
            itemBuilder: (context, index) {
              String timeDiffString;
              Duration dateDiffSec = DateTime.now()
                  .difference(communityList[index].createAt.add(const Duration(hours: 9)));
              if (dateDiffSec.inSeconds < 60) {
                timeDiffString = "seconds_ago".plural(dateDiffSec.inSeconds);
              }
              if (dateDiffSec.inMinutes < 60) {
                timeDiffString = "minutes_ago".plural(dateDiffSec.inMinutes);
              } else if (dateDiffSec.inHours < 24) {
                timeDiffString = "hours_ago".plural(dateDiffSec.inHours);
              } else if (dateDiffSec.inDays < 7) {
                timeDiffString = "days_ago".plural(dateDiffSec.inDays);
              } else if (dateDiffSec.inDays < 30) {
                timeDiffString = "weeks_ago".plural(dateDiffSec.inDays ~/ 7);
              } else if (dateDiffSec.inDays < 365) {
                timeDiffString = "months_ago".plural(dateDiffSec.inDays ~/ 31);
              } else {
                timeDiffString = "years_ago".plural(dateDiffSec.inDays ~/ 365);
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    height: 124,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.push('/communityDetail/${communityList[index].postId}');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 20, bottom: 20, right: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                      child: Text(communityList[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 24, 0),
                                        child: Text(
                                          //item.content,
                                          communityList[index].content,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          SvgPicture.string(
                                            reReplyButtonSvgString,
                                            height: 14,
                                          ),
                                          Text(
                                            " ${communityList[index].replyCount}",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          Expanded(
                                            child: Text(
                                              " | $timeDiffString | ${communityList[index].authorNickname}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (communityList[index].picture.isNotEmpty)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ExtendedImage.network(
                                      communityList[index].picture[0],
                                      height: 84,
                                      width: 84,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
