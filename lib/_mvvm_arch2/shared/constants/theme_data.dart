import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  AppThemeData._();

  static final ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
      size: 10,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Colors.white,
        ),
        fontWeight: FontWeight.w300,
      ),
      labelSmall: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Color.fromRGBO(152, 162, 179, 1),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    backgroundColor: Colors.black,
  );

  static final lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        fontWeight: FontWeight.w300,
      ),
      labelSmall: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Color.fromRGBO(52, 64, 84, 1),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    backgroundColor: Colors.white,
  );
}
