import 'package:communication/Themes/themes.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //  variables and instances
  ThemeData _themeData = lightMode;
  //  getters
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  //  methods
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
  }
}
