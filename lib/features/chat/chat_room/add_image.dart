import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/permission.dart';
import 'package:malf/shared/usecases/image_compress.dart';

class AddImageState extends StatefulWidget {
  AddImageState({required this.postId, super.key});
  String postId;

  @override
  State<AddImageState> createState() => _AddImageStateState();
}

class _AddImageStateState extends State<AddImageState> {
  List<XFile> pickedImages = [];
  final Dio _dio = Dio();

  void _pickImageGallery() async {
    if (!(await photoPermission())) return;
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickMultiImage();
    setState(() {
      if (pickedImageFile.isNotEmpty) {
        pickedImages.addAll(pickedImageFile);
      }
    });
    // for (XFile? pickedImage in pickedImages) {
    //   pickedImage.insert(0, image)
    //   widget.addImageFunc(pickedImage);
    // }
  }

  void _pickImageCamera() async {
    if (!(await cameraPermission())) return;
    final imagePicker = ImagePicker();
    final pickedImageFile =
        await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImageFile != null) {
        pickedImages.add(pickedImageFile);
      }
    });
    // for (XFile? pickedImage in pickedImages) {
    //   widget.addImageFunc(pickedImage);
    // }
  }

  Future<bool> sendImages(List<XFile> imageList, String postId) async {
    // final imageFileList = <File>[];
    // var request;
    // StreamedResponse? response;
    // bool isUploaded = false;
    // MultiPartRequest로 request 정의
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://malftravel.com/chat/$postId/image"));

    // request에 사진 업로드
    for (int i = 0; i < imageList.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          'image',
          (await compressImage(File(imageList[i].path), 90, imageList.length))
              .path));
    }

    // request 헤더 설정
    request.headers['Authorization'] = Token().refreshToken;
    request.headers['Content-Type'] = 'multipart/form-data;';

    // request.send()를 통해 post
    var response = await request.send();

    if (response.statusCode == 200) {
      Logger().d('요청이 성공적으로 처리되었습니다.');
      return true;
    } else {
      Logger().e('요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: 150,
        height: 500,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 150,
              width: 150,
              child: pickedImages.isEmpty != true
                  ? ListView.builder(
                      itemCount: pickedImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                File(pickedImages[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                left:
                                    MediaQuery.of(context).size.height * 0.015,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.03,
                                    child: FloatingActionButton(
                                      heroTag: "delete_image",
                                      backgroundColor: const Color(0xFFD3D3D3),
                                      onPressed: () {
                                        setState(() {
                                          pickedImages.removeAt(index);
                                        });
                                      }, // 해당 이미지 삭제
                                      child: const Icon(Icons.close,
                                          size: 15, color: Colors.white),
                                    )))
                          ],
                        );
                      },
                    )
                  : Center(child: Text("pick_photo".tr())),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton.icon(
              onPressed: () {
                _pickImageCamera();
              },
              icon: const Icon(Icons.camera),
              label: Text('camera'.tr()),
            ),
            OutlinedButton.icon(
              onPressed: () {
                _pickImageGallery();
              },
              icon: const Icon(Icons.image),
              label: Text('gallery'.tr()),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () {
                      if (pickedImages.isNotEmpty) {
                        try {
                          sendImages(pickedImages, widget.postId);
                        } catch (e) {
                          Logger().e(e);
                        }
                        context.pop();
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: Text('send'.tr())),
                TextButton.icon(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close),
                    label: Text('close'.tr())),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
