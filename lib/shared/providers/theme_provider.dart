import 'package:flutter/material.dart';

import '../constants/theme_data.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeData.lightThemeData;

  ThemeData get currentTheme => _currentTheme;

  void _setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void setDarkTheme() {
    _setTheme(AppThemeData.darkThemeData);
  }

  void setLightTheme() {
    _setTheme(AppThemeData.lightThemeData);
  }
}
