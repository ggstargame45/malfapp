import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:malf/features/home/home_list_model.dart';
import 'package:dio/dio.dart';

import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/usecases/block_handle.dart';

// const homeUrl = "$baseUrl";

class HomeListProvider {
  static Future<List<ListItemData>> getHomeList(int pageNo, int limit) async {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': Token().refreshToken},
    ));
    try {
      final response =
          await dio.get("/bulletin-board/posts/?page=$pageNo&limit=$limit");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<ListItemData> result = data
            .map((e) => ListItemData.fromJson(e))
            .where((element) =>
                (!BlockSet().blockUserUniqIdSet.contains(element.userUniqId)) &&
                (!BlockSet().blockMeetingPostIdSet.contains(element.postId)))
            .toList();
        logger.i("result: $result");
        return result;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
