import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:malf/features/chat/chat_list/chat_page_controller.dart';
import 'package:malf/features/chat/chat_list/chatting_list_data_model.dart';
import 'package:malf/features/home/home_list_model.dart';
import 'package:malf/features/home/home_screen.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_theme.dart';
import 'package:malf/shared/theme/text_theme.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const String routeName = '/chat';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
      responseType: ResponseType.json));

  List<ChattingListModel> chattingListData = [];
  // List<ListItemData> homeListData= [];

  Future<dynamic> request() async {
    try {
      final response = await _dio.get("/chatroom/chatrooms");
      return response.data["data"];
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  Future<void> _loadChattingListData() async {
    try {
      chattingListData = [];
      // homeListData = [];
      // List<dynamic> jsonData = (await _dio.get("/bulletin-board/posts/")).data["data"];

      List<dynamic> jsonData = await request();
      logger.d(jsonData);
      for (var element in jsonData) {
          chattingListData.add(ChattingListModel.fromJson(element));
        }
      pagingChatController.appendLastPage(chattingListData);
      // setState(() {
        
      //   // jsonData.forEach((element) {
      //   //   homeListData.add(ListItemData.fromJson(element));
      //   // }
      //   // );
      //   // chattingListData.add() = jsonData
      //   //     .map((data) =>
      //   //         ChattingListModel.fromJson(data))
      //   //     .toList();
      // });
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pagingChatController.addPageRequestListener((pageKey) {
      logger.d("pageKey : $pageKey");
      _loadChattingListData();
      // _getAd();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    logger.e("chatPage");
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "chat".tr(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        actions: [
          //TODO: 검색

          //TODO: 필터

          //TODO: 새로고침
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          pagingChatController.refresh();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PagedListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        pagingController: pagingChatController,
                        builderDelegate:
                            PagedChildBuilderDelegate<ChattingListModel>(
                          animateTransitions: true,
                          itemBuilder: (context, item, index) =>
                              GestureDetector(
                            onTap: () async {
                              await context.push(
                                  '/chatRoom/${chattingListData[index].postId}');
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SizedBox(
                                height: 88,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: ExtendedImage.network(
                                        "${chattingListData[index].picture[0]}",
                                        width: 56,
                                        height: 56,
                                        fit: BoxFit.cover,
                                        cache: true,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 12, 0, 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    chattingListData[index]
                                                        .title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    )),
                                              ),
                                              const Icon(Icons.person),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Text(
                                                    "${chattingListData[index].personnel}"),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.center,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: Badge(
                                    //         label: Text(" N ",
                                    //             style: TextStyle(
                                    //                 fontSize: 12,
                                    //                 fontWeight:
                                    //                     FontWeight.bold)),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                                // child: ListTile(
                                //   // style: ListTileStyle.drawer,
                                //   leading: CircleAvatar(
                                //       radius: 30,
                                //       backgroundImage: ExtendedNetworkImageProvider(
                                //         baseUrl +
                                //             "/" +
                                //             chattingListData[index].picture[0],
                                //         cache: true,
                                //       )),

                                //   title: Text(chattingListData[index].title,
                                //       style: TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 17,
                                //       )),
                                //   // subtitle:
                                //   //     Text("👥 :${chattingListData[index].personnel}"),
                                //   // Text(chattingListData[index].postId.toString()),
                                //   trailing: Text(
                                //     "👥 :"+chattingListData[index].personnel.toString()
                                //     ),
                                //   onTap: () async {
                                //     await context.push(
                                //         '/chatRoom/${chattingListData[index].postId}');
                                //     setState(() {
                                //       _loadChattingListData();
                                //     });
                                //   },
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
