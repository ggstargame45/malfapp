import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
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
      setState(() {
        jsonData.forEach((element) {
          chattingListData.add(ChattingListModel.fromJson(element));
        });
        // jsonData.forEach((element) {
        //   homeListData.add(ListItemData.fromJson(element));
        // }
        // );
        // chattingListData.add() = jsonData
        //     .map((data) =>
        //         ChattingListModel.fromJson(data))
        //     .toList();
      });
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadChattingListData();
  }

  @override
  Widget build(BuildContext context) {
    logger.e("chatPage");
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 144, 148, 156),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 0,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "메세지",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        actions: [
          //TODO: 검색

          //TODO: 필터

          //TODO: 새로고침
          SafeArea(
            child: IconButton(
                iconSize: maxHeight * 0.05,
                onPressed: () {
                  setState(() {
                    _loadChattingListData();
                  });
                },
                icon: const Icon(Icons.refresh)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chattingListData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      elevation: 16,
                      shadowColor: Colors.grey,
                      child: ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: ExtendedNetworkImageProvider(
                              baseUrl +
                                  "/" +
                                  chattingListData[index].picture[0],
                              cache: true,
                            )),

                        title: Text(chattingListData[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        subtitle:
                            Text("👥 :${chattingListData[index].personnel}"),
                        // Text(chattingListData[index].postId.toString()),
                        // trailing: Text(
                        //   "👥 :"+chattingListData[index].personnel.toString()
                        //   ),
                        onTap: () async {
                          await context.push(
                              '/chatRoom/${chattingListData[index].postId}');
                          setState(() {
                            _loadChattingListData();
                          });
                        },
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
