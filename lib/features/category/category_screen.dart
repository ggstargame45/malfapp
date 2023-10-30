import 'package:country_code/country_code.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/home/home_list_model.dart';
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
    List<dynamic> jsonData = (await dio.get("/bulletin-board/posts/?category=${widget.categoryId}")).data["data"];
    setState(() {
      jsonData.forEach((element) {
        categoryListData.add(ListItemData.fromJson(element));
      });
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
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: false,
        title: widget.categoryId == 1
            ? Text("chinese/korean").tr()
            : (widget.categoryId == 2
                ? Text("english/korean").tr()
                : Text("japanese/korean").tr()),
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await context.push(
                              '/detail/${categoryListData[index].postId}');

                          // rootNavigatorKey.currentState
                          //     ?.pushNamed(
                          //         "/detail/${state.listItems[index].postId}",
                          //        );
                          // Navigator.of(context, rootNavigator: true)
                          //     .push(MaterialPageRoute(
                          //         builder: (context) => DetailScreen(
                          //               postId: state
                          //                   .listItems[index].postId,
                          //             )));
                        },
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: maxWidth * 0.20,
                                height: maxWidth * 0.20,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ExtendedImage.network(
                                    categoryListData[index].meetingPic.isEmpty
                                        ? 'https://malftravel.com/default.jpeg'
                                        : '$baseUrl/${categoryListData[index].meetingPic[0]}',
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

                                    // errorBuilder: (BuildContext context,
                                    //     Object error,
                                    //     StackTrace? stackTrace) {
                                    //   return const Text('😢');
                                    // },
                                    fit: BoxFit.cover,

                                    // frameBuilder: (BuildContext context,
                                    //     Widget child,
                                    //     int? frame,
                                    //     bool wasSynchronouslyLoaded) {
                                    //   return Container(
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(12),
                                    //       color: const Color.fromRGBO(
                                    //           91, 91, 91, 1),
                                    //     ),
                                    //     child: child,
                                    //   );
                                    // },
                                    // loadingBuilder: (BuildContext context,
                                    //     Widget child,
                                    //     ImageChunkEvent? loadingProgress) {
                                    //   if (loadingProgress == null) {
                                    //     return child;
                                    //   }
                                    //   return Container(
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(12),
                                    //       color: const Color.fromRGBO(
                                    //           91, 91, 91, 1),
                                    //     ),
                                    //     child: const Center(
                                    //       child: CircularProgressIndicator(
                                    //         color: Colors.amber,
                                    //       ),
                                    //     ),
                                    //   );
                                    // },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          //Flag.fromString(CountryCode.parse(state.listItems[index].authorNation), height: 20, width: 20, fit: BoxFit.fill),
                                          Text(
                                            "${CountryCode.tryParse("${categoryListData[index].authorNation}")?.symbol ?? "?"} ",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: maxWidth * 0.3,
                                            child: Text(
                                              "${categoryListData[index].authorNickname} ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RoundedBackgroundText(
                                              "${categoryListData[index].userType == 0 ? "foreigner" : "local"}"
                                                  .tr(),
                                              style: TextStyle(
                                                  color: categoryListData[index]
                                                              .userType ==
                                                          0
                                                      ? AppColors.primary
                                                      : AppColors.white),
                                              backgroundColor: categoryListData[index]
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: AppColors.primary,
                                          ),
                                          Text(
                                              "${categoryListData[index].postId}"),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: maxWidth * 0.6,
                                    child: Text(categoryListData[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "${categoryListData[index].meetingLocation} ",
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: const Color.fromARGB(
                                              255, 247, 247, 247),
                                        ),
                                      ),
                                      RoundedBackgroundText(
                                        "${categoryListData[index].meetingStartTime.year}.${categoryListData[index].meetingStartTime.month}.${categoryListData[index].meetingStartTime.day} | ${categoryListData[index].meetingStartTime.hour < 10 ? "0${categoryListData[index].meetingStartTime.hour}" : categoryListData[index].meetingStartTime.hour.toString()} : ${categoryListData[index].meetingStartTime.minute < 10 ? "0${categoryListData[index].meetingStartTime.minute}" : categoryListData[index].meetingStartTime.minute}",
                                        style: const TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 247, 247, 247),
                                        innerRadius: 20.0,
                                        outerRadius: 20.0,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("foreigner".tr() + " ",
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 113, 162, 254),
                                          )),
                                      Text("0",
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 113, 162, 254),
                                          )),
                                      Text(
                                          "/" +
                                              categoryListData[index]
                                                  .capacityTravel
                                                  .toString() +
                                              " | ",
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 14,
                                            color: Colors.grey,
                                          )),
                                      Text("local".tr() + " ",
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 97, 195, 255),
                                          )),
                                      Text("0",
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 97, 195, 255),
                                          )),
                                      Text(
                                          "/" +
                                              categoryListData[index]
                                                  .capacityLocal
                                                  .toString(),
                                          style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 14,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
        ]),
      ),
    );
  }
}
