import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/chat/chat_room/chat_user_map.dart';
import 'package:malf/features/detail/attend_list_model.dart';
import 'package:malf/features/profile/profile_model.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

class AttendListScreen extends StatefulWidget {
  const AttendListScreen(
      {super.key, required this.postId, required this.isHost});

  final int postId;
  final bool isHost;

  @override
  State<AttendListScreen> createState() => _AttendListScreenState();
}

class _AttendListScreenState extends State<AttendListScreen> {
  List<AttendListData> attendList = [];
  List<AttendListData> insideList = [];

  void _loadChattingListData() async {
    attendList = [];
    insideList = [];
    // List<dynamic> jsonData = (await _dio.get("/bulletin-board/posts/")).data["data"];
    List<dynamic> jsonData;
    if (widget.isHost) {
      jsonData = await attendRequest();
      logger.d(jsonData);
      for (var element in jsonData) {
        if (element["user_uniq_id"] == Token().userUniqId) {
          continue;
        }
        attendList.add(AttendListData.fromJson(element));
      }
    }
    jsonData = await insideRequest();
    for (var element in jsonData) {
      insideList.add(AttendListData.fromJson(element));
    }
    setState(() {});

    // jsonData.forEach((element) {
    //   homeListData.add(ListItemData.fromJson(element));
    // }
    // );
    // chattingListData.add() = jsonData
    //     .map((data) =>
    //         ChattingListModel.fromJson(data))
    //         .toList();
  }

  Future<dynamic> attendRequest() async {
    try {
      final response = await Dio(BaseOptions(
              baseUrl: baseUrl,
              headers: {'Authorization': Token().refreshToken},
              responseType: ResponseType.json))
          .get("/chatroom/${widget.postId}/agreement");
      return response.data["data"];
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  Future<dynamic> insideRequest() async {
    try {
      final response = await Dio(BaseOptions(
              baseUrl: baseUrl,
              headers: {'Authorization': Token().refreshToken},
              responseType: ResponseType.json))
          .get("/chatroom/${widget.postId}/members");
      return response.data["data"];
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChattingListData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('attendance'.tr()),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
            ),
            onPressed: () {
              context.pop();
            },
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.isHost && attendList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: attendList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(
                              '/profileOther/${attendList[index].userUniqId}');
                        },
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: ExtendedImage.network(
                                      attendList[index].profilePic[0],
                                      cache: true,
                                      shape: BoxShape.circle,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                                    child: RoundedBackgroundText(
                                      (attendList[index].userType == 0
                                              ? "foreigner"
                                              : "local")
                                          .tr(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              (attendList[index].userType) == 0
                                                  ? AppColors.primary
                                                  : AppColors.white),
                                      backgroundColor:
                                          attendList[index].userType == 0
                                              ? AppColors.extraLightGrey
                                              : AppColors.primary,
                                      innerRadius: 20.0,
                                      outerRadius: 20.0,
                                    ),
                                  ),
                                  Text(attendList[index].nickname),
                                ],
                              )),
                              Row(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "reject".tr(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () async {
                                      try {
                                        final dio = Dio(BaseOptions(
                                            baseUrl: baseUrl,
                                            headers: {
                                              'Authorization':
                                                  Token().refreshToken
                                            },
                                            responseType: ResponseType.json));
                                        logger.d(await dio.delete(
                                            "/chatroom/${widget.postId}/agreement/?id=${attendList[index].userUniqId}"));
                                        _loadChattingListData();
                                      } catch (error) {
                                        logger.e(error);
                                        _loadChattingListData();
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 68, 68, 68)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 68, 68, 68)),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "accept".tr(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        try {
                                          final dio = Dio(BaseOptions(
                                              baseUrl: baseUrl,
                                              headers: {
                                                'Authorization':
                                                    Token().refreshToken
                                              },
                                              responseType: ResponseType.json));
                                          logger.d("/chatroom/${widget.postId}/agreement/?id=${attendList[index].userUniqId}");
                                          logger.d(await dio.post(
                                              "/chatroom/${widget.postId}/agreement/?id=${attendList[index].userUniqId}"));
                                          _loadChattingListData();
                                        } catch (error) {
                                          logger.e(error);
                                        }
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
            if (insideList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: insideList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(
                              '/profileOther/${insideList[index].userUniqId}');
                        },
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: ExtendedImage.network(
                                      insideList[index].profilePic[0],
                                      cache: true,
                                      shape: BoxShape.circle,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                                    child: RoundedBackgroundText(
                                      ((insideList[index].userType) == 0
                                              ? "foreigner"
                                              : "local")
                                          .tr(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              (insideList[index].userType) == 0
                                                  ? AppColors.primary
                                                  : AppColors.white),
                                      backgroundColor:
                                          (insideList[index].userType) == 0
                                              ? AppColors.extraLightGrey
                                              : AppColors.primary,
                                      innerRadius: 20.0,
                                      outerRadius: 20.0,
                                    ),
                                  ),
                                  Text(insideList[index].nickname),
                                ],
                              )),
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
