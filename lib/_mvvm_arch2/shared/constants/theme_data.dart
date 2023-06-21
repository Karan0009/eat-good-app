import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static final ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    backgroundColor: Colors.black,
  );

  static final lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    backgroundColor: Colors.yellow,
  );
}
