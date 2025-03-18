import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.secondaryLight,
    primaryColor: AppColors.primaryLight,
    textTheme: const TextTheme(
      displayMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.black,
        fixedSize: const Size(130, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(width: 2),
        textStyle: const TextStyle(fontSize: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        fixedSize: const Size(320, 70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 24),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 2),
        textStyle: const TextStyle(fontSize: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),
  );
}
