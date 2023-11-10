import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:malf/config/routes/app_route.dart';
import 'package:malf/shared/theme/app_theme.dart';

class MalfApp extends StatelessWidget {
  const MalfApp({super.key});

  //final themeMode = ThemeMode.system;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Malf Application',
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      
      // themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      

    );
  }
}
