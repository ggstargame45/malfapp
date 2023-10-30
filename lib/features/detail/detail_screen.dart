import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:malf/features/detail/detail_model.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:like_button/like_button.dart';

import 'package:malf/shared/network/base_url.dart';
import 'package:extended_image/extended_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as FCCP;

class DetailScreen extends StatefulWidget {
  final int postId;
  const DetailScreen({Key? key, required this.postId}) : super(key: key);
  static const String routeName = '/detail';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailData? detailData;
  int currentLocal = 0;
  int currentForeign = 0;
  bool subscribeCheck = false;
  bool insideCheck = false;

  Future<dynamic> insideRequest() async {
    try {
      final response = await Dio(BaseOptions(
              baseUrl: baseUrl,
              headers: {'Authorization': Token().refreshToken},
              responseType: ResponseType.json))
          .get("/chatroom/${widget.postId}/members");
      return response.data["data"];
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  Future<dynamic> subscribeRequest() async {
    try {
      final response = await Dio(BaseOptions(
              baseUrl: baseUrl,
              headers: {'Authorization': Token().refreshToken},
              responseType: ResponseType.json))
          .get("/chatroom/${widget.postId}/agreement");
      return response.data["data"];
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  Future<void> checkSubscribe() async {
    subscribeCheck = false;

    final List<dynamic> jsonData = await subscribeRequest();
    for (var element in jsonData) {
      if (element["user_uniq_id"] == Token().userUniqId) {
        subscribeCheck = true;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> checkInside() async {
    insideCheck = false;
    final List<dynamic> jsonData = await insideRequest();
    for (var element in jsonData) {
      if (element["user_uniq_id"] == Token().userUniqId) {
        insideCheck = true;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  void initVar() async {
    Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {'Authorization': Token().refreshToken},
        responseType: ResponseType.json));
    final response = await dio.get("/bulletin-board/posts/${widget.postId}");
    detailData = DetailData.fromJson(response.data['data'][0]);

    logger.d(detailData);
    currentLocal = 0;
    currentForeign = 0;
    final List<dynamic> jsonData = await insideRequest();
    for (var element in jsonData) {
      if (element["user_uniq_id"] == Token().userUniqId) {
        insideCheck = true;
      }
      if (element["user_type"] == 0) {
        currentForeign++;
      } else {
        currentLocal++;
      }
    }
    await checkInside();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          actions: [
            // CCP.CountryCodePicker(
            //   onChanged: (countryCode){
            //     logger.d(CCP.CountryCode.fromDialCode(countryCode.dialCode!).name);
            //   },
            //   showCountryOnly: true,

            // ),

            IconButton(
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  color: AppColors.black,
                ),
                onPressed: () async {
                  // logger.d(CountryCode.values);
                  // FCCP.CountryCode.fromMap();
                  // logger.d(CountryCode.parse("KR").alpha3);
                  // logger.d(CountryCode.parse((await FCCP.FlCountryCodePicker().showPicker(context: context,scrollToDeviceLocale: true))!.code).symbol);

                  detailMoreSheet(context, detailData);
                }),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: ExtendedPageController(),
          child: Column(children: [
            if (detailData != null)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                child: Swiper(
                  viewportFraction: 0.8,
                  scale: 0.9,
                  pagination: SwiperPagination(),
                  control: SwiperControl(),
                  scrollDirection: Axis.horizontal,
                  itemCount: detailData!.meetingPic
                      .length, // Assume banners is a list of your banner data.
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    alignment: Alignment.center,
                                    child: ExtendedImage.network(
                                        "$baseUrl/${detailData!.meetingPic[index]}",
                                        cache: true,
                                        fit: BoxFit.contain),
                                  ),
                                );
                              });
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 2,
                          child: ExtendedImage.network(
                            baseUrl + "/" + detailData!.meetingPic[index],
                            fit: BoxFit.cover,
                            cache: true,
                          ),
                        ),
                      ),
                    );
                  },
                  onTap: (index) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailScreen(
                    //       postId: detailData!.postId,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            if (detailData != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(detailData!.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            if (detailData != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                          SelectableText(
                              "${"place".tr()} : ${detailData!.meetingLocation}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if (detailData != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          ),
                          Text("date".tr() + " : ",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              )),
                          Text(
                              "${detailData!.meetingStartTime.year}.${detailData!.meetingStartTime.month}.${detailData!.meetingStartTime.day} | " +
                                  (detailData!.meetingStartTime.hour < 10
                                      ? "0" +
                                          detailData!.meetingStartTime.hour
                                              .toString()
                                      : detailData!.meetingStartTime.hour
                                          .toString()) +
                                  " : ${detailData!.meetingStartTime.minute < 10 ? "0${detailData!.meetingStartTime.minute}" : detailData!.meetingStartTime.minute}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if (detailData != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                            '/attendList/${detailData!.postId}/${detailData!.userUniqId == Token().userUniqId ? 1 : 0}');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Row(
                          children: [
                            Icon(
                              Icons.people_alt_outlined,
                              color: Colors.grey,
                            ),
                            Text("people_count".tr() + " : ",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                )),
                            Text("foreigner".tr() + " ",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 113, 162, 254),
                                )),
                            Text(currentForeign.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                )),
                            Text(
                                "/" +
                                    detailData!.capacityTravel.toString() +
                                    " | ",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                )),
                            Text("local".tr() + " ",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 97, 195, 255),
                                )),
                            Text(currentLocal.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                )),
                            Text("/" + detailData!.capacityTravel.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                )),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Divider(
              height: 1,
              thickness: 0.5,
              indent: 16,
              endIndent: 16,
              color: Colors.grey,
            ),
            if (detailData != null)
              GestureDetector(
                onTap: () {
                  context.push('/profileOther/${detailData!.userUniqId}');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: ExtendedImage.network(
                          baseUrl + "/" + detailData!.authorPic[0],
                          fit: BoxFit.cover,
                          cache: true,
                        ).image,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: RoundedBackgroundText(
                            "${detailData!.userType == 0 ? "foreigner" : "local"}"
                                .tr(),
                            style: TextStyle(
                                fontSize: 12,
                                color: detailData!.userType == 0
                                    ? AppColors.primary
                                    : AppColors.white),
                            backgroundColor: detailData!.userType == 0
                                ? AppColors.extraLightGrey
                                : AppColors.primary,
                            innerRadius: 20.0,
                            outerRadius: 20.0,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                              detailData!.authorNickname +
                                  " ${CountryCode.tryParse("${detailData!.authorNation}")?.symbol ?? "?"}",
                              style: const TextStyle(
                                fontSize: 18,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (detailData != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: SelectableText(detailData!.content,
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
              ),
            Container(
              height: 60,
            )
          ]),
        ),
        bottomSheet: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LikeButton(
                  likeCount: detailData == null ? 0 : detailData!.likeCount,
                  isLiked:
                      detailData == null ? false : detailData!.likeCheck == 1,
                  onTap: null,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: detailData == null
                        ? null
                        : ((detailData!.userUniqId == Token().userUniqId ||
                                insideCheck)
                            ? ElevatedButton(
                                onPressed: () async {
                                  context.push(
                                      '/attendList/${detailData!.postId}/${detailData!.userUniqId == Token().userUniqId ? 1 : 0}');
                                },
                                child: Text("attendance_list".tr()))
                            : (subscribeCheck
                                ? ElevatedButton(
                                    onPressed: () async {
                                      final dodo = Dio(BaseOptions(
                                          baseUrl: baseUrl,
                                          headers: {
                                            'Authorization':
                                                Token().refreshToken
                                          },
                                          responseType: ResponseType.json));
                                      try {
                                        await dodo.delete(
                                            "/chatroom/" +
                                                detailData!.postId.toString() +
                                                "/subscribe");
                                      } on Exception catch (e) {
                                        // TODO
                                      }
                                      await checkSubscribe();
                                    },
                                    child: Text("attend_cancel".tr()))
                                : ElevatedButton(
                                    onPressed: () async {
                                      final dodo = Dio(BaseOptions(
                                          baseUrl: baseUrl,
                                          headers: {
                                            'Authorization':
                                                Token().refreshToken
                                          },
                                          responseType: ResponseType.json));
                                      try {
                                        await dodo.post(
                                            "/chatroom/" +
                                                detailData!.postId.toString() +
                                                "/subscribe");
                                      } on Exception catch (e) {
                                        // TODO
                                      }
                                      await checkSubscribe();
                                    },
                                    child: Text("attend".tr())))),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}

void detailMoreSheet(context, DetailData? detailData) {
  if (detailData == null) {
    return;
  }
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
            padding: const EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            height: 260,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                if (detailData.userUniqId == Token().userUniqId)
                  GestureDetector(
                    onTap: () async {
                      context.pop();
                      try {
                        final _dio = Dio(BaseOptions(
                            baseUrl: baseUrl,
                            headers: {'Authorization': Token().refreshToken},
                            responseType: ResponseType.json));
                        final response = await _dio.delete(
                          "/bulletin-board/posts/${detailData.postId}}",
                        );
                        context.pop();
                        logger.d(response.data);
                        //return response.statusCode;
                      } catch (error) {
                        logger.d('오류: $error');
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                            Text(
                              "post_delete".tr(),
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                  ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                if (detailData.userUniqId == Token().userUniqId)
                  GestureDetector(
                    onTap: () async {
                      await context.push('/edit', extra: detailData);
                      context
                        ..go('/home')
                        ..push('/detail/${detailData.postId}');
                    },
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        child: Row(
                          children: [
                            Icon(
                              Icons.mode_edit_outlined,
                              color: Color.fromARGB(138, 158, 158, 158),
                              size: 30,
                            ),
                            Text(
                              "edit".tr(), //게시물 수정하기
                              style: TextStyle(
                                  color: Color.fromARGB(138, 158, 158, 158),
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                  ),
                if (detailData.userUniqId != Token().userUniqId)
                  GestureDetector(
                    onTap: () async {
                      await context.push("/report", extra: {
                        "reportType": "post",
                        "id": detailData.postId.toString(),
                        "title": detailData.title
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        child: Row(
                          children: [
                            Icon(
                              Icons.mode_edit_outlined,
                              color: Color.fromARGB(138, 158, 158, 158),
                              size: 30,
                            ),
                            Text(
                              "report".tr(), //개시물 신고하기
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                  ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // SizedBox 대신 Container를 사용 가능
                  width: 300,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'.tr()),
                  ),
                )
              ],
            ),
          ));
}
