import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class AppTheme {
  static OutlineInputBorder _border({Color color = Colors.black}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 3),
      );
  static TextStyle _styleText() =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

  static ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.espresso,
    fontFamily: GoogleFonts.jost().fontFamily,
  ).copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(130, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: _styleText(),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 2),
        textStyle: _styleText(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: _styleText(),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border().copyWith(
        borderSide: const BorderSide(color: AppColors.accentLight, width: 3),
      ),
      errorBorder: _border().copyWith(
        borderSide: const BorderSide(color: AppColors.errorLight, width: 3),
      ),
    ),
  );

  //? TODO - de completat ulterior si thema pt dark
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
