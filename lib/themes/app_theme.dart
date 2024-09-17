import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.amber,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme:  const TextTheme(
      titleLarge: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      )

    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    // Add more theme customizations here
  );
}
