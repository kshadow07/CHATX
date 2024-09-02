import 'package:chtx/services/Theme/dark_mode.dart';
import 'package:chtx/services/Theme/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = LightMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  ///
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  ///
  void toggletheme() {
    if (_themeData == LightMode) {
      _themeData = darkMode;
      notifyListeners();
    } else {
      _themeData = LightMode;
      notifyListeners();
    }
  }
}
