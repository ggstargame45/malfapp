import 'dart:convert';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:malf/features/community/community_model.dart';
import 'package:malf/features/community/community_page_controller.dart';
import 'package:malf/features/community/reply_model.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/svg_strings.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/widgets/image_view_widget.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

import '../../shared/network/base_url.dart';



class CommunityDetailScreen extends StatefulWidget {
  final int postId;
  const CommunityDetailScreen({super.key, required this.postId});
  static const routeName = '/communityDetail';

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  CommunityData? communityData;

  final int _pageSize = 10;

  bool imageCheck = false;
  bool scrapCheck = false;
  bool insideCheck = false;

  int replyCount = 0;

  Map<String, String> idPictureMap = {};
  Future<String> _getPictureById(String id) async {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
    ));
    final response = await dio.get("/user/profile/$id");
    logger.i(response.data);
    if (response.data["status"] == 200) {
      final String picture = response.data['data'][0]['profile_pic'];
      logger.i("picture: $picture");
      idPictureMap[id] = picture;
      return picture;
    } else {
      logger.e(response.statusCode);
      return "";
    }
  }

  final TextEditingController _replyInputController = TextEditingController();

  final PagingController<int, ReplyData> _replyPageController =
      PagingController(firstPageKey: 1);

  void initState() {
    // TODO: implement initState
    _replyPageController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
    ));
    dio.get("/community/posts/${widget.postId}").then((value) {
      logger.i("value: ${value.data}");
      if (value.data["status"] == 200) {
        final data = value.data['data'][0];
        data["create_at"] = DateTime.parse(data["create_at"]).add(const Duration(hours: 9)).toString();
        if(data["update_at"] != null) {
          data["update_at"] = DateTime.parse(data["update_at"]).add(const Duration(hours: 9)).toString();
        }
        communityData = CommunityData.fromJson(data);

        scrapCheck = (communityData?.scrapCheck ?? 0) == 1 ? true : false;
        replyCount = communityData?.replyCount ?? 0;
        setState(() {});
      } else {
        logger.e(value.statusCode);
      }
    });

    super.initState();
  }

  Future<List<ReplyData>> getReplyList(int pageNo, int limit) async {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
    ));
    try {
      final response = await dio.get(
          "/community/posts/${widget.postId}/reply/?page=$pageNo&limit=$limit");
      // final response = await dio.get("/community/posts/?page=2&limit = 10");
      logger.i(response.data);
      if (response.data["status"] == 200) {
        List<dynamic> data = response.data['data'];

        for (var element in data) {
          if (!idPictureMap.containsKey(element['user_uniq_id'])) {
            await _getPictureById(element['user_uniq_id']);
          }
        }
        logger.i("data: $data");
        List<ReplyData> result = data.map((e) {
          e['author_picture'] = idPictureMap[e['user_uniq_id']] ?? "";
          return ReplyData.fromJson(e);
        }).toList();
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

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getReplyList(pageKey, _pageSize);
      logger.d("pageKey: $pageKey");
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _replyPageController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _replyPageController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // _pagingController.error = error;
      logger.e(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 감추기
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar:
            (communityData != null && communityData!.picture.isNotEmpty)
                ? true
                : false,
        appBar: AppBar(
          // shadowColor: Colors.grey,
          // elevation: 1,
          backgroundColor:
              (communityData != null && communityData!.picture.isNotEmpty)
                  ? Colors.white10
                  : Colors.white,
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
            IconButton(
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.black,
                ),
                onPressed: () async {
                  var contexta = context;
                  showModalBottomSheet(
                      context: contexta,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      builder: (contextb) {
                        return Container(
                          padding: EdgeInsets.only(top: 8,bottom: MediaQuery.of(contextb).viewPadding.bottom),
                          width: MediaQuery.of(contextb).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                              if (communityData!.userUniqId ==
                                  Token().userUniqId)
                                GestureDetector(
                                  onTap: () async {
                                    contextb.pop();
                                    try {
                                      final dio = Dio(BaseOptions(
                                          baseUrl: baseUrl,
                                          headers: {
                                            'Authorization':
                                                Token().refreshToken
                                          },
                                          responseType: ResponseType.json));
                                      final response = await dio.delete(
                                        "/community/posts/${communityData!.postId}",
                                      );
                                      if (response.statusCode == 201) {
                                        communityPageController.refresh();
                                        contexta.pop();
                                      } else {
                                        ScaffoldMessenger.of(contexta)
                                            .showSnackBar(SnackBar(
                                          content: Text("fail".tr()),
                                        ));
                                      }

                                      logger.d(response.data);
                                      //return response.statusCode;
                                    } catch (error) {
                                      logger.d('오류: $error');
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.sizeOf(contextb).width,
                                      height: 60,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.redAccent,
                                            size: 30,
                                          ),
                                          Text(
                                            "community_delete".tr(),
                                            style: const TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )),
                                ),
                              if (communityData!.userUniqId !=
                                  Token().userUniqId)
                                GestureDetector(
                                  onTap: () async {
                                    contextb.pop();
                                    await contexta.push("/report", extra: {
                                      "reportType": "post",
                                      "id": communityData!.postId.toString(),
                                      "title": communityData!.title
                                    });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.sizeOf(contextb).width,
                                      height: 60,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.report_outlined,
                                            color: Color.fromARGB(
                                                138, 158, 158, 158),
                                            size: 30,
                                          ),
                                          Text(
                                            "report".tr(), //개시물 신고하기
                                            style: const TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )),
                                ),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              if (communityData!.userUniqId ==
                                  Token().userUniqId)
                                GestureDetector(
                                  onTap: () async {
                                    contextb.pop();
                                    await contexta.push('/edit',
                                        extra: communityData!);
                                    communityPageController.refresh();
                                    contexta
                                      ..go('/home')
                                      ..push(
                                          '/detail/${communityData!.postId}');
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.sizeOf(contextb).width,
                                      height: 60,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.mode_edit_outlined,
                                            color: Color.fromARGB(
                                                138, 158, 158, 158),
                                            size: 30,
                                          ),
                                          Text(
                                            "edit".tr(), //게시물 수정하기
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    138, 158, 158, 158),
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )),
                                ),
                              if (communityData!.userUniqId !=
                                  Token().userUniqId)
                                GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: contextb,
                                        builder: (contextc) {
                                          return AlertDialog(
                                            title: Text("block".tr()),
                                            content: Text("block_meeting".tr()),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    bool onlyDetail = true;
                                                    await showDialog(
                                                        context: contextc,
                                                        builder: (contextd) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "block_additional"
                                                                    .tr()),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    onlyDetail =
                                                                        false;
                                                                    contextd
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      "block"
                                                                          .tr())),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    onlyDetail =
                                                                        true;
                                                                    contextd
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      "no".tr()))
                                                            ],
                                                          );
                                                        });

                                                    contextc.pop();
                                                    contextb.pop();
                                                    contexta.pop();
                                                    if (onlyDetail) {
                                                      // CommunityBlockSet().addBlockMeeting(
                                                      //   postId: communityData!.postId,
                                                      //   title: communityData!.title,
                                                      //   authorNickname: communityData!.authorNickname,
                                                      // );
                                                    } else {
                                                      // CommunityBlockSet().addBlockUser(uniqId: communityData!.userUniqId, nickname: communityData!.authorNickname);
                                                    }

                                                    communityPageController
                                                        .refresh();
                                                    ScaffoldMessenger.of(
                                                            contexta)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "unblock_message"
                                                                    .tr())));
                                                  },
                                                  child: Text("confirm".tr())),
                                              TextButton(
                                                  onPressed: () {
                                                    contextc.pop();
                                                  },
                                                  child: Text("cancel".tr()))
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.sizeOf(contextb).width,
                                      height: 60,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.block_outlined,
                                            color: Color.fromARGB(
                                                138, 158, 158, 158),
                                            size: 30,
                                          ),
                                          Text(
                                            "block".tr(), //개시물 신고하기
                                            style: const TextStyle(
                                                color: Colors.pinkAccent,
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
                                    contextb.pop();
                                  },
                                  child: Text('cancel'.tr()),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0,
              (communityData != null && communityData!.picture.isNotEmpty)
                  ? MediaQuery.of(context).viewPadding.top
                  : 0,
              0,
              65),
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                if (communityData != null && communityData!.picture.isNotEmpty)
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 210,
                    child: Swiper(
                      pagination: SwiperCustomPagination(builder:
                          (BuildContext context, SwiperPluginConfig config) {
                        return Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 16, right: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  height: 22,
                                  width: 41,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${config.activeIndex + 1}/${communityData!.picture.length}",
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
                      // control: const SwiperControl(),
                      scrollDirection: Axis.horizontal,
                      itemCount: communityData!.picture
                          .length, // Assume banners is a list of your banner data.
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (communityData != null) {
                              imageNetworkListViewer(
                                  imageUrls: communityData!.picture,
                                  context: context);
                            }
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 210,
                                child: ExtendedImage.network(
                                  communityData!.picture[index],
                                  fit: BoxFit.cover,
                                  cache: true,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: SizedBox(
                          // height: 56,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: ExtendedNetworkImageProvider(
                                  communityData?.authorPic?[0] ?? "",
                                  cache: true),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if ((communityData?.authorStatus ?? 0) == 1)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 0, 6),
                                child: RoundedBackgroundText(
                                  (communityData!.userType == 0
                                          ? "foreigner"
                                          : "local")
                                      .tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: communityData!.userType == 0
                                          ? AppColors.primary
                                          : AppColors.white),
                                  backgroundColor: communityData!.userType == 0
                                      ? AppColors.extraLightGrey
                                      : AppColors.primary,
                                  innerRadius: 20.0,
                                  outerRadius: 20.0,
                                ),
                              ),
                            Text(
                                "${CountryCode.tryParse("${communityData?.authorNation} ")?.symbol ?? ""}${communityData?.authorNickname ?? ""}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 128, 128, 128),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text("${communityData?.createAt ?? ""}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 128, 128, 128))),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          child: Text(communityData?.title ?? "",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          child: Text(communityData?.content ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("scrap".tr()),
                                    content: scrapCheck
                                        ? Text("unscrap".tr())
                                        : Text("scrap".tr()),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            final dio = Dio(BaseOptions(
                                                baseUrl: baseUrl,
                                                headers: {
                                                  'Authorization':
                                                      Token().refreshToken
                                                },
                                                responseType:
                                                    ResponseType.json));
                                            if (scrapCheck) {
                                              final result = await dio.delete(
                                                  "/community/posts/${widget.postId}/scrap");
                                              if (result.statusCode == 201) {
                                                scrapCheck = false;
                                              }
                                              context.pop();
                                              setState(() {});
                                            } else {
                                              final result = await dio.post(
                                                  "/community/posts/${widget.postId}/scrap");
                                              if (result.statusCode == 201) {
                                                scrapCheck = true;
                                              }
                                              context.pop();
                                              setState(() {});
                                            }
                                          },
                                          child: Text("confirm".tr())),
                                      TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: Text("cancel".tr()))
                                    ],
                                  );
                                });
                            if (scrapCheck) {
                            } else {}
                          },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SvgPicture.string(
                                  scrapButtonSvgString,
                                  colorFilter: const ColorFilter.mode(
                                      Color.fromARGB(255, 128, 128, 128),
                                      BlendMode.srcIn),
                                ),
                              ),
                              Text(scrapCheck ? "unscrap".tr() : "scrap".tr(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)))
                            ],
                          ),
                        ),
                      ]),
                ),
                Container(
                  height: 10,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: SvgPicture.string(
                          reReplyButtonSvgString,
                        ),
                      ),
                      Text("$replyCount",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 128, 128, 128))),
                    ],
                  ),
                ),
              ])),
              PagedSliverList(
                  pagingController: _replyPageController,
                  builderDelegate: PagedChildBuilderDelegate<ReplyData>(
                      noItemsFoundIndicatorBuilder: (context) => Container(),
                      itemBuilder: (context, item, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 16, bottom: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.push(
                                            '/profileOther/${item.userUniqId}');
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 38,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: CircleAvatar(
                                                backgroundImage:
                                                    ExtendedNetworkImageProvider(
                                                        item.authorPicture[0],
                                                        cache: true),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                if (item.authorStatus == 1)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(4, 0, 0, 4),
                                                    child:
                                                        RoundedBackgroundText(
                                                      (item.userType == 0
                                                              ? "foreigner"
                                                              : "local")
                                                          .tr(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              item.userType == 0
                                                                  ? AppColors
                                                                      .primary
                                                                  : AppColors
                                                                      .white),
                                                      backgroundColor: item
                                                                  .userType ==
                                                              0
                                                          ? AppColors
                                                              .extraLightGrey
                                                          : AppColors.primary,
                                                      innerRadius: 20.0,
                                                      outerRadius: 20.0,
                                                    ),
                                                  ),
                                                Text(item.authorNickname,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255, 128, 128, 128),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(right: 4),
                                          //   child: Material(
                                          //     color: Colors.transparent,
                                          //     child: InkWell(
                                          //       onTap: () {

                                          //       },
                                          //       child: Container(
                                          //         alignment: Alignment.center,
                                          //         decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     5),
                                          //             border: Border.all(
                                          //                 color: Colors.grey)),
                                          //         width: 32,
                                          //         height: 32,
                                          //         child: SvgPicture.string(
                                          //           reReplyButtonSvgString,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                var contexta = context;
                                                showModalBottomSheet(
                                                    context: contexta,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    builder: (contextb) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets
                                                                .only(top: 8,bottom: MediaQuery.of(contextb).viewPadding.bottom), 
                                                        width: MediaQuery.of(
                                                                contextb)
                                                            .size
                                                            .width,
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              height: 3,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            if (item.userUniqId ==
                                                                Token()
                                                                    .userUniqId)
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  contextb
                                                                      .pop();
                                                                  try {
                                                                    final dio = Dio(BaseOptions(
                                                                        baseUrl:
                                                                            baseUrl,
                                                                        headers: {
                                                                          'Authorization':
                                                                              Token().refreshToken
                                                                        },
                                                                        responseType:
                                                                            ResponseType.json));
                                                                    final response =
                                                                        await dio
                                                                            .delete(
                                                                      "/community/posts/${widget.postId}/reply/${item.replyId}",
                                                                    );
                                                                    if (response
                                                                            .statusCode ==
                                                                        201) {
                                                                      _replyPageController
                                                                          .refresh();
                                                                      replyCount--;
                                                                      setState(() {
                                                                        
                                                                      });
                                                                      
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              contexta)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content:
                                                                            Text("fail".tr()),
                                                                      ));
                                                                    }

                                                                    logger.d(
                                                                        response
                                                                            .data);
                                                                    //return response.statusCode;
                                                                  } catch (error) {
                                                                    logger.d(
                                                                        '오류: $error');
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            15),
                                                                        width: MediaQuery.sizeOf(contextb)
                                                                            .width,
                                                                        height:
                                                                            60,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.delete_outline_rounded,
                                                                              color: Colors.redAccent,
                                                                              size: 30,
                                                                            ),
                                                                            Text(
                                                                              "reply_delete".tr(),
                                                                              style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w700),
                                                                            )
                                                                          ],
                                                                        )),
                                                              ),
                                                            if (item.userUniqId !=
                                                                Token()
                                                                    .userUniqId)
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  contextb
                                                                      .pop();
                                                                  await contexta.push(
                                                                      "/report",
                                                                      extra: {
                                                                        "reportType":
                                                                            "reply",
                                                                        "id": item
                                                                            .replyId
                                                                            .toString(),
                                                                        "title":
                                                                            item.content
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            15),
                                                                        width: MediaQuery.sizeOf(contextb)
                                                                            .width,
                                                                        height:
                                                                            60,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.report_outlined,
                                                                              color: Color.fromARGB(138, 158, 158, 158),
                                                                              size: 30,
                                                                            ),
                                                                            Text(
                                                                              "report".tr(), //개시물 신고하기
                                                                              style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w700),
                                                                            )
                                                                          ],
                                                                        )),
                                                              ),
                                                            const Divider(
                                                              height: 1,
                                                              thickness: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            // if (item.userUniqId !=
                                                            //     Token()
                                                            //         .userUniqId)
                                                            //   GestureDetector(
                                                            //     onTap:
                                                            //         () async {
                                                            //       showDialog(
                                                            //           context:
                                                            //               contextb,
                                                            //           builder:
                                                            //               (contextc) {
                                                            //             return AlertDialog(
                                                            //               title:
                                                            //                   Text("block".tr()),
                                                            //               content:
                                                            //                   Text("block_meeting".tr()),
                                                            //               actions: [
                                                            //                 TextButton(
                                                            //                     onPressed: () async {
                                                            //                       bool onlyDetail = true;
                                                            //                       await showDialog(
                                                            //                           context: contextc,
                                                            //                           builder: (contextd) {
                                                            //                             return AlertDialog(
                                                            //                               content: Text("block_additional".tr()),
                                                            //                               actions: [
                                                            //                                 TextButton(
                                                            //                                     onPressed: () {
                                                            //                                       onlyDetail = false;
                                                            //                                       contextd.pop();
                                                            //                                     },
                                                            //                                     child: Text("block".tr())),
                                                            //                                 TextButton(
                                                            //                                     onPressed: () {
                                                            //                                       onlyDetail = true;
                                                            //                                       contextd.pop();
                                                            //                                     },
                                                            //                                     child: Text("no".tr()))
                                                            //                               ],
                                                            //                             );
                                                            //                           });

                                                            //                       contextc.pop();
                                                            //                       contextb.pop();
                                                            //                       contexta.pop();
                                                            //                       if (onlyDetail) {
                                                            //                         // CommunityBlockSet().addBlockMeeting(
                                                            //                         //   postId: communityData!.postId,
                                                            //                         //   title: communityData!.title,
                                                            //                         //   authorNickname: communityData!.authorNickname,
                                                            //                         // );
                                                            //                       } else {
                                                            //                         // CommunityBlockSet().addBlockUser(uniqId: communityData!.userUniqId, nickname: communityData!.authorNickname);
                                                            //                       }

                                                            //                       communityPageController.refresh();
                                                            //                       ScaffoldMessenger.of(contexta).showSnackBar(SnackBar(content: Text("unblock_message".tr())));
                                                            //                     },
                                                            //                     child: Text("confirm".tr())),
                                                            //                 TextButton(
                                                            //                     onPressed: () {
                                                            //                       contextc.pop();
                                                            //                     },
                                                            //                     child: Text("cancel".tr()))
                                                            //               ],
                                                            //             );
                                                            //           });
                                                            //     },
                                                            //     child:
                                                            //         Container(
                                                            //             padding: const EdgeInsets
                                                            //                 .all(
                                                            //                 15),
                                                            //             width: MediaQuery.sizeOf(contextb)
                                                            //                 .width,
                                                            //             height:
                                                            //                 60,
                                                            //             child:
                                                            //                 Row(
                                                            //               children: [
                                                            //                 const Icon(
                                                            //                   Icons.block_outlined,
                                                            //                   color: Color.fromARGB(138, 158, 158, 158),
                                                            //                   size: 30,
                                                            //                 ),
                                                            //                 Text(
                                                            //                   "block".tr(), //개시물 신고하기
                                                            //                   style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w700),
                                                            //                 )
                                                            //               ],
                                                            //             )),
                                                            //   ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              // SizedBox 대신 Container를 사용 가능
                                                              width: 300,
                                                              height: 50,
                                                              child:
                                                                  FilledButton(
                                                                onPressed: () {
                                                                  contextb
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    'cancel'
                                                                        .tr()),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                width: 32,
                                                height: 32,
                                                child: const Icon(
                                                  CupertinoIcons.ellipsis,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 12, 0, 0),
                                      child: Text(
                                        //item.content,
                                        item.content,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ),
        bottomSheet: Container(
          height: 60,
          decoration: const BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: _replyInputController,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8),
                    filled: true,
                    fillColor: const Color.fromARGB(97, 158, 158, 158),
                    hintText: "chat_room_input_hint".tr(),
                    hintStyle:
                        const TextStyle(fontSize: 15, color: Colors.grey),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                maxLines: null,
              )),
              IconButton(
                onPressed: () async {
                  if (_replyInputController.text.isNotEmpty) {
                    await _replySend(content: _replyInputController.text);
                    _replyInputController.clear();
                  }
                },
                icon: const Icon(CupertinoIcons.paperplane_fill),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _replySend({required String content}) async {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
    ));

    await dio.post("/community/posts/${widget.postId}/reply", data: {
      "content": _replyInputController.text,
    }).then((value) {
      logger.i(value.statusCode);
      try {
        if (value.statusCode == 201) {
          logger.i(communityPageController.itemList!
              .indexWhere((element) => element.postId == widget.postId));

          _replyPageController.refresh();
        } else {
          logger.e("댓글 작성 실패");
        }
      } on Exception catch (e) {
        // TODO
      }
    });
  }
}
