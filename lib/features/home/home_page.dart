import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/config/routes/app_route.dart';
import 'package:malf/features/home/home_list_provider.dart';
import 'package:malf/shared/check.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/svg_strings.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/theme/test_styles.dart';
import 'package:malf/shared/usecases/block_handle.dart';
import 'package:malf/shared/widgets/image_view_widget.dart';
import 'package:provider/provider.dart';
import './home_list_model.dart';

import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/token.dart';

import 'package:extended_image/extended_image.dart';
import 'package:country_code/country_code.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:malf/features/home/home_page_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const List<String> dateRangePickString = [
  "모임 보기",
  "View meet-ups",
  "查看聚会",
  "会議を見る",
];


class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late String token;
  final _pageSize = 10;
  int lang = 0;

  // List<String> adList = [];

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      logger.d("pageKey : $pageKey");
      _fetchPage(pageKey);
      // _getAd();
    });
    startChecker();
    super.initState();
  }

  void startChecker() {}

  // Future<void> _getAd() async {
  //   Dio dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {
  //     'Authorization': token,
  //   }));
  //   Response response = await dio.get("/ad/list");

  //   logger.d(response.data['main_ad'].length);

  //   if (response.data['main_ad'].length > 0) {
  //     for (int i = 0; i < response.data['main_ad'].length; i++) {
  //       adList.add(response.data['main_ad'][i]['pic_url']);
  //     }
  //   }
  // }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await HomeListProvider.getHomeList(pageKey, _pageSize);
      pagingController.appendLastPage(newItems
          .where((element) =>
              (element.postStatus == 1) &&
              (DateTime.now().isBefore(element.meetingStartTime)) &&
              (!BlockSet().blockUserUniqIdSet.contains(element.userUniqId)) &&
              (!BlockSet().blockMeetingPostIdSet.contains(element.postId)))
          .toList());
      return;

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems
            .where((element) =>
                (DateTime.now().isBefore(element.meetingStartTime)) &&
                (!BlockSet().blockUserUniqIdSet.contains(element.userUniqId)) &&
                (!BlockSet().blockMeetingPostIdSet.contains(element.postId)))
            .toList());
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(
            newItems
                .where((element) =>
                    (DateTime.now().isBefore(element.meetingStartTime)) &&
                    (!BlockSet()
                        .blockUserUniqIdSet
                        .contains(element.userUniqId)) &&
                    (!BlockSet()
                        .blockMeetingPostIdSet
                        .contains(element.postId)))
                .toList(),
            nextPageKey);
      }
    } catch (error) {
      // _pagingController.error = error;
      logger.e(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // token = Token().refreshToken;
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    logger.d(Token().refreshToken);
    logger.d(Token().userUniqId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: maxHeight * 0.045,
            child: Image.asset(
              'assets/logos/logo_black.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          //calaendar
          IconButton(
              onPressed: () {
                customDateRangePicker(context,
                    maxHeight: maxHeight, maxWidth: maxWidth);
              },
              icon: SvgPicture.string(
                calendarString,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.srcIn),
              )),
          //icon: const Icon(CupertinoIcons.calendar)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => pagingController.refresh(),
        ),
        // notificationPredicate: (`notification`) {
        //   return notification.depth == 0;
        // },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            width: maxWidth,
                            height: 220,
                            child: Swiper(
                              pagination: SwiperCustomPagination(builder:
                                  (BuildContext context,
                                      SwiperPluginConfig config) {
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 16, right: 16),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.black.withOpacity(0.5),
                                          height: 22,
                                          width: 41,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${config.activeIndex + 1}/3",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              }),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  3, // Assume banners is a list of your banner data.
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    imageNetworkListViewer(imageUrls: [
                                      "https://malf-live.s3.ap-northeast-2.amazonaws.com/banner/banner2-1.png",
                                      "https://malf-live.s3.ap-northeast-2.amazonaws.com/banner/banner2-2.png",
                                      "https://malf-live.s3.ap-northeast-2.amazonaws.com/banner/banner2-3.png"
                                    ], context: context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ClipRRect(
                                      child: Container(
                                        width: maxWidth,
                                        height: 220,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: ExtendedImage.network(
                                                const [
                                                  "https://malf-live.s3.ap-northeast-2.amazonaws.com/banner/banner2-1.png",
                                                  "https://malf-live.s3.ap-northeast-2.amazonaws.com/banner/banner2-2.png",
                                                  "https://malf-live.s3.ap-northeast-2.amazonaws.com/banner/banner2-3.png"
                                                ][index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: maxWidth,
                              height: 100,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.push("/category/1");
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      155, 71, 145, 255),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade600,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 5,
                                                  offset: const Offset(4,
                                                      4), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/icons/chinese_icon.png",
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover),

                                                // Text(
                                                //   "漢",
                                                //   style: TextStyle(
                                                //       fontSize: 30,
                                                //       color: AppColors.primary,
                                                //       fontWeight:
                                                //           FontWeight.bold),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          AutoSizeText("chinese".tr(),
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.push("/category/2");
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      155, 71, 145, 255),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade600,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 5,
                                                  offset: const Offset(4,
                                                      4), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/icons/english_icon5.png",
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover),

                                                // Text(
                                                //   "Aa",
                                                //   style: TextStyle(
                                                //       fontSize: 30,
                                                //       color: Colors.black87,
                                                //       fontWeight:
                                                //           FontWeight.w500),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          AutoSizeText("english".tr(),
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.push("/category/3");
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      155, 71, 145, 255),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade600,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 5,
                                                  offset: const Offset(4,
                                                      4), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/icons/japanese_icon.png",
                                                    width: 55,
                                                    height: 55,
                                                    fit: BoxFit.cover),
                                                // Text(
                                                //   "あ",
                                                //   style: TextStyle(
                                                //       fontSize: 30,
                                                //       color: Colors.black87,
                                                //       fontWeight:
                                                //           FontWeight.bold),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          AutoSizeText("japanese".tr(),
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //리스트뷰
                    PagedListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate<ListItemData>(
                        animateTransitions: true,
                        itemBuilder: (context, item, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SizedBox(
                              height: 132,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    context.push('/detail/${item.postId}');
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 16, 12, 0),
                                        child: SizedBox(
                                          width: 76,
                                          height: 76,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: ExtendedImage.network(
                                              item.meetingPic.isEmpty
                                                  ? 'https://malftravel.com/default.jpeg'
                                                  : item.meetingPic[0],

                                              // headers: {
                                              //   'Authorization':
                                              //       Token().refreshToken,
                                              // },
                                              // cache: true,
                                              // loadStateChanged:
                                              //     (ExtendedImageState state) {
                                              //   switch (state
                                              //       .extendedImageLoadState) {
                                              //     case LoadState.loading:
                                              //       return const Center(
                                              //         child:
                                              //             CircularProgressIndicator(
                                              //           color: Colors.amber,
                                              //         ),
                                              //       );
                                              //     case LoadState.completed:
                                              //       return null;
                                              //     case LoadState.failed:
                                              //       return const Center(
                                              //         child: Text('😢'),
                                              //       );
                                              //   }
                                              // },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: maxWidth - 150),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${CountryCode.tryParse("${item.authorNation}")?.symbol ?? "?"} ",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            "${item.authorNickname} ",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  8, 0, 8.0, 0),
                                                          child:
                                                              RoundedBackgroundText(
                                                            "${item.userType == 0 ? "foreigner".tr() : "local".tr()} ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: item.userType ==
                                                                        0
                                                                    ? AppColors
                                                                        .primary
                                                                    : AppColors
                                                                        .white),
                                                            backgroundColor:
                                                                item.userType ==
                                                                        0
                                                                    ? AppColors
                                                                        .extraLightGrey
                                                                    : AppColors
                                                                        .primary,
                                                            innerRadius: 20.0,
                                                            outerRadius: 20.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 0, 0),
                                                child: Text(item.title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8.0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  234,
                                                                  234,
                                                                  234),
                                                              width: 2),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0)),
                                                          color: const Color
                                                              .fromARGB(255,
                                                              247, 247, 247),
                                                        ),
                                                        child: Text(
                                                          " ${item.meetingLocation} ",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                234, 234, 234),
                                                            width: 2),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 247, 247, 247),
                                                      ),
                                                      child: Text(
                                                        " ${item.meetingStartTime.year}.${item.meetingStartTime.month}.${item.meetingStartTime.day} | ${item.meetingStartTime.hour < 10 ? "0${item.meetingStartTime.hour}" : item.meetingStartTime.hour.toString()} : ${item.meetingStartTime.minute < 10 ? "0${item.meetingStartTime.minute}" : item.meetingStartTime.minute} ",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Text("foreigner".tr() + " ",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              113,
                                                              162,
                                                              254),
                                                        )),
                                                    Text(
                                                        item.localParticipation
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              113,
                                                              162,
                                                              254),
                                                        )),
                                                    Text(
                                                        "/" +
                                                            item.capacityTravel
                                                                .toString() +
                                                            " | ",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        )),
                                                    Text("local".tr() + " ",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              195,
                                                              255),
                                                        )),
                                                    Text(
                                                        item.travelParticipation
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              195,
                                                              255),
                                                        )),
                                                    Text(
                                                        "/" +
                                                            item.capacityLocal
                                                                .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        )),
                                                    //TODO: need space between
                                                    const Spacer(),

                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          8, 0, 8.0, 0),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            CupertinoIcons
                                                                .heart_fill,
                                                            color: Colors.red,
                                                            size: 16,
                                                          ),
                                                          Text(
                                                              item.likeCount
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //글쓰기 추가
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          heroTag: "write",
          child: const Icon(
            CupertinoIcons.add,
            size: 35,
          ),
          onPressed: () async {
            if (await doAuth(context)) {
              context.push('/write');
              // _pagingController.refresh();
            }
          },
        ),
      ),
    );
  }
}

void customDateRangePicker(BuildContext context,
    {required double maxHeight, required double maxWidth}) {
  int lang = 1;
  switch (context.locale.languageCode) {
    case "ko":
      lang = 0;
      break;
    case "zh":
      lang = 2;
      break;
    case "ja":
      lang = 3;
      break;
    default:
      lang = 1;
      break;
  }
  showDialog(
      context: context,
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: maxHeight * 0.7, maxWidth: maxWidth * 0.9),
              child: Theme(
                data: ThemeData.light().copyWith(
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all<Color>(
                      //     AppColors.primary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppColors.primary),
                      surfaceTintColor:
                          MaterialStateProperty.all<Color>(AppColors.primary),
                      side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.grey)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(16.0)),
                      // shape:
                      //     MaterialStateProperty.all<RoundedRectangleBorder>(
                      //   RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     side: BorderSide(color: Colors.grey.shade300),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                child: DateRangePickerDialog(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDateRange: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(const Duration(days: 7))),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  saveText: dateRangePickString[lang],
                ),
              ),
            ),
          ],
        );
      }).then((value) {
    if (value != null) {
      context.push('/meetingList/date/0', extra: value);
    }
  });
}
