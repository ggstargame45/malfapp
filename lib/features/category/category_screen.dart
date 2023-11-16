import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/home/home_list_model.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryId});
  final int categoryId;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ListItemData> categoryListData = [];

  void _loadCategoryListData() async {
    categoryListData = [];
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': Token().refreshToken,
        },
        responseType: ResponseType.json,
      ),
    );
    List<dynamic> jsonData =
        (await dio.get("/bulletin-board/posts/?category=${widget.categoryId}"))
            .data["data"];
    setState(() {
      for (var element in jsonData) {
        categoryListData.add(ListItemData.fromJson(element));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCategoryListData();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: false,
        title: widget.categoryId == 1
            ? const Text("chinese").tr()
            : (widget.categoryId == 2
                ? const Text("english").tr()
                : const Text("japanese").tr()),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryListData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () async {
                      await context
                          .push('/detail/${categoryListData[index].postId}');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        height: 132,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 12, 0),
                              child: SizedBox(
                                width: 76,
                                height: 76,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ExtendedImage.network(
                                    categoryListData[index].meetingPic.isEmpty
                                        ? 'https://malftravel.com/default.jpeg'
                                        : '${categoryListData[index].meetingPic[0]}',
                                    headers: {
                                      'Authorization': Token().refreshToken,
                                    },
                                    cache: true,
                                    loadStateChanged:
                                        (ExtendedImageState state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.amber,
                                            ),
                                          );
                                        case LoadState.completed:
                                          return null;
                                        case LoadState.failed:
                                          return const Center(
                                            child: Text('😢'),
                                          );
                                      }
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: maxWidth - 150),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${CountryCode.tryParse("${categoryListData[index].authorNation}")?.symbol ?? "?"} ",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${categoryListData[index].authorNickname} ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8.0, 0),
                                          child: RoundedBackgroundText(
                                            "${categoryListData[index].userType == 0 ? "foreigner".tr() : "local".tr()} ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: categoryListData[index]
                                                            .userType ==
                                                        0
                                                    ? AppColors.primary
                                                    : AppColors.white),
                                            backgroundColor:
                                                categoryListData[index]
                                                            .userType ==
                                                        0
                                                    ? AppColors.extraLightGrey
                                                    : AppColors.primary,
                                            innerRadius: 20.0,
                                            outerRadius: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(categoryListData[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8.0, 0, 0),
                                      child: Row(
                                        children: [
                                          Flexible(
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
                                                " ${categoryListData[index].meetingLocation} ",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontFamily: 'Pretendard',
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
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
                                              " ${categoryListData[index].meetingStartTime.year}.${categoryListData[index].meetingStartTime.month}.${categoryListData[index].meetingStartTime.day} | ${categoryListData[index].meetingStartTime.hour < 10 ? "0${categoryListData[index].meetingStartTime.hour}" : categoryListData[index].meetingStartTime.hour.toString()} : ${categoryListData[index].meetingStartTime.minute < 10 ? "0${categoryListData[index].meetingStartTime.minute}" : categoryListData[index].meetingStartTime.minute} ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
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
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Row(
                                        children: [
                                          Text("${"foreigner".tr()} ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 113, 162, 254),
                                              )),
                                          Text(
                                              categoryListData[index]
                                                  .localParticipation
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 113, 162, 254),
                                              )),
                                          Text(
                                              "/${categoryListData[index]
                                                      .capacityTravel} | ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Colors.grey,
                                              )),
                                          Text("${"local".tr()} ",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 97, 195, 255),
                                              )),
                                          Text(
                                              categoryListData[index]
                                                  .travelParticipation
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 97, 195, 255),
                                              )),
                                          Text(
                                              "/${categoryListData[index]
                                                      .capacityLocal}",
                                              style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 14,
                                                color: Colors.grey,
                                              )),
                                          //TODO: need space between
                                          const Spacer(),

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 8.0, 0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.heart_fill,
                                                  color: Colors.red,
                                                  size: 16,
                                                ),
                                                Text(
                                                    categoryListData[index]
                                                        .likeCount
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
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
                );
              })
        ]),
      ),
    );
  }
}
