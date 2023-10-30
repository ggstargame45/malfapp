import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/chat/chat_room/add_image.dart';
import 'package:malf/features/chat/chat_room/chat_user_map.dart';
import 'package:malf/features/home/home_screen.dart';
import 'package:malf/features/profile/profile_model.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'chat_bubble.dart';
import 'message_model.dart';

class ChatRoomScreen extends StatefulWidget {
  final int roomId;
  const ChatRoomScreen({Key? key, required this.roomId}) : super(key: key);

  static const String routeName = '/chatRoom';

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();
  final List<Message> _messages = [];
  late Timer chatTimer;

  String? title;
  String? content;
  String? location;
  String? authorNickname;
  String? chatRoomImage;

  Future<void> addMessage(Message data) async {
    if (UserMap().userMap[data.sender] == null) {
      final dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'Authorization': Token().refreshToken},
          responseType: ResponseType.json));
      final response = await dio.get("/user/profile/${data.sender}");
      final copyData = response.data['data'];
      if (copyData != []) {
        UserMap().userMap[data.sender] = ProfileData.fromJson(copyData[0]);
      }
    }
    _messages.insert(0, data);

    if (mounted) {
      setState(() {});
    }
  }

  void _connectSocket() {
    try {
      _socket = IO.io(
        'http://13.125.43.68:8000/chat',
        IO.OptionBuilder()
            .setPath("/chatTest")
            .setTransports(['websocket']).build(),
      );
      _socket.onConnect((data) => logger.d('Connection established'));
      _socket.onConnectError((data) => logger.d('Connect Error: $data'));
      _socket.onDisconnect((data) => logger.d('Socket.IO server disconnected'));
      _socket.emit(
          "join", {"room": "${widget.roomId}", "sender": Token().userUniqId});
      _socket.on(
          'join',
          (data) => {
                logger.d(data),
              });
      _socket.on('image', (data) {
        logger.d("imagedata : $data");
        addMessage(Message.fromJson(data));
      });
      _socket.on('chat', (data) {
        logger.d("chatdata : $data");
        addMessage(Message.fromJson(data));
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getChatDetail() async {
    final chatRoomDetailData = await Dio(BaseOptions(
            baseUrl: baseUrl, headers: {'Authorization': Token().refreshToken}))
        .get("/bulletin-board/posts/${widget.roomId}");
    //logger.d(chatRoomDetailData.data['data'][0]);
    title = chatRoomDetailData.data['data'][0]['title'];
    authorNickname = chatRoomDetailData.data['data'][0]['author_nickname'];
    location = chatRoomDetailData.data['data'][0]['meeting_location'];
    chatRoomImage =
        jsonDecode(chatRoomDetailData.data['data'][0]['meeting_pic'])[0];
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _connectSocket();
    getChatDetail();
    getInitChat();
  }

  @override
  void dispose() {
    _socket.disconnect();
    //chatTimer.cancel();
    super.dispose();
  }

  _sendMessage() {
    _socket.emit('chat', {
      'room': "${widget.roomId}",
      'message': _messageInputController.text.trim(),
      'sender': Token().userUniqId
    });

    // Provider.of<MessageProvider>(context, listen: false).addNewMessage(
    //   Message(
    //     room: 'Room4',
    //     message: _messageInputController.text.trim(),
    //     sender: widget.userName,
    //     sendAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
    //   ),
    // );
    logger.d(_messageInputController.text);
    _messageInputController.clear();
  }

  Future<void> getInitChat() async {
    final chatValue = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
    ));

    final val = await chatValue.get("/chat/chats/${widget.roomId}");
    _messages.clear();
    for (int i = 0; i < val.data['data'].length; i++) {
      addMessage(Message.fromJson(val.data['data'][i]));
    }
  }

  void showImagePicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AddImageState(
            postId: widget.roomId.toString(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              context.pop();
            },
          ),
          title: Center(
              child: Text(
            title ?? "",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          actions: [
            IconButton(
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0, 0),
                    items: [
                      PopupMenuItem(
                        child: Text("report".tr()),
                        value: 1,
                        onTap: () {
                          context.push("/report", extra: {
                            "reportType": "chat",
                            "id": widget.roomId.toString(),
                            "title": title
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("leave".tr()),
                        value: 2,
                        onTap: () async {
                          // _socket.emit("leave", {"room": widget.roomId, "sender": Token().userUniqId});
                          try {
                            final response = await Dio(BaseOptions(
                                    baseUrl: baseUrl,
                                    headers: {
                                      'Authorization': Token().refreshToken
                                    },
                                    responseType: ResponseType.json))
                                .delete("/chatroom/${widget.roomId}/chatroom");
                            if (response.statusCode == 200) {
                              GoRouter.of(context).pop();
                              return;
                            }
                          } on Exception catch (e) {
                            // TODO
                            logger.e(e);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("fail".tr()))); //"채팅방 나가기 실패"
                        },
                      ),
                    ],
                  );
                  // ).then((value) {
                  //   if(value == 2){
                  //     _socket.emit("leave", {"room": widget.roomId, "sender": Token().userUniqId});
                  //     context.go(HomeScreen.routeName);
                  //   }
                  // });
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            final beforeMessageUser =
                                index == _messages.length - 1
                                    ? null
                                    : _messages[index + 1].sender;
                            final beforeMessageTime =
                                index == _messages.length - 1
                                    ? null
                                    : _messages[index + 1].sendAt;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: ChatBubbleMessage(
                                postId: widget.roomId.toString(),
                                userName: Token().userUniqId,
                                message: message,
                                beforeTime: beforeMessageTime,
                                beforeUser: beforeMessageUser,
                                imageSrc: ""
                                //ChatProfileProvider().getImageById(_messages[index].sender)
                                ,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      decoration: const BoxDecoration(color: Colors.white),
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: _messageInputController,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      showImagePicker(context);
                                    },
                                    icon: const Icon(Icons.photo, size: 30)),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(8),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(97, 158, 158, 158),
                                hintText: "chat_room_input_hint".tr(),
                                hintStyle: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            maxLines: null,
                          )),
                          IconButton(
                            onPressed: () {
                              if (_messageInputController.text
                                  .trim()
                                  .isNotEmpty) {
                                _sendMessage();
                              }
                            },
                            icon: const Icon(Icons.send),
                            color: Colors.blue,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            KeyboardVisibilityBuilder(builder: (context, iskeyboardVisible) {
              return Visibility(
                visible: !iskeyboardVisible,
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 5),
                          blurRadius: 5)
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: ExtendedNetworkImageProvider(
                                    baseUrl +
                                        "/" +
                                        (chatRoomImage ?? "ad/1.png"),
                                  ),
                                  fit: BoxFit.cover),
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        SizedBox(
                          width: 300,
                          height: 80,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(authorNickname?.toString() ?? ""),
                                  ],
                                ),
                                Text(title?.toString() ?? "",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [Text(location?.toString() ?? "")],
                                )
                              ]),
                        )
                      ]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
