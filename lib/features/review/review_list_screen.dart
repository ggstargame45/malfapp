import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/permission.dart';
import 'package:http/http.dart' as http;
import 'package:malf/shared/usecases/image_compress.dart';

class PostingBody {}

Future<bool> postPosting(PostingBody data, List<XFile> imageList) async {
  var imageFileList = <File>[];
  http.MultipartRequest request;
  http.StreamedResponse? response;
  int isUploaded = 0;
  bool uploaded = false;

  for (int i = 0; i < imageList.length; i++) {
    imageFileList.add(await compressImage(File(imageList[i].path), 90,imageList.length));
  }

  try {
    while (isUploaded < 1) {
      request =
          http.MultipartRequest('POST', Uri.parse("$baseUrl/user/student-id"));
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
      // Map<String, String> mapdata = {
      //     // 'title': "data.title",
      //     'content': "data.content",
      //     // 'meeting_start_time': data.meeting_start_time,
      //     // 'category': data.category,
      //     // 'meeting_location': data.meeting_location,
      //     // 'capacity_local': data.capacity_local,
      //     // 'capacity_travel': data.capacity_travel,
      // };

      

      request.headers['Authorization'] = Token().refreshToken;
      request.headers['Content-Type'] = 'multipart/form-data;';

      // request.files;
      // request.fields.addAll(mapdata);
    
      await request.send().then((value) {
        response = value;
        if (response != null) {
          response!.stream.transform(utf8.decoder).listen((value) {
            logger.d("asda: $value");
          });
          logger.d(response!.reasonPhrase);
          if (response!.statusCode == 200) {
            logger.d('요청이 성공적으로 처리되었습니다.');
            uploaded =true;
            return true;
          } else {
            logger.e('요청이 실패하였습니다. 상태 코드: ${response!.statusCode}');
          }
        }
      });

      isUploaded++;
    }
  } on Exception catch (e) {
    // TODO
    logger.e(e);
    return false;
  }
  return uploaded;
}

class ReviewListScreen extends StatefulWidget {
  const ReviewListScreen({super.key, required this.postId});

  final String postId;

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    logger.d("ReviewListScreen");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.d("ReviewListScreessn");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "school_auth_title".tr(),
                style: const TextStyle(
                  color: Color(0xFF292524),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                "picture".tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            

            //TODO:서버에서도 텍스트 받기가 가능해야함
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
            //   child: Text(
            //     "title".tr(),
            //     textAlign: TextAlign.start,
            //     style: const TextStyle(
            //       color: Color.fromARGB(255, 128, 128, 128),
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.9,
            //     height: MediaQuery.of(context).size.height * 0.065,
            //     padding: const EdgeInsets.only(left: 16, right: 16),
            //     decoration: ShapeDecoration(
            //       color: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         side:
            //             const BorderSide(width: 0.50, color: Color(0xFFD3D3D3)),
            //         borderRadius: BorderRadius.circular(16),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Expanded(
            //           child: TextField(
            //               style: const TextStyle(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //               decoration: InputDecoration(
            //                 hintText: "ex) 연세대 학생증",
            //                 hintStyle: const TextStyle(
            //                   color: Color(0xFFBEBEBE),
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //                 border: InputBorder.none,
            //               ),
            //               onChanged: (text) {}),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        bottomSheet: Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                      child: Text("submit".tr()),
                      onPressed: () async {
                        context.push("/reviewDetail/asdf");
                      },
                    )),
              )),
            ],
          ),
        ));
  }
}
