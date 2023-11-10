import 'package:dio/dio.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';

Future<int> checkStatus() async {
  return (await Dio(BaseOptions(
              baseUrl: baseUrl,
              headers: {'Authorization': Token().refreshToken}))
          .get("/user/status"))
      .data['data'][0]["user_status"];
}
