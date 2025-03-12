import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade300,
        fixedSize: const Size(320, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Colțuri rotunjite
        ),
        textStyle: const TextStyle(color: Colors.black, fontSize: 24),
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
  );
}
