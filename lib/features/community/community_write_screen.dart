import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:malf/features/community/community_model.dart';
import 'package:http/http.dart' as http;
import 'package:malf/features/community/community_page_controller.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/permission.dart';
import 'package:malf/shared/usecases/image_compress.dart';
import 'package:path_provider/path_provider.dart';

const subUrl = "/community/posts";

class PostingBody {
  String title;
  String content;
  PostingBody({
    required this.title,
    required this.content,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}

Future<bool> postPosting(PostingBody data, String kind, List<XFile> imageList,
    List<String> oldImageList, int postId) async {
  if (imageList.isEmpty && oldImageList.isEmpty) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': Token().refreshToken,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    late final Response<dynamic> result;
    if(kind == "write"){
      result = await dio.post(subUrl, data: data.toJson());
      
    }
    else{
      result = await dio.patch("$subUrl/$postId", data: data.toJson());
      
    }
    if(result.statusCode==201)
    {
      return true;
    }

    return false;
  } else {
    var imageFileList = <File>[];
    http.MultipartRequest request;
    StreamedResponse? response;
    bool isUploaded = false;

    for (int i = 0; i < imageList.length; i++) {
      imageFileList.add(await compressImage(
          File(imageList[i].path), 90, imageList.length + oldImageList.length));
    }
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    for (int i = 0; i < oldImageList.length; i++) {
      imageFileList.add(await compressImage(
          await File("$tempPath$i.jpg").writeAsBytes(
              (await http.get(Uri.parse(oldImageList[i]))).bodyBytes),
          93,
          imageList.length + oldImageList.length));
    }

    try {
      while (!isUploaded) {
        request = http.MultipartRequest(
            'patch', Uri.parse(baseUrl + subUrl + postId.toString()));
        try {
          for (int i = 0; i < imageFileList.length; i++) {
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
        };

        String token = Token().refreshToken;

        request.headers['Authorization'] = token;
        request.headers['Content-Type'] = 'multipart/form-data;';

        request.fields.addAll(mapdata);
        StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          logger.d('요청이 성공적으로 처리되었습니다.');
          return true;
        } else {
          logger.e('요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
          logger.e(response.reasonPhrase);
          logger.e(response.request);
        }
      }
    } on Exception catch (e) {
      // TODO
      logger.e(e);
      return false;
    }
  }

  // request에 사진 업로드

  //final response = await dio.post(baseUri + subUri, data: formData);
}

class CommunityWriteScreen extends StatefulWidget {
  const CommunityWriteScreen({super.key, required this.kind, this.extraData});

  final String kind;
  final Object? extraData;

  @override
  State<CommunityWriteScreen> createState() => _CommunityWriteScreenState();
}

class _CommunityWriteScreenState extends State<CommunityWriteScreen> {
  final picker = ImagePicker();
  List<XFile> imageList = [];
  List<String> oldImageListString = [];
  String title = "";
  String content = "";

  late TextEditingController titleController;
  late TextEditingController contentController;

  CommunityData? communityData;

  @override
  void initState() {
    if (widget.kind == "edit") {
      communityData = widget.extraData as CommunityData;

      title = communityData!.title;
      content = communityData!.content;
      oldImageListString.addAll(communityData!.picture);
    }
    titleController = TextEditingController(text: title);
    contentController = TextEditingController(text: content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        title: Text((widget.kind == "write")
            ? 'community_write'.tr()
            : "community_edit".tr()),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(initialScrollOffset: 210),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "picture".tr(),
                  style: const TextStyle(
                    color: Color(0xFF292524),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * 0.1,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (imageList.length < 10) {
                            try {
                              if (!(await photoPermission())) return;
                              final image = await picker
                                  .pickMultiImage(); // 갤러리에서 이미지 뽑아옴
                              if (imageList.length +
                                      image.length +
                                      oldImageListString.length >
                                  10) {
                                imageList.removeRange(10, imageList.length);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("photo_upload_warning".tr())));
                              } else {
                                setState(() {
                                  imageList.addAll(image);
                                });
                              }
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
                    child: SizedBox(
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
                                        if (index < imageList.length)
                                          Image.file(
                                            File(imageList[index].path),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            fit: BoxFit.cover,
                                          )
                                        else if (widget.kind == "edit")
                                          ExtendedImage.network(
                                            oldImageListString[
                                                index - imageList.length],
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                                                  heroTag:
                                                      "delete_edit_image$index",
                                                  backgroundColor:
                                                      const Color(0xFFD3D3D3),
                                                  onPressed: () {
                                                    if (index <
                                                        imageList.length) {
                                                      setState(() {
                                                        imageList
                                                            .removeAt(index);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        oldImageListString
                                                            .removeAt(index -
                                                                imageList
                                                                    .length);
                                                      });
                                                    }
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
                          itemCount:
                              imageList.length + oldImageListString.length),
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
                    color: Color(0xFF292524),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFD3D3D3)),
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
                            controller: titleController,
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
                              titleController.text = text;
                              title = text;
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
                    color: Color(0xFF292524),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFD3D3D3)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: contentController,
                          scrollController: ScrollController(
                            initialScrollOffset: 0,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "write_content_hint".tr(),
                            hintStyle: const TextStyle(
                              color: Color(0xFFBEBEBE),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            contentController.text = text;
                            content = text;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 60,
                        child: ElevatedButton(
                          child: Text(
                            (widget.kind == "write")
                                ? "write".tr()
                                : "edit".tr(),
                          ),
                          onPressed: () async {
                            if (title == "" || content == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "profile_edit_name_description_check"
                                              .tr())));
                            } else {
                              if (await postPosting(
                                  PostingBody(
                                    title: title,
                                    content: content,
                                  ),
                                  widget.kind,
                                  imageList,
                                  oldImageListString,
                                  communityData?.postId??-1)) {
                                communityPageController.refresh();
                                logger.i("글쓰기 성공");
                                context.pop();
                                // try{
                                //   GoRouter.of(context).go(
                                //   '/home',
                                //   );}
                                // catch(e){
                                //   logger.e(e);}
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('fail'.tr())));
                              }
                            }
                          },
                        )),
                  )),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: (MediaQuery.of(context).viewInsets.bottom))),
            ]),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
