import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  get lightTheme => ThemeData(
    textTheme: Typography.blackMountainView
        .merge(TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        height: 1.2,
        letterSpacing: 0.2,
        textBaseline: TextBaseline.alphabetic,
        fontStyle: FontStyle.normal,
        ),
      bodyText2: TextStyle(
        fontSize: 16,
        height: 1.2,
        letterSpacing: 0.2,
        textBaseline: TextBaseline.alphabetic,
        fontStyle: FontStyle.normal,
      ),
      ),
    ),
    backgroundColor: AppColors.background,
    scaffoldBackgroundColor: AppColors.background,
    primarySwatch: AppColors.primarySwatch,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackground),
        elevation: MaterialStateProperty.all<double>(5.0),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1.0,
          color: AppColors.buttonText,
        )),
      ),
    ),

    cardTheme: CardTheme(
      elevation: 3,
      color: AppColors.cardBackground,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
    ),

    canvasColor: AppColors.canvasBackground,
    brightness: Brightness.light,
  );
}
