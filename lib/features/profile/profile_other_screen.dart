import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/home/home_page_controller.dart';
import 'package:malf/features/profile/profile_model.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/usecases/block_handle.dart';
import 'package:malf/shared/usecases/nation_image.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

class ProfileOtherScreen extends StatefulWidget {
  const ProfileOtherScreen({super.key, required this.userUniqId});

  final String userUniqId;

  @override
  State<ProfileOtherScreen> createState() => _ProfileOtherScreenState();
}

class _ProfileOtherScreenState extends State<ProfileOtherScreen> {
  ProfileData? profileData;
  String ableLanguage = "";

  @override
  void initState() {
    //_tabController = TabController(length: 2, vsync: this);
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  Future<void> getProfile() async {
    profileData = null;

    Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl, headers: {"Authorization": Token().refreshToken}));

    final response = await dio.get("/user/profile/${widget.userUniqId}");
    var copyData = response.data['data'][0];

    if (response.data['data'][0]['description'] == null) {
      copyData['description'] = "";
    }
    if (response.data['data'][0]['interests'] == null) {
      copyData['interests'] = "";
    }
    if (response.data['data'][0]['able_language'] == null) {
      copyData['able_language'] = "[]";
    }
    if (response.data['data'][0]['user_temperature'] == null) {
      copyData['user_temperature'] = 365;
    }
    if (response.data['data'] != []) {
      profileData = ProfileData.fromJson(copyData);
    }
    ableLanguage = "";
    profileData?.ableLanguage.forEach((element) {
      if (element == 1) {
        ableLanguage += "${"chinese".tr()}, ";
      }
      if (element == 2) {
        ableLanguage += "${"english".tr()}, ";
      }
      if (element == 3) {
        ableLanguage += "${"japanese".tr()}, ";
      }
    });
    if (ableLanguage.endsWith(", "))
      ableLanguage = ableLanguage.substring(0, ableLanguage.length - 2);
    logger.d("${profileData}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    String userTemperature = "36.5";
    if (profileData != null) {
      userTemperature =
          "${profileData!.userTemperature.toString().substring(0, profileData!.userTemperature.toString().length - 1)}.${profileData!.userTemperature.toString()[profileData!.userTemperature.toString().length - 1]} ";
      if (profileData!.userTemperature < 10 &&
          profileData!.userTemperature > -10) {
        userTemperature = " 0$userTemperature";
      } else {
        userTemperature = " $userTemperature";
      }
    }

    logger.i('ProfilePage build');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
              'profile'.tr(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (profileData != null && profileData!.userUniqId!=Token().userUniqId)
              IconButton(
                onPressed: () async {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0, 0),
                    items: [
                        PopupMenuItem(
                          value: 1,
                          onTap: () {
                            context.push("/report", extra: {
                              "reportType": "user",
                              "id": widget.userUniqId,
                              "title": profileData?.nickname ?? ""
                            });
                          },
                          child: Text("report".tr()),
                        ),
                        if(!BlockSet().blockUserUniqIdSet.contains(profileData!.userUniqId))
                        PopupMenuItem(
                          value: 2,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("block".tr()),
                                    content: Text("block_additional".tr()),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            BlockSet().addBlockUser(
                                                uniqId: profileData!.userUniqId,
                                                nickname:
                                                    profileData!.nickname);
                                            pagingController.refresh();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "unblock_message"
                                                            .tr())));
                                            context.pop();
                                            context.pop();
                                            
                                          },
                                          child: Text("block".tr())),
                                      TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: Text("cancel".tr()))
                                    ],
                                  );
                                });
                          },
                          child: Text("block".tr()),
                        ),
                    ],
                  );
                },
                icon: const Icon(Icons.menu, color: Colors.white),
              ),
            ]),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedAssetImageProvider(NationImage.getImage(
                            profileData?.nation.toString() ?? "non")),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 160,
                      left: 25,
                      child: profileData == null
                          ? Container(
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
                          : GestureDetector(
                              onTap: () {
                                showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          width: maxWidth * 0.8,
                                          height: maxHeight * 0.6,
                                          alignment: Alignment.center,
                                          child: ExtendedImage.network(
                                              baseUrl +
                                                  "/" +
                                                  profileData!.profilePic[0],
                                              cache: true,
                                              fit: BoxFit.contain),
                                        ),
                                      );
                                    });
                              },
                              child: SizedBox(
                                height: 85,
                                width: 85,
                                child: ExtendedImage.network(
                                  baseUrl + "/" + profileData!.profilePic[0],
                                  cache: true,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))
                ],
              ),

              //닉네임, 현지인/유학생, 온도, 프로필편집텍스트버튼 row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8),
                    child: profileData == null
                        ? Text(
                            '닉네임',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: maxWidth * 0.5,
                                ),
                                child: Text(
                                  profileData!.nickname +
                                      CountryCode.parse(
                                              profileData!.nation.toString())
                                          .symbol,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8.0, 0),
                                child: RoundedBackgroundText(
                                  "${profileData!.userType == 0 ? "foreigner" : "local"}"
                                      .tr(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: profileData!.userType == 0
                                          ? AppColors.primary
                                          : AppColors.white),
                                  backgroundColor: profileData!.userType == 0
                                      ? AppColors.extraLightGrey
                                      : AppColors.primary,
                                  innerRadius: 20.0,
                                  outerRadius: 20.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 234, 234, 234),
                                        width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: const Color.fromARGB(
                                        255, 247, 247, 247),
                                  ),
                                  child: Text(
                                    userTemperature,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
              //관심사 텍스트
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: profileData == null
                          ? Text(
                              'interests'.tr(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(
                              constraints: BoxConstraints(
                                maxWidth: maxWidth * 0.74,
                              ),
                              child: Text(
                                profileData!.interests ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                ],
              ),

              //사용가능 언어 텍스트
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Icon(
                      Icons.language,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: profileData == null
                          ? Text(
                              'able_language'.tr(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 125, 125, 125),
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Container(
                              constraints: BoxConstraints(
                                maxWidth: maxWidth * 0.74,
                              ),
                              child: Text(
                                ableLanguage,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                ],
              ),

              //프로필 설명 텍스트
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                          maxWidth: maxWidth * 0.8,
                        ),
                        child: Text(
                          profileData?.description ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                ),
              ),

              //TODO:본인이 참가신청한 모임 리스트뷰와 본인이 좋아요 누른 모임 리스트뷰를 tabbar로 구현
              //         Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: <Widget>[
              //     TabBar(
              //       controller: _tabController,
              //       indicatorColor: Colors.teal,
              //       labelColor: Colors.teal,
              //       unselectedLabelColor: Colors.black54,
              //       tabs: <Widget>[
              //         Tab(
              //           text: "One",
              //         ),
              //         Tab(
              //           text: "Two",
              //         ),
              //       ],
              //     ),
              //     Container(
              //       height: maxHeight * 0.3,
              //       margin: EdgeInsets.only(left: 16.0, right: 16.0),
              //       child: TabBarView(
              //         controller: _tabController,
              //         children: <Widget>[
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8.0),
              //               color: Colors.blueAccent,
              //             ),
              //           ),
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8.0),
              //               color: Colors.orangeAccent,
              //             ),
              //           ),
              //         ],
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ));
  }
}
