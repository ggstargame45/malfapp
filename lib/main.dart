import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:isar/isar.dart';

import 'package:malf/main/malf.dart';
import 'package:malf/shared/collections/iblockmeeting.dart';
import 'package:malf/shared/collections/iblockuser.dart';
import 'package:malf/shared/collections/ichat.dart';
import 'package:malf/shared/collections/imeetinglist.dart';
import 'package:malf/shared/collections/itoken.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/usecases/block_handle.dart';
import 'package:path_provider/path_provider.dart';

const version = "R1.0.0";

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open([ITokenSchema,IBlockMeetingSchema,IBlockUserSchema,IMeetingListSchema,IChatSchema], directory: dir.path);
    Token().tokenInit();
    BlockSet().setInit();

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
