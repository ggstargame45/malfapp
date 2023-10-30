import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:isar/isar.dart';
import 'package:malf/config/routes/app_route.dart';
import 'package:malf/features/home/home_screen.dart';

import 'package:malf/main/malf.dart';
import 'package:malf/shared/collections/itoken.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

const version = "R1.0.0";

Future<void> main() async {
  bool versionCheck = false;
  bool serverCheck = false;
  WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([ITokenSchema], directory: dir.path);
  Token().tokenInit();
  final dioCheck = Dio(BaseOptions(
      baseUrl: checkUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    try {
      final response = await dioCheck.get('/version');
      if(response.data['version'] == version){
        versionCheck = true;
      }
      }
    catch (e) {
      
    }

    try {
      final response = await dioCheck.get('/server');
      if (response.data['status'] == 1) {
        serverCheck = true;
      }}
      catch (e) {
        
      }
    logger.d("versionCheck : $versionCheck");
    logger.d("serverCheck : $serverCheck");
    logger.d("refreshToken : ${Token().refreshToken}");

  if(versionCheck && serverCheck&& Token().refreshToken != ""){
    appRouter = appRouterMaker("/home");
  }
  else{
    appRouter = appRouterMaker("/login");
  }

  await EasyLocalization.ensureInitialized();
  
  FlutterNativeSplash.remove();
  
  runApp(
    EasyLocalization(
      supportedLocales: const [
        //english
        Locale('en'),
        //chinese
        Locale('zh'),
        //korean
        Locale('ko'),
        //japanese
        Locale('ja'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ko', 'KR'),
      child: const MalfApp(),
    ),
  );
}