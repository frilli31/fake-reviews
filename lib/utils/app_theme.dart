import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  get darkTheme => ThemeData(
    primarySwatch: Colors.grey,
    appBarTheme: AppBarTheme(
        brightness: Brightness.dark, color: AppColors.textBlack),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textGrey),
      labelStyle: TextStyle(color: AppColors.white),
    ),
    brightness: Brightness.dark,
    canvasColor: AppColors.lightGreyDarkMode,
    accentColor: AppColors.darkPink,
    accentIconTheme: IconThemeData(color: Colors.white),
  );

  get lightTheme => ThemeData(
    textTheme: Typography.blackMountainView
        .merge(TextTheme(
      bodyText1: TextStyle(
        fontSize: 16,
        height: 1.2,
        letterSpacing: 0.2,
        textBaseline: TextBaseline.alphabetic,
        fontStyle: FontStyle.normal,
        ),
      ),
    ),
    scaffoldBackgroundColor: Colors.deepOrange[50],
    primaryColor: Colors.deepOrange[800],
    accentColor: Colors.cyan[600],
    primarySwatch: Colors.deepPurple,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        elevation: MaterialStateProperty.all<double>(5.0),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        )),
      ),
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: AppColors.grey2,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textGrey),
      labelStyle: TextStyle(color: AppColors.white),
    ),
    canvasColor: AppColors.white,
    brightness: Brightness.light,
    accentIconTheme: IconThemeData(color: Colors.black),
  );
}
