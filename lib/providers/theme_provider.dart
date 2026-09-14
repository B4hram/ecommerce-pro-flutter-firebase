
// import 'package:flutter/material.dart';

// class ThemeProvider extends ChangeNotifier {
//   bool isDark = false;

//   void toggleTheme() {
//     isDark = !isDark;
//     notifyListeners();
//   }
// }
 import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode =>
      _themeMode == ThemeMode.dark;

  // =========================================================
  // TOGGLE DARK / LIGHT MODE
  // =========================================================

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }

    notifyListeners();
  }

  // =========================================================
  // SET DARK MODE
  // =========================================================

  void setDarkMode(bool enabled) {
    _themeMode =
        enabled ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }
}