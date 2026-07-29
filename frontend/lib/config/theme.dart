import 'package:flutter/material.dart';

class AppColors {
  static const Color scaffoldBackground = Color(0xFF1E1E1E);
  static const Color cardSurface = Color(0xFF2C2C2C);
  static const Color appBarBackground = Color(0xFF121212);

  static const Color primaryAccent = Color(0xFFD7CCC8);
  static const Color secondaryAccent = Color(0xFFB0BEC5);

  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF8D6E63);

  static const Color rating1 = Color(0xFFEF5350);
  static const Color rating2 = Color(0xFFFF7043);
  static const Color rating3 = Color(0xFFFFB74D);
  static const Color rating4 = Color(0xFF66BB6A);
  static const Color rating5 = Color(0xFF26A69A);
}

ThemeData primaryTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryAccent,
    secondary: AppColors.secondaryAccent,
    surface: AppColors.cardSurface,
    background: AppColors.scaffoldBackground,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimary,
  ),

  // scaffold color
  scaffoldBackgroundColor: AppColors.scaffoldBackground,

  // app bar theme colors
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.appBarBackground,
    foregroundColor: AppColors.textPrimary,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
  ),

    textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    titleMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: AppColors.cardSurface,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black45,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.white.withOpacity(0.08)),
    ),
    margin: const EdgeInsets.only(bottom: 16)
  ),

  // Input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.cardSurface,
    hintStyle: const TextStyle(color: AppColors.textSecondary),
    labelStyle: const TextStyle(color: AppColors.textSecondary),
    prefixIconColor: AppColors.primaryAccent,
    suffixIconColor: AppColors.primaryAccent,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primaryAccent, width: 1.5),
    ),
  ),

  // dialog theme
  dialogTheme: const DialogThemeData(
    backgroundColor: AppColors.cardSurface,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 15,
    ),
  ),
);

