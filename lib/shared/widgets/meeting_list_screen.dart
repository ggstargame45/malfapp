import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/home/home_list_model.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MeetingListScreen extends StatefulWidget {
  const MeetingListScreen({super.key, required this.kind, this.kindId = 1});
  //like, write, apply,
  //TODO : category
  final String kind;
  final int kindId;

  @override
  State<MeetingListScreen> createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends State<MeetingListScreen> {
  List<ListItemData> meetingListData = [];

  void _loadMeetingListData() async {
    meetingListData = [];
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': Token().refreshToken,
        },
        responseType: ResponseType.json,
      ),
    );
    List<dynamic> jsonData = [];
    try {
      final response =
          await dio.get("/user/${Token().userUniqId}/${widget.kind}list");
      jsonData = response.data["data"];
    } on Exception catch (e) {
      // TODO
      logger.e(e);
    }
    // List<dynamic> jsonData = (await dio.get("/bulletin-board/posts/?category=${widget.kindId}")).data["data"];
    setState(() {
      for (var element in jsonData) {
        logger.d(element);
        if (element['local_participation'] == null) {
          element['local_participation'] = 0;
        }
        if (element['travel_participation'] == null) {
          element['travel_participation'] = 0;
        }
        if (element['post_status'] != -1) {
          meetingListData.add(ListItemData.fromJson(element));
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMeetingListData();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

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
          widget.kind == "like"
              ? "like_meeting".tr()
              : (widget.kind == "write"
                  ? "made_meeting".tr()
                  : (widget.kind == "apply"
                      ? "attend_meeting".tr()
                      : (widget.kind == "category"
                          ? "category".tr()
                          : "error".tr()))),
          // style: TextStyle(
          //   color: Colors.black,
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        // title: widget.categoryId == 1
        //     ? Text("chinese").tr()
        //     : (widget.categoryId == 2
        //         ? Text("english").tr()
        //         : Text("japanese").tr()),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meetingListData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () async {
                      await context
                          .push('/detail/${meetingListData[index].postId}');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        height: 132,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 12, 0),
                              child: SizedBox(
                                width: 76,
                                height: 76,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ExtendedImage.network(
                                    meetingListData[index].meetingPic[0],
                                    // headers: {
                                    //   'Authorization': Token().refreshToken,
                                    // },
                                    // cache: true,
                                    // loadStateChanged:
                                    //     (ExtendedImageState state) {
                                    //   switch (state.extendedImageLoadState) {
                                    //     case LoadState.loading:
                                    //       return const Center(
                                    //         child: CircularProgressIndicator(
                                    //           color: Colors.amber,
                                    //         ),
                                    //       );
                                    //     case LoadState.completed:
                                    //       return null;
                                    //     case LoadState.failed:
                                    //       return const Center(
                                    //         child: Text('😢'),
                                    //       );
                                    //   }
                                    // },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: maxWidth - 150),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${CountryCode.tryParse("${meetingListData[index].authorNation}")?.symbol ?? "?"} ",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${meetingListData[index].authorNickname} ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8.0, 0),
                                          child: RoundedBackgroundText(
                                            "${meetingListData[index].userType == 0 ? "foreigner".tr() : "local".tr()} ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: meetingListData[index]
                                                            .userType ==
                                                        0
                                                    ? AppColors.primary
                                                    : AppColors.white),
                                            backgroundColor:
                                                meetingListData[index]
                                                            .userType ==
                                                        0
                                                    ? AppColors.extraLightGrey
                                                    : AppColors.primary,
                                            innerRadius: 20.0,
                                            outerRadius: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(meetingListData[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8.0, 0, 0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 234, 234, 234),
                                                    width: 2),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: const Color.fromARGB(
                                                    255, 247, 247, 247),
                                              ),
                                              child: Text(
                                                " ${meetingListData[index].meetingLocation} ",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontFamily: 'Pretendard',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 234, 234, 234),
                                                  width: 2),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: const Color.fromARGB(
                                                  255, 247, 247, 247),
                                            ),
                                            child: Text(
                                              " ${meetingListData[index].meetingStartTime.year}.${meetingListData[index].meetingStartTime.month}.${meetingListData[index].meetingStartTime.day} | ${meetingListData[index].meetingStartTime.hour < 10 ? "0${meetingListData[index].meetingStartTime.hour}" : meetingListData[index].meetingStartTime.hour.toString()} : ${meetingListData[index].meetingStartTime.minute < 10 ? "0${meetingListData[index].meetingStartTime.minute}" : meetingListData[index].meetingStartTime.minute} ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Row(
                                        children: [
                                          Text("${"foreigner".tr()} ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 113, 162, 254),
                                              )),
                                          Text(
                                              meetingListData[index]
                                                  .travelParticipation
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 113, 162, 254),
                                              )),
                                          Text(
                                              "/${meetingListData[index]
                                                      .capacityTravel} | ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Colors.grey,
                                              )),
                                          Text("${"local".tr()} ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 97, 195, 255),
                                              )),
                                          Text(
                                              meetingListData[index]
                                                  .localParticipation
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 97, 195, 255),
                                              )),
                                          Text(
                                              "/${meetingListData[index]
                                                      .capacityLocal}",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Colors.grey,
                                              )),
                                          //TODO: need space between
                                          const Spacer(),

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 8.0, 0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.heart_fill,
                                                  color: Colors.red,
                                                  size: 16,
                                                ),
                                                Text(
                                                    meetingListData[index]
                                                        .likeCount
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
        ]),
      ),
    );
  }
}
