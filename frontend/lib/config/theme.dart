import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color primaryAccent = const Color.fromRGBO(196, 178, 172, 1);
  static Color secondaryColor = const Color.fromRGBO(45, 45, 45, 1);
  static Color secondaryAccent = const Color.fromRGBO(35, 35, 35, 1);
  static Color textColor = const Color.fromRGBO(150, 150, 150, 1);
  static Color rating1 = const Color.fromRGBO(255, 0, 0, 1);
  static Color rating2 = const Color.fromRGBO(255, 75, 75, 1);
  static Color rating3 = const Color.fromRGBO(255, 125, 0, 1);
  static Color rating4 = const Color.fromRGBO(0, 200, 150, 1);
  static Color rating5 = const Color.fromRGBO(0, 255, 0, 1);
}

ThemeData primaryTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor
  ),

  // scaffold color
  scaffoldBackgroundColor: AppColors.secondaryAccent,

  // app bar theme colors
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secondaryColor,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    titleMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: AppColors.secondaryColor.withOpacity(0.5),
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: const RoundedRectangleBorder(),
    margin: const EdgeInsets.only(bottom: 16)
  ),

  // Input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.secondaryColor.withOpacity(0.5),
    border: InputBorder.none,
    labelStyle: TextStyle(color: AppColors.textColor),
    prefixIconColor: AppColors.textColor,
  ),

  // dialog theme
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.secondaryAccent,
    surfaceTintColor: Colors.transparent,
  ),
);