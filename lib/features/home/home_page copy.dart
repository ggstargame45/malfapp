// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:malf/config/routes/app_route.dart';
// import 'package:malf/features/detail/detail_screen.dart';
// import 'package:malf/features/home/home_list_provider.dart';
// import 'package:malf/features/write/write_screen.dart';
// import 'package:malf/shared/network/base_url.dart';
// import 'package:malf/shared/theme/app_colors.dart';
// import 'package:malf/shared/theme/app_theme.dart';
// import 'package:malf/shared/theme/test_styles.dart';
// import './home_list_model.dart';

// import 'package:malf/shared/logger.dart';
// import 'package:malf/shared/network/token.dart';

// import 'package:provider/provider.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:flag/flag.dart';
// import 'package:country_code/country_code.dart';
// import 'package:rounded_background_text/rounded_background_text.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({
//     super.key,
//   });

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late String token;

//   EdgeInsets edge = const EdgeInsets.all(8);

//   @override
//   Widget build(BuildContext context) {
//     token = Token().refreshToken;
//     double maxHeight = MediaQuery.of(context).size.height;
//     double maxWidth = MediaQuery.of(context).size.width;

//     logger.e(token);

//     return ChangeNotifierProvider<HomeListProvider>(
//       create: (_) {
//         return HomeListProvider()..started();
//       },
//       child: Consumer<HomeListProvider>(
//         builder: (context, state, child) {
//           return Scaffold(
//             appBar: AppBar(
//               //leading: ,
//               //backgroundColor: Colors.white,
//               centerTitle: false,
//               title: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   height: maxHeight * 0.045,
//                   child: Image.asset(
//                     'assets/logos/logo_black.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               actions: [
//                 //TODO: 검색

//                 //TODO: 필터

