import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as Fl;
import 'package:country_code/country_code.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:malf/features/profile/profile_model.dart';

import 'package:malf/shared/logger.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/permission.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:malf/shared/usecases/image_compress.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const String baseUri = 'https://malftravel.com/';
const String subUri = 'user/profile/';

class PostingBody {
  String userType;
  String nation;
  String gender;
  String nickname;
  String birthday;
  String defaultLanguage;
  String description;
  String ableLanguage;
  String interests;
  PostingBody({
    required this.userType,
    required this.nation,
    required this.gender,
    required this.nickname,
    required this.birthday,
    required this.defaultLanguage,
    required this.description,
    required this.ableLanguage,
    required this.interests,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['user_type'] = userType;
    data['nation'] = nation;
    data['gender'] = gender;
    data['nickname'] = nickname;
    data['birthday'] = birthday;
    data['default_language'] = defaultLanguage;
    data['description'] = description;
    data['able_language'] = ableLanguage;
    data['interests'] = interests;
    return data;
  }
}

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.profileData});

  final Object? profileData;

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  ProfileData? profileData;
  final picker = ImagePicker();
  final countryPicker = const Fl.FlCountryCodePicker();
  List<XFile> imageList = [];
  String? _name = '';
  String description = '';
  String nation = '';
  String gender = '';
  List<int> ableLanguage = [];
  String interest = '';
  //1은 현지인, 0은 외국인, 100은 관리자
  String userType = '';
  String oldImage = '';
  bool isChanged = false;
  bool typeChosenBool = false;

  bool englishAble = false;
  bool japaneseAble = false;
  bool chineseAble = false;

  late TextEditingController nicknameController;
  late TextEditingController contentController;
  late TextEditingController interestController;

  Future<bool> _submitForm(PostingBody postingBody) async {
    var imageFileList = <File>[];

    bool isUploaded = false;

    if (isChanged) {
      for (int i = 0; i < imageList.length; i++) {
        imageFileList.add(await compressImage(File(imageList[i].path), 90,2));
      }
    } else {
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      imageFileList.add(await File("${tempPath}1.jpg").writeAsBytes((await http
              .get(Uri.parse(oldImage),))
          .bodyBytes));
    }

    try {
      while (!isUploaded) {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(baseUri + subUri));

        for (int i = 0; i < imageFileList.length; i++) {
            request.files.add(await http.MultipartFile.fromPath(
                'image', imageFileList[i].path));
          }

        request.headers['Authorization'] = Token().refreshToken;
        request.headers['Content-Type'] = 'multipart/form-data;';

        request.fields.addAll(postingBody.toJson());
        http.StreamedResponse? response = await request.send();

        if (response.statusCode == 200) {
          logger.d('요청이 성공적으로 처리되었습니다.');
          isUploaded = true;
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
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileData = widget.profileData as ProfileData?;
    if (profileData != null) {
      _name = profileData!.nickname;
      description = profileData!.description;
      gender = profileData!.gender.toString();
      nation = profileData!.nation.toString();
      ableLanguage.addAll(profileData?.ableLanguage ?? []);
      interest = profileData!.interests ?? "";
      userType = profileData!.userType.toString();
      oldImage = profileData!.profilePic[0];
      for (var element in ableLanguage) {
        if (element == 2) englishAble = true;
        if (element == 3) japaneseAble = true;
        if (element == 1) chineseAble = true;
      }
    }
    nicknameController = TextEditingController(text: _name);
    contentController = TextEditingController(text: description);
    interestController = TextEditingController(text: interest);
    logger.d(widget.profileData);
  }

  // void testLoading() {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       Future.delayed(Duration(seconds: 3), () {
  //         context.pop();
  //       });
  //       return AlertDialog(
  //           backgroundColor: Colors.transparent,
  //           shadowColor: Colors.transparent,
  //           content:
  //               LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 75));
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'edit_profile'.tr(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                // logger.d(Uri.parse(oldImage));
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
          initialScrollOffset: 210,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 230,
                  width: maxWidth,
                ),
                Container(
                  height: 200,
                  width: maxWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: -10,
                    left: 20,
                    child: GestureDetector(
                      onTap: () async {
                        if (!(await photoPermission())) return;
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        imageList.clear();
                        if (mounted) {
                          setState(() {
                            imageList.add(image);
                            isChanged = true;
                          });
                        }
                      },
                      child: Stack(
                        children: [
                          if (isChanged)
                            Stack(
                              children: [
                                SizedBox(
                                  height: 85,
                                  width: 85,
                                  child: ExtendedImage.file(
                                    File(imageList[0].path),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          imageList.clear();
                                          isChanged = false;
                                        });
                                      },
                                      child: Icon(Icons.close,
                                          size: 15, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )
                          else if (profileData == null)
                            Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary),
                              child: ExtendedImage.asset(
                                'assets/logos/login_logo.png',
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                                fit: BoxFit.contain,
                              ),
                            )
                          else
                            SizedBox(
                              height: 85,
                              width: 85,
                              child: ExtendedImage.network(
                                oldImage,
                                cache: true,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1),
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),

            //닉네임
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
              child: Text(
                "profile_edit_nickname_title".tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontFamily: 'Pretendard',
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
                        controller: nicknameController,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "profile_edit_nickname_hint".tr(),
                          hintStyle: TextStyle(
                            color: Color(0xFFBEBEBE),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //설명
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Text(
                "profile_edit_description_title".tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
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
                        controller: contentController,
                        scrollController: ScrollController(
                          initialScrollOffset: 0,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: "profile_edit_description_hint".tr(),
                          hintStyle: TextStyle(
                            color: Color(0xFFBEBEBE),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //유형
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: Text(
                "profile_edit_type_title".tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
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
                      title: "profile_edit_type_title".tr(),
                      initialSelectedActionKey: userType,
                      actions: [
                        AlertDialogAction(key: "0", label: "foreigner".tr()),
                        AlertDialogAction(key: "1", label: "local".tr()),
                      ]).then((value) {
                    setState(() {
                      logger.d(userType);
                      userType = value ?? userType;
                      if (userType == "1") {
                        nation = "410";
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
                        child: Text(userType == "1"
                            ? "local".tr()
                            : (userType == "0"
                                ? "foreigner".tr()
                                : "admin".tr())),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //국적
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Text(
                "profile_edit_nation_title".tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: GestureDetector(
                onTap: () async {
                  final code = await countryPicker.showPicker(context: context);
                  if (code == null) return;
                  logger.d(code.code);
                  setState(() {
                    nation =
                        CountryCode.tryParse(code.code)?.numeric.toString() ??
                            "410";
                    if (nation != "410") userType = "0";
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
                        child: Text(CountryCode.tryParse(nation)?.symbol ?? ""),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //언어선택
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Text(
                "profile_edit_language_title".tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      // title: "profile_edit_language_title".tr(),
                      // message: "같이 하고 싶은 언어를 선택해주세요.",);
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text("profile_edit_language_title".tr()),
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: ListView(
                                  children: [
                                    CheckboxListTile(
                                      value: chineseAble,
                                      onChanged: (value) {
                                        setState(() {
                                          chineseAble = value!;
                                        });
                                      },
                                      activeColor: AppColors.primary,
                                      checkColor: Colors.white,
                                      title: Text("chinese".tr()),
                                    ),
                                    CheckboxListTile(
                                      value: englishAble,
                                      onChanged: (value) {
                                        setState(() {
                                          englishAble = value!;
                                        });
                                      },
                                      activeColor: AppColors.primary,
                                      checkColor: Colors.white,
                                      title: Text("english".tr()),
                                    ),
                                    CheckboxListTile(
                                      value: japaneseAble,
                                      onChanged: (value) {
                                        setState(() {
                                          japaneseAble = value!;
                                        });
                                      },
                                      activeColor: AppColors.primary,
                                      checkColor: Colors.white,
                                      title: Text("japanese".tr()),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text("confirm".tr()),
                                ),

                              ],
                            );
                          },
                        );
                      }).then((value) => setState(() {}));
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
                          englishAble || chineseAble || japaneseAble
                              ? (englishAble ? "${"english".tr()} " : "") +
                                  (chineseAble ? "${"chinese".tr()} " : "") +
                                  (japaneseAble ? "${"japanese".tr()} " : "")
                              : "profile_edit_language_title".tr(),
                          style: englishAble || chineseAble || japaneseAble
                              ? const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                )
                              : TextStyle(
                                  color: Color(0xFFBEBEBE),
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //관심사
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: Text(
                "profile_edit_interest_title".tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
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
                        controller: interestController,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "profile_edit_interest_hint".tr(),
                          hintStyle: TextStyle(
                            color: Color(0xFFBEBEBE),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //성별
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: Text(
                "profile_edit_gender_title".tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontFamily: 'Pretendard',
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
                      title: "profile_edit_gender_title".tr(),
                      actions: [
                        AlertDialogAction(key: "1", label: "male".tr()),
                        AlertDialogAction(key: "2", label: "female".tr()),
                      ]).then((value) {
                    setState(() {
                      gender = value ?? gender;
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
                        child:
                            Text(gender == "1" ? "male".tr() : "female".tr()),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //글쓰기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: ElevatedButton(
                        child: Text(
                          "edit_profile".tr(),
                        ),
                        onPressed: () async {
                          if (nicknameController.text == "" ||
                              contentController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "profile_edit_name_description_check"
                                        .tr())));
                          } else if (!englishAble &&
                              !chineseAble &&
                              !japaneseAble) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("profile_edit_language_title".tr())));
                          } else if (interestController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("profile_edit_interest_title".tr())));
                          } else {
                            ableLanguage.clear();
                            if (chineseAble) ableLanguage.add(1);
                            if (englishAble) ableLanguage.add(2);
                            if (japaneseAble) ableLanguage.add(3);
                            if (await _submitForm(PostingBody(
                              userType: userType,
                              nation: nation,
                              gender: gender,
                              nickname: nicknameController.text,
                              birthday: DateTime.now().toIso8601String(),
                              defaultLanguage: '1',
                              description: contentController.text,
                              ableLanguage: ableLanguage.toString(),
                              interests: interestController.text,
                            ))) {
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
                                  const SnackBar(
                                      content: Text('글쓰기에 실패했습니다.')));
                            }
                          }
                        },
                      )),
                )),
              ],
            ),

            //

            //
            Padding(
                padding: EdgeInsets.only(
                    bottom: (MediaQuery.of(context).viewInsets.bottom)))
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
