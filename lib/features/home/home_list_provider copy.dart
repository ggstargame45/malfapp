// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:malf/features/home/home_list_model.dart';
// import 'package:dio/dio.dart';

// import 'package:malf/shared/logger.dart';
// import 'package:malf/shared/network/base_url.dart';
// import 'package:malf/shared/network/token.dart';

// const homeUrl = "$baseUrl/bulletin-board/posts";



// class HomeListProvider extends ChangeNotifier {
//   List<ListItemData> listItems = [];

//   int currentPageNo = 1;
//   bool isAdd = false;

//   Future<void> started() async {
//     currentPageNo = 1;
//     logger.e("started");
//     try {
//       await _getPhotos();
//     } catch (error) {
//       logger.e(error);
//     }
//   }

//   void scrollListerner(ScrollUpdateNotification notification) {
//     if (notification.metrics.maxScrollExtent * 0.85 <
//         notification.metrics.pixels) {
//       _morePhotos();
//     }
//   }

//   Future<void> _morePhotos() async {
//     if (!isAdd) {
//       isAdd = true;
//       notifyListeners();
//       List<ListItemData>? data = await _fetchPost(pageNo: currentPageNo);
//       Future.delayed(const Duration(milliseconds: 1000), () {
//         listItems.addAll(data);
//         currentPageNo = currentPageNo + 1;
//         isAdd = false;
//         notifyListeners();
//       });
//     }
//   }

//   Future<void> _getPhotos() async {
//     List<ListItemData>? data = await _fetchPost(pageNo: currentPageNo);
//     listItems = data;
//     currentPageNo = 2;
//     logger.e("sdfsdf: ${currentPageNo}");
//     notifyListeners();
//   }

//   Future<List<ListItemData>> _fetchPost({
//     required int pageNo
//   }) async {
//     logger.e("fetchPost");
//     final dio = Dio(BaseOptions(
//   baseUrl: homeUrl,
//   headers: {'Authorization': Token().refreshToken},
// ));
//     try {
//       logger.e(Token().refreshToken);
//       final response = await dio.get("/?page=$pageNo&limit=10");
//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data['data'];
//         logger.e("fetchPost3");
//         List<ListItemData> result =
//             data.map((e) => ListItemData.fromJson(e)).toList();
//         logger.e(result);
//         return result;
//       } else {
//         logger.e(response.statusCode);
//         return [];
//       }
//     } catch (error) {
//       logger.e(error);
//       return [];
//     }
//   }
// }