//                 //TODO: 새로고침
//                 SafeArea(
//                   child: IconButton(
//                       iconSize: maxHeight * 0.05,
//                       onPressed: () {
//                         state.started();
//                       },
//                       icon: const Icon(Icons.refresh)),
//                 ),
//               ],
//             ),
//             body: NotificationListener<ScrollUpdateNotification>(
//                 onNotification: (notification) {
//                   state.scrollListerner(notification);
//                   return false;
//                 },
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         width: maxWidth,
//                         height: maxHeight / 3.5,
//                         child: Swiper(
//                           viewportFraction: 0.8,
//                           scale: 0.9,
//                           pagination: SwiperPagination(),
//                           control: SwiperControl(),
//                           scrollDirection: Axis.horizontal,
//                           itemCount:
//                               5, // Assume banners is a list of your banner data.
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: maxWidth,
//                                 height: maxWidth / 2,
//                                 child: ExtendedImage.network(
//                                   "https://malftravel.com/ad/1.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           width: maxWidth,
//                           height: maxWidth / 4.5,
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     context.push("/category/1");
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 28,
//                                         backgroundColor:
//                                             Color.fromARGB(255, 71, 145, 255),
//                                         child: CircleAvatar(
//                                           radius: 25,
//                                           backgroundColor: Colors.white,
//                                           child: Text(
//                                             "漢",
//                                             style: TextStyle(
//                                                 fontSize: 30,
//                                                 color: Colors.black87,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ),
//                                       AutoSizeText("chinese".tr(),
//                                           style: AppTextStyles.body.copyWith(
//                                               fontWeight: FontWeight.bold)),
//                                     ],
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     context.push("/category/2");
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 28,
//                                         backgroundColor:
//                                             Color.fromARGB(255, 71, 145, 255),
//                                         child: CircleAvatar(
//                                           radius: 25,
//                                           backgroundColor: Colors.white,
//                                           child: Text(
//                                             "Aa",
//                                             style: TextStyle(
//                                                 fontSize: 30,
//                                                 color: Colors.black87,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                       ),
//                                       AutoSizeText("english".tr(),
//                                           style: AppTextStyles.body.copyWith(
//                                               fontWeight: FontWeight.bold)),
//                                     ],
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     context.push("/category/3");
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 28,
//                                         backgroundColor:
//                                             Color.fromARGB(255, 71, 145, 255),
//                                         child: CircleAvatar(
//                                           radius: 25,
//                                           backgroundColor: Colors.white,
//                                           child: Text(
//                                             "あ",
//                                             style: TextStyle(
//                                                 fontSize: 30,
//                                                 color: Colors.black87,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ),
//                                       AutoSizeText("japanese".tr(),
//                                           style: AppTextStyles.body.copyWith(
//                                               fontWeight: FontWeight.bold)),
//                                     ],
//                                   ),
//                                 ),
//                               ]),
//                         ),
//                       ),
//                       Divider(
//                         color: Colors.black,
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: state.listItems.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 8),
//                                 child: GestureDetector(
//                                   onTap: () async {
//                                     await context.push(
//                                         '/detail/${state.listItems[index].postId}');
//                                     state.started();
//                                     // rootNavigatorKey.currentState
//                                     //     ?.pushNamed(
//                                     //         "/detail/${state.listItems[index].postId}",
//                                     //        );
//                                     // Navigator.of(context, rootNavigator: true)
//                                     //     .push(MaterialPageRoute(
//                                     //         builder: (context) => DetailScreen(
//                                     //               postId: state
//                                     //                   .listItems[index].postId,
//                                     //             )));
//                                   },
//                                   child: SizedBox(
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: maxWidth * 0.20,
//                                           height: maxWidth * 0.20,
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             child: ExtendedImage.network(
//                                               state.listItems[index].meetingPic
//                                                       .isEmpty
//                                                   ? 'https://malftravel.com/default.jpeg'
//                                                   : '${baseUrl}/${state.listItems[index].meetingPic[0]}',
//                                               headers: {
//                                                 'Authorization': token,
//                                               },
//                                               cache: true,
//                                               loadStateChanged:
//                                                   (ExtendedImageState state) {
//                                                 switch (state
//                                                     .extendedImageLoadState) {
//                                                   case LoadState.loading:
//                                                     return const Center(
//                                                       child:
//                                                           CircularProgressIndicator(
//                                                         color: Colors.amber,
//                                                       ),
//                                                     );
//                                                   case LoadState.completed:
//                                                     return null;
//                                                   case LoadState.failed:
//                                                     return const Center(
//                                                       child: Text('😢'),
//                                                     );
//                                                 }
//                                               },

//                                               // errorBuilder: (BuildContext context,
//                                               //     Object error,
//                                               //     StackTrace? stackTrace) {
//                                               //   return const Text('😢');
//                                               // },
//                                               fit: BoxFit.cover,

//                                               // frameBuilder: (BuildContext context,
//                                               //     Widget child,
//                                               //     int? frame,
//                                               //     bool wasSynchronouslyLoaded) {
//                                               //   return Container(
//                                               //     decoration: BoxDecoration(
//                                               //       borderRadius:
//                                               //           BorderRadius.circular(12),
//                                               //       color: const Color.fromRGBO(
//                                               //           91, 91, 91, 1),
//                                               //     ),
//                                               //     child: child,
//                                               //   );
//                                               // },
//                                               // loadingBuilder: (BuildContext context,
//                                               //     Widget child,
//                                               //     ImageChunkEvent? loadingProgress) {
//                                               //   if (loadingProgress == null) {
//                                               //     return child;
//                                               //   }
//                                               //   return Container(
//                                               //     decoration: BoxDecoration(
//                                               //       borderRadius:
//                                               //           BorderRadius.circular(12),
//                                               //       color: const Color.fromRGBO(
//                                               //           91, 91, 91, 1),
//                                               //     ),
//                                               //     child: const Center(
//                                               //       child: CircularProgressIndicator(
//                                               //         color: Colors.amber,
//                                               //       ),
//                                               //     ),
//                                               //   );
//                                               // },
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 12),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     //Flag.fromString(CountryCode.parse(state.listItems[index].authorNation), height: 20, width: 20, fit: BoxFit.fill),
//                                                     Text(
//                                                       "${CountryCode.tryParse("${state.listItems[index].authorNation}")?.symbol ?? "?"} ",
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: maxWidth * 0.3,
//                                                       child: Text(
//                                                         "${state.listItems[index].authorNickname} ",
//                                                         maxLines: 1,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: TextStyle(
//                                                           fontSize: 13,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding: const EdgeInsets
//                                                           .fromLTRB(
//                                                           8, 0, 8.0, 0),
//                                                       child:
//                                                           RoundedBackgroundText(
//                                                         "${state.listItems[index].userType == 0 ? "foreigner" : "local"}"
//                                                             .tr(),
//                                                         style: TextStyle(
//                                                             fontSize: 12,
//                                                             color: state
//                                                                         .listItems[
//                                                                             index]
//                                                                         .userType ==
//                                                                     0
//                                                                 ? AppColors
//                                                                     .primary
//                                                                 : AppColors
//                                                                     .white),
//                                                         backgroundColor: state
//                                                                     .listItems[
//                                                                         index]
//                                                                     .userType ==
//                                                                 0
//                                                             ? AppColors
//                                                                 .extraLightGrey
//                                                             : AppColors.primary,
//                                                         innerRadius: 20.0,
//                                                         outerRadius: 40.0,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     Icon(
//                                                       Icons.star,
//                                                       color: AppColors.primary,
//                                                     ),
//                                                     Text(
//                                                         "${state.listItems[index].postId}"),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                             Container(
//                                               width: maxWidth * 0.6,
//                                               child: Text(
//                                                   state.listItems[index].title,
//                                                   maxLines: 1,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: const TextStyle(
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   child: Text(
//                                                     "${state.listItems[index].meetingLocation} ",
//                                                     style: const TextStyle(
//                                                       fontFamily: 'Pretendard',
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                   decoration: new BoxDecoration(
//                                                     borderRadius:
//                                                         new BorderRadius.all(
//                                                             new Radius.circular(
//                                                                 10.0)),
//                                                     color: Color.fromARGB(
//                                                         255, 205, 204, 204),
//                                                   ),
//                                                 ),
//                                                 RoundedBackgroundText(
//                                                   "${state.listItems[index].meetingStartTime.year}.${state.listItems[index].meetingStartTime.month}.${state.listItems[index].meetingStartTime.day} | ${state.listItems[index].meetingStartTime.hour < 10 ? "0${state.listItems[index].meetingStartTime.hour}" : state.listItems[index].meetingStartTime.hour.toString()} : ${state.listItems[index].meetingStartTime.minute < 10 ? "0${state.listItems[index].meetingStartTime.minute}" : state.listItems[index].meetingStartTime.minute}",
//                                                   style: const TextStyle(
//                                                     fontFamily: 'Pretendard',
//                                                     fontSize: 12,
//                                                     color: Colors.black,
//                                                   ),
//                                                   backgroundColor:
//                                                       Color.fromARGB(
//                                                           255, 194, 194, 194),
//                                                   innerRadius: 20.0,
//                                                   outerRadius: 20.0,
//                                                 )
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text("foreigner".tr() + " ",
//                                                     style: const TextStyle(
//                                                       fontFamily: 'Pretendard',
//                                                       fontSize: 14,
//                                                       color: Color.fromARGB(
//                                                           255, 113, 162, 254),
//                                                     )),
//                                                 Text("~",
//                                                     style: const TextStyle(
//                                                       fontFamily: 'Pretendard',
//                                                       fontSize: 14,
//                                                       color: Color.fromARGB(
//                                                           255, 113, 162, 254),
//                                                     )),
//                                                 Text(
//                                                     "/" +
//                                                         state.listItems[index]
//                                                             .capacityTravel
//                                                             .toString() +
//                                                         " | ",
//                                                     style: const TextStyle(
//                                                       fontFamily: 'Pretendard',
//                                                       fontSize: 14,
//                                                       color: Colors.grey,
//                                                     )),
//                                                 Text("local".tr() + " ",
//                                                     style: const TextStyle(
//                                                       fontFamily: 'Pretendard',
//                                                       fontSize: 14,
//                                                       color: Color.fromARGB(
//                                                           255, 97, 195, 255),
//                                                     )),
//                                                 Text("~",
//                                                     style: const TextStyle(
//                                                       fontFamily: 'Pretendard',
//                                                       fontSize: 14,
//                                                       color: Color.fromARGB(
//                                                           255, 97, 195, 255),
//                                                     )),
//                                                 Text(
//                                                     "/" +
//                                                         state.listItems[index]
//                                                             .capacityLocal
//                                                             .toString(),
//                                                     style: const TextStyle(
//                                                       fontFamily: 'Pretendard',
//                                                       fontSize: 14,
//                                                       color: Colors.grey,
//                                                     )),
//                                               ],
//                                             )
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Divider(
//                                 color: Colors.grey,
//                                 indent: 15,
//                                 endIndent: 15,
//                               ),
//                               if (state.listItems.length - 1 == index &&
//                                   state.isAdd) ...[
//                                 const SizedBox(
//                                   height: 100,
//                                   child: Center(
//                                       child: CircularProgressIndicator(
//                                     color: Colors.deepOrange,
//                                   )),
//                                 ),
//                               ],
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 )),
//             //글쓰기 추가
//             floatingActionButton: Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors.primary,
//               ),
//               child: IconButton(
//                 color: AppColors.white,
//                 icon: Icon(CupertinoIcons.add),
//                 onPressed: () async {
//                   // if ((await Dio(BaseOptions(baseUrl: baseUrl, headers: {
//                   //       'Authorization': Token().refreshToken
//                   //     })).get("/user/status"))
//                   //         .data['data'][0]["user_status"] ==
//                   //     1) {
//                   //   await context.push('/write');
//                   //   state.started();
//                   // }
//                   if (true) {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext contexts) {
//                           return AlertDialog(
//                             title: Text("알림"),
//                             content: Text("학생증 인증이 필요합니다."),
//                             actions: [
//                               TextButton(
//                                   onPressed: () async {
//                                     await contexts.push("/schoolAuth");
//                                     contexts.pop();
//                                   },
//                                   child: Text("학생증 인증하기")),
//                               TextButton(
//                                   onPressed: () {
//                                     contexts.pop();
//                                   },
//                                   child: Text("취소")),
//                             ],
//                           );
//                         });
//                     return;
//                   }
//                   context.push('/write');
//                   state.started();
//                   // Navigator.of(context, rootNavigator: true).push(
//                   //     MaterialPageRoute(
//                   //         builder: (context) =>
//                   //         WriteScreen(token: token,)));
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
