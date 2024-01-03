import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:extended_image/extended_image.dart';
import 'package:malf/features/profile/profile_model.dart';

import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/usecases/nation_image.dart';
import 'package:malf/shared/widgets/image_view_widget.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  //late final TabController _tabController;
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
    logger.d("what : ${Token().userUniqId}");
    final response = await dio.get("/user/profile/${Token().userUniqId}");
    logger.d("response : ${response.data['data']}");
    if (response.data['data'].isEmpty) {
      logger.d("badhit");
      response.data['data'].add({
        "user_uniq_id": Token().userUniqId,
        "nickname": "nickname",
        "user_status": -1,
        "user_type": 0,
        "nation": 410,
        "gender": 0,
        "birthday": "2021-09-01",
        "profile_pic":
            "[\"https://malf-live.s3.ap-northeast-2.amazonaws.com/default.png\"]",
        "description": "description",
        "interests": "interests",
        "able_language": "[1, 2, 3]",
        "user_temperature": 365,
        "created_at": "2021-09-01",
        "updated_at": "2021-09-01"
      });
    }
    var copyData = response.data['data'][0] ?? {};

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
    if (response.data['data'][0]['profile_pic'] == null) {
      copyData['profile_pic'] =
          "[\"https://malf-live.s3.ap-northeast-2.amazonaws.com/default.png\"]";
    }
    //copyData['profile_pic'] = "[\"https://malf-live.s3.ap-northeast-2.amazonaws.com/banner/defaultbanner.png\"]";

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
    if (ableLanguage.endsWith(", ")) {
      ableLanguage = ableLanguage.substring(0, ableLanguage.length - 2);
    }
    logger.d(profileData!.profilePic[0]);
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
              'my_page'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () async {
                  await context.push('/settings');
                },
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
            ]),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 250,
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
                              decoration: const BoxDecoration(
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
                                if (profileData != null) {
                                  imageNetworkListViewer(
                                      imageUrls: profileData!.profilePic,
                                      context: context);
                                }
                              },
                              child: SizedBox(
                                height: 95,
                                width: 95,
                                child: ExtendedImage.network(
                                  profileData!.profilePic[0],
                                  cache: true,
                                  cacheRawData: true,
                                  loadStateChanged: (state) {
                                    if (state.extendedImageLoadState ==
                                        LoadState.loading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    // if(state.extendedImageLoadState == LoadState.failed){
                                    //   return Image.network(
                                    //     profileData!.profilePic[0],
                                    //     fit: BoxFit.cover);
                                    // }
                                  },
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                  Positioned(
                    right: 12,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          logger.d(profileData!.profilePic);
                          await context.push('/profileEdit',
                              extra: profileData);

                          getProfile();
                        },
                        child: Text(
                          'edit_profile'.tr(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              //닉네임, 현지인/유학생, 온도, 프로필편집텍스트버튼 row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8),
                    child: profileData == null
                        ? const Text(
                            '닉네임',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : SizedBox(
                            width: maxWidth * 0.85,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    profileData!.nickname,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  CountryCode.parse(
                                          profileData!.nation.toString())
                                      .symbol,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8.0, 0),
                                  child: RoundedBackgroundText(
                                    (profileData!.userType == 0 ? "foreigner" : "local")
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: profileData!.userTemperature < 100
                                      ? SvgPicture.asset("assets/icons/ic_angry.svg",
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 26, 26, 26),
                                              BlendMode.srcIn))
                                      : profileData!.userTemperature < 200
                                          ? SvgPicture.asset("assets/icons/ic_sad.svg",
                                              colorFilter: const ColorFilter.mode(
                                                  Color.fromARGB(
                                                      255, 128, 128, 128),
                                                  BlendMode.srcIn))
                                          : profileData!.userTemperature < 300
                                              ? const Icon(
                                                  Icons
                                                      .sentiment_neutral_outlined,
                                                  color: Color.fromARGB(
                                                      255, 97, 195, 255),
                                                )
                                              : profileData!.userTemperature <
                                                      400
                                                  ? const Icon(Icons.mood,
                                                      color: Color.fromARGB(
                                                          255, 99, 102, 241))
                                                  : profileData!.userTemperature <
                                                          500
                                                      ? SvgPicture.asset(
                                                          "assets/icons/ic_rofl.svg",
                                                          colorFilter:
                                                              const ColorFilter.mode(
                                                                  Color
                                                                      .fromARGB(
                                                                      255,
                                                                      247,
                                                                      119,
                                                                      33),
                                                                  BlendMode
                                                                      .srcIn),
                                                        )
                                                      : SvgPicture.asset(
                                                          "assets/icons/ic_family_star.svg",
                                                          height: 20,
                                                          colorFilter: const ColorFilter.mode(
                                                              Color.fromARGB(255, 255, 96, 96),
                                                              BlendMode.srcIn)),

                                  //
                                  //
                                )
                              ],
                            ),
                          ),
                  ),
                ],
              ),
              //관심사 텍스트
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        CupertinoIcons.heart_solid,
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: profileData == null
                            ? Text(
                                'interests'.tr(),
                                style: const TextStyle(
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
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                  ],
                ),
              ),

              //사용가능 언어 텍스트
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.language,
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: profileData == null
                            ? Text(
                                'able_language'.tr(),
                                style: const TextStyle(
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
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                  ],
                ),
              ),

              //프로필 설명 텍스트const EdgeInsets.fromLTRB(16, 16, 8, 0),color: const Color.fromARGB(255, 240, 243, 248),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        profileData?.description ?? "",
                        maxLines: 50,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Text(
                  "my_postings".tr(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 128, 128, 128),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Text(
                  "my_meeting".tr(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 128, 128, 128),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                leading:
                    const Icon(CupertinoIcons.heart_circle_fill, color: Colors.red),
                title: Text(
                  context.locale.languageCode != "en"
                      ? "like_meeting".tr()
                      : "Liked Meet-ups",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  context.push('/meetingList/like/0');
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.check_mark_circled_solid,
                    color: AppColors.primary),
                title: Text(
                  context.locale.languageCode != "en"
                      ? "attend_meeting".tr()
                      : "Meet-ups I Applied",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  context.push('/meetingList/apply/0');
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_square, color: Colors.blue),
                title: Text(
                  context.locale.languageCode != "en"
                      ? "made_meeting".tr()
                      : "Meet-ups I made",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  context.push('/meetingList/write/0');
                },
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
