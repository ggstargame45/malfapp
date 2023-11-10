import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:extended_image/extended_image.dart';
import 'package:malf/features/profile/profile_model.dart';

import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/usecases/nation_image.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

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
        "profile_pic": "[\"default.jpeg\"]",
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

    logger.i('ProfilePage build');
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
              'my_page'.tr(),
              style: TextStyle(color: Colors.white),
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
                              )
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 20),
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
                        await context.push('/profileEdit', extra: profileData);

                        getProfile();
                      },
                      child: Text(
                        'edit_profile'.tr(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
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
              ),

              //사용가능 언어 텍스트
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
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
              ),

              //프로필 설명 텍스트const EdgeInsets.fromLTRB(16, 16, 8, 0),color: const Color.fromARGB(255, 240, 243, 248),
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
                          maxLines: 30,
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
