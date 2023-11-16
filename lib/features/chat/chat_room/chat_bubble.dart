import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:malf/features/chat/chat_room/chat_user_map.dart';
import 'package:malf/features/chat/chat_room/message_model.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:malf/shared/widgets/image_view_widget.dart';

const enter = ["이(가) 들어왔습니다", "が部屋に入ってきた", "参加了聊天", "has entered the room"];
const leave = ["이(가) 나갔습니다", "が退出しました", "退出了聊天", "has left the room"];

Widget _buildTimeStamp(DateTime sendAt) {
  return Row(
    children: [
      Text(
        DateFormat('hh:mm a').format(sendAt),
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      ),
    ],
  );
}

void showImage(BuildContext context, String imgSrc) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            width: 250,
            height: 450,
            alignment: Alignment.center,
            child: ExtendedImage.network(imgSrc, cache: true, fit: BoxFit.fill),
          ),
        );
      });
}

Widget _buildMessageBubble(BuildContext context, bool isSentByCurrentUser,
    Message message, String postId) {
  List<String> imgList = [];
  if (message.type == 1) {
    imgList = List<String>.from(jsonDecode(message.message));
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if (isSentByCurrentUser) _buildTimeStamp(message.sendAt),
      message.type == 1
          ? Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
                maxHeight: 300,
              ),
              child: ListView.builder(
                itemCount: imgList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    imageNetworkListViewer(
                        imageUrls: imgList, context: context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExtendedImage.network(
                        imgList[index],
                        cache: true,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
            )
          : ChatBubble(
              clipper: ChatBubbleClipper5(
                  type: isSentByCurrentUser
                      ? BubbleType.sendBubble
                      : BubbleType.receiverBubble),
              alignment:
                  isSentByCurrentUser ? Alignment.topRight : Alignment.topLeft,
              margin: const EdgeInsets.only(right: 4, left: 4),
              backGroundColor: isSentByCurrentUser ? Colors.blue : Colors.white,
              child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                    maxHeight: 300,
                  ),
                  child: SelectableText(
                    message.message,
                    style: TextStyle(
                        color:
                            isSentByCurrentUser ? Colors.white : Colors.black),
                  )),
            ),
      if (!isSentByCurrentUser) _buildTimeStamp(message.sendAt),
    ],
  );
}

class ChatBubbleMessage extends StatefulWidget {
  final String postId;
  final String userName;
  final Message message;
  final String? beforeUser;
  final DateTime? beforeTime;
  final List<XFile>? pickedImages;
  final String imageSrc;
  const ChatBubbleMessage(
      {super.key,
      required this.postId,
      required this.userName,
      required this.message,
      required this.imageSrc,
      this.beforeUser,
      this.beforeTime,
      this.pickedImages});

  @override
  State<ChatBubbleMessage> createState() => _ChatBubbleMessageState();
}

class _ChatBubbleMessageState extends State<ChatBubbleMessage> {
  @override
  Widget build(BuildContext context) {
    //logger.d("beforeUser : ${widget.beforeUser}, beforeTime : ${widget.userName},userName : ${widget.message.sender}");
    bool isSentByCurrentUser = widget.userName == widget.message.sender;
    // bool isImgMessage = widget.message.type == 1;
    int lang;
    switch (context.locale.languageCode) {
      case 'ko':
        lang = 0;
        break;
      case 'ja':
        lang = 1;
        break;
      case 'zh':
        lang = 2;
        break;
      default:
        lang = 3;
    }
    if (widget.message.type == 2) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${UserMap().userMap[widget.message.sender]?.nickname ?? widget.message.sender} ${enter[lang]}",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    if (widget.message.type == 3) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${UserMap().userMap[widget.message.sender]?.nickname ?? widget.message.sender} ${leave[lang]}",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: widget.userName == widget.beforeUser
          ? const EdgeInsets.only(top: 2)
          : const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: isSentByCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSentByCurrentUser &&
              widget.message.sender != widget.beforeUser)
            GestureDetector(
              onTap: () {
                // logger.d("profileOther/${widget.message.sender}");
                context.push("/profileOther/${widget.message.sender}");
              },
              child: CircleAvatar(
                  radius: 15,
                  backgroundImage: ExtendedNetworkImageProvider(
                    "${UserMap().userMap[widget.message.sender]?.profilePic == [] ? "default.png" : UserMap().userMap[widget.message.sender]!.profilePic[0]}",
                    cache: true,
                  )),
            ),
          if (!isSentByCurrentUser &&
              widget.message.sender == widget.beforeUser)
            const SizedBox(
              width: 32,
            ),
          const SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.message.sender != widget.beforeUser &&
                  !isSentByCurrentUser)
                Text(
                  UserMap().userMap[widget.message.sender]?.nickname ??
                      widget.message.sender,
                ),
              _buildMessageBubble(
                  context, isSentByCurrentUser, widget.message, widget.postId),
              const SizedBox(height: 3),
            ],
          ),
        ],
      ),
    );
  }
}
