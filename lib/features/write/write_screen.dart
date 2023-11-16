import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:malf/shared/logger.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/permission.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/usecases/image_compress.dart';
import 'package:malf/shared/usecases/loading.dart';

const String subUri = '/bulletin-board/posts/';

class PostingBody {
  String title;
  String content;
  String meeting_start_time;
  String category;
  String meeting_location;
  String capacity_local;
  String capacity_travel;
  PostingBody({
    required this.title,
    required this.content,
    required this.meeting_start_time,
    required this.category,
    required this.meeting_location,
    required this.capacity_local,
    required this.capacity_travel,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['title'] = title;
    data['content'] = content;
    data['meeting_start_time'] = meeting_start_time;
    data['category'] = category;
    data['meeting_location'] = meeting_location;
    data['capacity_local'] = capacity_local;
    data['capacity_travel'] = capacity_travel;
    return data;
  }
}

Future<bool> postPosting(PostingBody data, List<XFile> imageList) async {
  var imageFileList = <File>[];
  http.MultipartRequest request;
  StreamedResponse? response;
  int isUploaded = 0;

  
  for (int i = 0; i < imageList.length; i++) {
    imageFileList.add(await compressImage(File(imageList[i].path), 70));
  }

  try {
    while (isUploaded < 10) {
      request = http.MultipartRequest('POST', Uri.parse(baseUrl + subUri));
      try {
        for (int i = 0; i < imageList.length; i++) {
          request.files.add(await http.MultipartFile.fromPath(
              'image', imageFileList[i].path));
        }
      } on Exception catch (e) {
        // TODO
        logger.e(e);
        return false;
      }
      var mapdata = {
        'title': data.title,
        'content': data.content,
        'meeting_start_time': data.meeting_start_time,
        'category': data.category,
        'meeting_location': data.meeting_location,
        'capacity_local': data.capacity_local,
        'capacity_travel': data.capacity_travel,
      };

      String token = Token().refreshToken;

      request.headers['Authorization'] = token;
      request.headers['Content-Type'] = 'multipart/form-data;';

      request.fields.addAll(mapdata);
      StreamedResponse response = await request.send();
      logger.d(response.reasonPhrase);
      if (response.statusCode == 200) {
        logger.d('요청이 성공적으로 처리되었습니다.');
        return true;
      } else {
        logger.e('요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
      }
      isUploaded++;
    }
  } on Exception catch (e) {
    // TODO
    logger.e(e);
    return false;
  }
  return false;
}

Future<Uint8List> fileToByte(XFile file) async {
  return await file.readAsBytes();
}

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  static const String routeName = '/write';

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final picker = ImagePicker(); // 이미지피커
  List<XFile> imageList = []; // 이미지 리스트
  String title = "";
  String content = "";
  String categoryChosen = "";
  bool categoryChosenBool = false;
  String location = "";
  int category = -1;
  DateTime meetingDate = DateTime.now();
  TimeOfDay meetingTime = TimeOfDay.now();
  int localCapacity = 1;
  int travelCapacity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              if (mounted) {
                context.pop();
              }
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () async {
                if (mounted) {
                  context.pop();
                }
              },
              color: Colors.black,
              icon: const Icon(Icons.close_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(
          initialScrollOffset: 600,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "write_title".tr(),
                style: const TextStyle(
                  color: Color(0xFF292524),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                "picture".tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (imageList.length < 10) {
                          try {
                            if (!(await photoPermission())) return;
                            final image =
                                await picker.pickMultiImage(); // 갤러리에서 이미지 뽑아옴

                            setState(() {
                              imageList.addAll(image);

                              if (imageList.length > 10) {
                                imageList.removeRange(10, imageList.length);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("photo_upload_warning".tr())));
                              }
                            });
                          } catch (e) {
                            logger.e(e);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        backgroundColor: const Color(0xFFF7F7F7),
                        side: const BorderSide(
                            width: 1, color: Color(0xFFD3D3D3)),
                        elevation: 0,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera_rounded,
                            size: 38,
                            color: Color(0xFFBEBEBE),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      16), // ClipRRect의 모서리 설정
                                  child: Stack(
                                    children: [
                                      ExtendedImage.file(
                                        File(imageList[index].path),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              child: FloatingActionButton(
                                                backgroundColor:
                                                    const Color(0xFFD3D3D3),
                                                onPressed: () {
                                                  setState(() {
                                                    imageList.removeAt(index);
                                                  });
                                                }, // 해당 이미지 삭제
                                                child: const Icon(Icons.close,
                                                    size: 15,
                                                    color: Colors.white),
                                              )))
                                    ],
                                  )));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const VerticalDivider(),
                        itemCount: imageList.length),
                  ),
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Text(
                "title".tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.065,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFFD3D3D3)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "write_title_hint".tr(),
                            hintStyle: const TextStyle(
                              color: Color(0xFFBEBEBE),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            setState(() {
                              title = text;
                            });
                          }),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Text(
                "context".tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFFD3D3D3)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextField(
                        scrollController: ScrollController(
                          initialScrollOffset: 0,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText:
                              "${"write_content_hint".tr()}${"writing_warning_first".tr()}\n${"writing_warning_second".tr()}",
                          hintStyle: const TextStyle(
                            color: Color(0xFFBEBEBE),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setState(() {
                            content = text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Text(
                "category".tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: GestureDetector(
                onTap: () {
                  showConfirmationDialog(
                      context: context,
                      title: "choose_category_notice".tr(),
                      message: "choose_category_notice".tr(),
                      actions: [
                        AlertDialogAction(key: "1", label: "chinese".tr()),
                        AlertDialogAction(key: "2", label: "english".tr()),
                        AlertDialogAction(key: "3", label: "japanese".tr()),
                      ]).then((value) {
                    logger.i(value);
                    setState(() {
                      categoryChosenBool = true;
                      switch (value) {
                        case "1":
                          category = 1;
                          categoryChosen = "chinese".tr();
                          break;
                        case "2":
                          category = 2;
                          categoryChosen = "english".tr();
                          break;
                        case "3":
                          category = 3;
                          categoryChosen = "japanese".tr();
                          break;
                        default:
                          categoryChosenBool = false;
                          break;
                      }
                    });
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.065,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFD3D3D3)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          categoryChosenBool
                              ? categoryChosen
                              : "choose_category_notice".tr(),
                          style: categoryChosenBool
                              ? const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )
                              : const TextStyle(
                                  color: Color(0xFFBEBEBE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //date picker
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: meetingDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1));
                  if (date == null) return;
                  setState(() {
                    meetingDate = DateTime(date.year, date.month, date.day,
                        meetingDate.hour, meetingDate.minute);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFD3D3D3)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text("meeting_time".tr(),
                                  style: const TextStyle(
                                    color: Color(0xFFBEBEBE),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "${meetingDate.year}.${meetingDate.month}.${meetingDate.day}"
                                  //(${meetingDate.weekday})
                                  ,
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        ],
                      )),
                      const Icon(Icons.expand_more, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            //time picker
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: GestureDetector(
                onTap: () async {
                  meetingTime = (await showTimePicker(
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        context: context,
                        initialTime: meetingTime,
                      )) ??
                      meetingTime;
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFD3D3D3)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Icon(
                          Icons.access_time,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text("meeting_time".tr(),
                                  style: const TextStyle(
                                    color: Color(0xFFBEBEBE),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(meetingTime.toString().substring(10, 15),
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        ],
                      )),
                      const Icon(Icons.expand_more, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Text(
                "place".tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.065,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFFD3D3D3)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "write_place_hint".tr(),
                            hintStyle: const TextStyle(
                              color: Color(0xFFBEBEBE),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            setState(() {
                              location = text;
                            });
                          }),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
              child: Text(
                "meeting_capacity".tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Text(
                        "${"local_capacity".tr()} : $localCapacity ",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 128, 128, 128),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Slider(
                        value: localCapacity.toDouble(),
                        min: 1,
                        max: 20,
                        divisions: 19,
                        label: localCapacity.toString(),
                        onChanged: (double value) {
                          setState(() {
                            localCapacity = value.toInt();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Text(
                        "${"foreigner_capacity".tr()} : $travelCapacity ",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 128, 128, 128),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Slider(
                        value: travelCapacity.toDouble(),
                        min: 1,
                        max: 20,
                        divisions: 19,
                        label: travelCapacity.toString(),
                        onChanged: (double value) {
                          setState(() {
                            travelCapacity = value.toInt();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Container(
                      height: 56,
                      child: ElevatedButton(
                        child: Text(
                          "make_meeting".tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () async {
                          bool made = false;
                          if (title == "" || content == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "profile_edit_name_description_check"
                                        .tr())));
                          } else if (category == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("choose_category_notice".tr())));
                          } else if (location == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("place_unchose_warning".tr())));
                          } else if (imageList.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("picture_unchose_warning".tr())));
                          } else {
                            await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                        "${"writing_warning_first".tr()}\n${"writing_warning_second".tr()}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          loading(context);

                                          if (await postPosting(
                                              PostingBody(
                                                title: title,
                                                content: content,
                                                meeting_start_time: meetingDate
                                                    .toIso8601String(),
                                                category: category.toString(),
                                                meeting_location: location,
                                                capacity_local:
                                                    localCapacity.toString(),
                                                capacity_travel:
                                                    travelCapacity.toString(),
                                              ),
                                              imageList)) {
                                            logger.i("글쓰기 성공");
                                            context.pop();
                                            context.pop();
                                            made = true;
                                          } else {
                                            context.pop();
                                            context.pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text('fail'.tr())));
                                          }
                                        },
                                        child: const Text('confirm').tr(),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: const Text('cancel',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              )).tr())
                                    ],
                                  );
                                });
                          }
                          if(made){
                            context.pop();
                          }
                        },
                      )),
                )),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: (MediaQuery.of(context).viewInsets.bottom)),
                child: Container()),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
