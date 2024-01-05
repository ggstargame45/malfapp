import 'dart:async';
import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:malf/features/community/community_model.dart';
import 'package:malf/features/community/community_page_controller.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/svg_strings.dart';
import 'package:malf/shared/usecases/block_handle.dart';
import 'package:malf/shared/widgets/image_view_widget.dart';

class CommunityListProvider {
  static Future<List<CommunityData>> getCommunityList(
      int pageNo, int limit) async {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
    ));
    try {
      final response =
          await dio.get("/community/posts/?page=$pageNo&limit=$limit");
      // final response = await dio.get("/community/posts/?page=2&limit = 10");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        logger.i("data: $data");
        List<CommunityData> result =
            data.map((e) => CommunityData.fromJson(e)).toList();
        logger.i("result: $result");
        return result;
      } else {
        logger.e(response.statusCode);
        return [];
      }
    } catch (error) {
      logger.e(error);
      return [];
    }
  }
}

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final _pageSize = 10;
  @override
  void initState() {
    // TODO: implement initState
    communityPageController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await CommunityListProvider.getCommunityList(pageKey, _pageSize);
      // communityPageController.appendLastPage(newItems
      //     .where((element) =>
      //         (element.postStatus == 1) &&
      //         (!BlockSet().blockUserUniqIdSet.contains(element.userUniqId)) &&
      //         (!BlockSet().blockMeetingPostIdSet.contains(element.postId)))
      //     .toList());
      // return;
      logger.d("pageKey: $pageKey");
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        communityPageController.appendLastPage(newItems
            .where((element) =>
                (element.postStatus == 1) &&
                (!BlockSet().blockUserUniqIdSet.contains(element.userUniqId)) &&
                (!BlockSet().blockPostingPostIdSet.contains(element.postId)))
            .toList());
      } else {
        final nextPageKey = pageKey + 1;
        communityPageController.appendPage(
            newItems
                .where((element) =>
                    (element.postStatus == 1) &&
                    (!BlockSet()
                        .blockUserUniqIdSet
                        .contains(element.userUniqId)) &&
                    (!BlockSet()
                        .blockPostingPostIdSet
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
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

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
        // actions: [
        //       },
        //       icon: const Icon(CupertinoIcons.search)),
        //calaendar
        //icon: const Icon(CupertinoIcons.calendar)),
        // IconButton(
        //     onPressed: () async {
        //       PackageInfo _packageInfo =
        //           await PackageManager.getPackageInfo();
        //       if (Platform.isAndroid) {
        //         InAppUpdateManager manager = InAppUpdateManager();
        //         AppUpdateInfo? appUpdateInfo = await manager.checkForUpdate();
        //         if (appUpdateInfo == null) return;
        //         if (appUpdateInfo.updateAvailability ==
        //             UpdateAvailability.developerTriggeredUpdateInProgress) {
        //           //If an in-app update is already running, resume the update.
        //           String? message = await manager.startAnUpdate(
        //               type: AppUpdateType.immediate);
        //           debugPrint(message ?? '');
        //         } else if (appUpdateInfo.updateAvailability ==
        //             UpdateAvailability.updateAvailable) {
        //           ///Update available
        //           if (appUpdateInfo.immediateAllowed) {
        //             String? message = await manager.startAnUpdate(
        //                 type: AppUpdateType.immediate);
        //             debugPrint(message ?? '');
        //           } else if (appUpdateInfo.flexibleAllowed) {
        //             String? message = await manager.startAnUpdate(
        //                 type: AppUpdateType.flexible);
        //             debugPrint(message ?? '');
        //           } else {
        //             debugPrint(
        //                 'Update available. Immediate & Flexible Update Flow not allow');
        //           }
        //         }
        //       } else if (Platform.isIOS) {
        //         VersionInfo? _versionInfo =
        //             await UpgradeVersion.getiOSStoreVersion(
        //                 packageInfo: _packageInfo,
        //                 regionCode: WidgetsBinding
        //                     .instance.platformDispatcher.locale.countryCode);
        //         debugPrint(_versionInfo.toJson().toString());
        //       }

        //       // for (var element in communityPageController.itemList??[]) {
        //       //   logger.i(element);

        //       // }
        //     },
        //     icon: const Icon(CupertinoIcons.bell)),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.sync(
            () => communityPageController.refresh(),
          );
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                width: maxWidth,
                height: 220,
                child: Swiper(
                  pagination: SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                    return Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          margin: const EdgeInsets.only(top: 16, right: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              height: 22,
                              width: 41,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${config.activeIndex + 1}/3",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                          )),
                    );
                  }),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3, // Assume banners is a list of your banner data.
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
            ])),
            PagedSliverList(
                pagingController: communityPageController,
                builderDelegate: PagedChildBuilderDelegate<CommunityData>(
                    noItemsFoundIndicatorBuilder: (context) => Container(),
                    itemBuilder: (context, item, index) {
                      String timeDiffString;
                      Duration dateDiffSec = DateTime.now().difference(
                          item.createAt.add(const Duration(hours: 9)));
                      if (dateDiffSec.inSeconds < 60) {
                        timeDiffString =
                            "seconds_ago".plural(dateDiffSec.inSeconds);
                      }
                      if (dateDiffSec.inMinutes < 60) {
                        timeDiffString =
                            "minutes_ago".plural(dateDiffSec.inMinutes);
                      } else if (dateDiffSec.inHours < 24) {
                        timeDiffString =
                            "hours_ago".plural(dateDiffSec.inHours);
                      } else if (dateDiffSec.inDays < 7) {
                        timeDiffString = "days_ago".plural(dateDiffSec.inDays);
                      } else if (dateDiffSec.inDays < 30) {
                        timeDiffString =
                            "weeks_ago".plural(dateDiffSec.inDays ~/ 7);
                      } else if (dateDiffSec.inDays < 365) {
                        timeDiffString =
                            "months_ago".plural(dateDiffSec.inDays ~/ 31);
                      } else {
                        timeDiffString =
                            "years_ago".plural(dateDiffSec.inDays ~/ 365);
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: SizedBox(
                            height: 124,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .push('/communityDetail/${item.postId}');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0,
                                      top: 20,
                                      bottom: 20,
                                      right: 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 4),
                                              child: Text(item.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 24, 0),
                                                child: Text(
                                                  //item.content,
                                                  item.content,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Row(
                                                children: [
                                                  SvgPicture.string(
                                                    reReplyButtonSvgString,
                                                    height: 14,
                                                  ),
                                                  Text(
                                                    " ${item.replyCount}",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " | $timeDiffString | ${item.authorNickname}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (item.picture.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: ExtendedImage.network(
                                              item.picture[0],
                                              height: 84,
                                              width: 84,
                                              fit: BoxFit.cover,
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
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          heroTag: "communityWrite",
          onPressed: () {
            context.push('/communityWrite/write');
          },
          child: const Icon(
            CupertinoIcons.add,
            size: 35,
          ),
        ),
      ),
    );
  }
}
