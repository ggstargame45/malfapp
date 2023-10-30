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
        if (UserMap().userMap[element["user_uniq_id"]] == null) {
          final dio = Dio(BaseOptions(
              baseUrl: baseUrl,
              headers: {'Authorization': Token().refreshToken},
              responseType: ResponseType.json));
          final response =
              await dio.get("/user/profile/${element["user_uniq_id"]}");
          final copyData = response.data['data'];
          if (copyData != []) {
            UserMap().userMap[element["user_uniq_id"]] =
                ProfileData.fromJson(copyData[0]);
          }
        }
      }
    }
    jsonData = await insideRequest();
    for (var element in jsonData) {
      insideList.add(AttendListData.fromJson(element));

      if (UserMap().userMap[element["user_uniq_id"]] == null) {
        final dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            headers: {'Authorization': Token().refreshToken},
            responseType: ResponseType.json));
        final response =
            await dio.get("/user/profile/${element["user_uniq_id"]}");
        final copyData = response.data['data'];
        if (copyData != []) {
          UserMap().userMap[element["user_uniq_id"]] =
              ProfileData.fromJson(copyData[0]);
        }
      }
    }

    // logger.d(jsonData);
    if (mounted) {
      setState(() {});
    }
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
    _loadChattingListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attend List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
//
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: chattingListData.length,
            //       itemBuilder: (context, index) {
            //         return Card(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(15),
            //             side: BorderSide(
            //               color: Colors.black,
            //             ),
            //           ),
            //           elevation: 16,
            //           shadowColor: Colors.grey,
            //           child: ListTile(
            //             style: ListTileStyle.drawer,
            //             leading: CircleAvatar(
            //                 radius: 25,
            //                 backgroundImage: ExtendedNetworkImageProvider(
            //                   baseUrl +
            //                       "/" +
            //                       chattingListData[index].picture[0],
            //                   cache: true,
            //                 )),
            //             title: Text(chattingListData[index].title),
            //             subtitle:
            //                 Text(chattingListData[index].postId.toString()),
            //             trailing: Text("2"
            //                 //chattingListData[index].personnel.toString()
            //                 ),
            //             onTap: () {
            //               GoRouter.of(context).push(
            //                   '/chatRoom/${chattingListData[index].postId}');
            //             },
            //           ),
            //         );
            //       }),
            // ),
//
            if (widget.isHost)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
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
                                      "$baseUrl/${UserMap().userMap[attendList[index].userUniqId]?.profilePic[0]}",
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
                                      ((UserMap()
                                                          .userMap[
                                                              attendList[index]
                                                                  .userUniqId]
                                                          ?.userType ??
                                                      0) ==
                                                  0
                                              ? "foreigner"
                                              : "local")
                                          .tr(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: (UserMap()
                                                          .userMap[
                                                              attendList[index]
                                                                  .userUniqId]
                                                          ?.userType ??
                                                      0) ==
                                                  0
                                              ? AppColors.primary
                                              : AppColors.white),
                                      backgroundColor: (UserMap()
                                                      .userMap[attendList[index]
                                                          .userUniqId]
                                                      ?.userType ??
                                                  0) ==
                                              0
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
                                      "거절",
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
                                        "승인",
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

                          // Row(children: [

                          // if(widget.isHost) TextButton(
                          //   child: Text("강퇴"),
                          //   onPressed: () async {
                          //       // final dio = Dio(BaseOptions(
                          //       //     baseUrl: baseUrl,
                          //       //     headers: {'Authorization': Token().refreshToken},
                          //       //     responseType: ResponseType.json));
                          //       // final response = await dio.delete("/chatroom/${widget.postId}/agreement/${attendList[index].userUniqId}");
                          //       // logger.d(response.data);
                          //       // _loadChattingListData();
                          //   },
                          // ),
                          // ]),
                        ),
                      );
                    }),
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
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
                                    "$baseUrl/${UserMap().userMap[insideList[index].userUniqId]?.profilePic[0]}",
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
                                    ((UserMap()
                                                        .userMap[
                                                            insideList[index]
                                                                .userUniqId]
                                                        ?.userType ??
                                                    0) ==
                                                0
                                            ? "foreigner"
                                            : "local")
                                        .tr(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: (UserMap()
                                                        .userMap[
                                                            insideList[index]
                                                                .userUniqId]
                                                        ?.userType ??
                                                    0) ==
                                                0
                                            ? AppColors.primary
                                            : AppColors.white),
                                    backgroundColor: (UserMap()
                                                    .userMap[insideList[index]
                                                        .userUniqId]
                                                    ?.userType ??
                                                0) ==
                                            0
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

                        // Row(children: [

                        // if(widget.isHost) TextButton(
                        //   child: Text("강퇴"),
                        //   onPressed: () async {
                        //       // final dio = Dio(BaseOptions(
                        //       //     baseUrl: baseUrl,
                        //       //     headers: {'Authorization': Token().refreshToken},
                        //       //     responseType: ResponseType.json));
                        //       // final response = await dio.delete("/chatroom/${widget.postId}/agreement/${attendList[index].userUniqId}");
                        //       // logger.d(response.data);
                        //       // _loadChattingListData();
                        //   },
                        // ),
                        // ]),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
