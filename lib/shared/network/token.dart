import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:malf/shared/collections/itoken.dart';
import 'package:malf/shared/logger.dart';

import 'package:jwt_decode/jwt_decode.dart';

class Token{
  static final Token _singletonModel = Token._internal();
  String refreshToken = "";
  String accessToken = "";
  String userUniqId = "";
  factory Token() => _singletonModel;
  Token._internal();

  void tokenInit() async {
    final isar = Isar.getInstance();
    final token = await isar!.iTokens.get(1);
    if (token != null) {
      refreshToken = token.refreshToken;
      accessToken = token.accessToken;
      userUniqId = token.userUniqId;
    }
    else{
      logger.e("token is null");
    }

  }

  Future<void> setToken(String refreshToken, String accessToken) async {
    this.refreshToken = refreshToken;
    this.accessToken = accessToken;
    userUniqId = Jwt.parseJwt(refreshToken)['user_uniq_id'];

    final isar = Isar.getInstance();
    final token = IToken();
    token.id = 1;
    token.refreshToken = refreshToken;
    token.accessToken = accessToken;
    token.userUniqId = userUniqId;
    await isar!.writeTxn(() async {
      await isar.iTokens.put(token);
    });
  }

  Future<void> deleteToken() async {
    final isar = Isar.getInstance();
    await isar!.writeTxn(() async {
      await isar.iTokens.clear();
    });
  }
  
  void setRefreshToken(String token){
    refreshToken = token;
  }

  // Future<void> tokenRefresh() async {
  //   final dio = Dio();
  //   final response = await dio.post(
  //     'https://api.malf.co.kr/auth/refresh',
  //     data: {
  //       "refreshToken": refreshToken,
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final decodedToken = Jwt.parseJwt(response.data['accessToken']);
  //     final isar = Isar.getInstance();
  //     final token = await isar!.iTokens.get(1);
  //     if (token != null) {
  //       token.accessToken = response.data['accessToken'];
  //       token.refreshToken = response.data['refreshToken'];
  //       token.userUniqId = decodedToken['userUniqId'];
  //       await isar.iTokens.put(token);
  //       tokenInit();
  //     }
  //   }
  // }

}


bool tokenCheck(){
  if(Token().refreshToken == ""){
    return false;
  }else{
    return true;
  }
}

