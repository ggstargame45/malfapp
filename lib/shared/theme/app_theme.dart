import 'package:flutter/material.dart';

import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/theme/test_styles.dart';
import 'package:malf/shared/theme/text_theme.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppTextStyles.fontFamily,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.lightGrey,
          error: AppColors.error,
          background: AppColors.black,
        ),
        // backgroundColor: AppColors.black,
        scaffoldBackgroundColor: AppColors.black,
        textTheme: TextThemes.darkTextTheme,
        primaryTextTheme: TextThemes.primaryTextTheme,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.black,
          titleTextStyle: AppTextStyles.h2,
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppTextStyles.bodyLg.copyWith(color: AppColors.primary);
            }
            return AppTextStyles.bodyLg.copyWith(color: AppColors.lightGrey);
          }),
        ));
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.lightGrey,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.white,
        actionsIconTheme: IconThemeData(
          color: AppColors.black,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 240, 243, 248),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        iconSize: 34
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 60,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppTextStyles.bodyLg.copyWith(color: AppColors.primary,fontSize: 13);
          }
          return AppTextStyles.bodyLg.copyWith(color: AppColors.lightGrey,fontSize: 13);
        }),
      ),
    );
  }
}
