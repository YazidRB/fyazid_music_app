import 'package:flutter/material.dart';
import 'package:music_app/themes/dark_mode.dart';
import 'package:music_app/themes/light_mode.dart';

class ThemProvider with ChangeNotifier {
  // initialy light mode
  ThemeData _themeData = lightMode;

  //get the theme
  ThemeData get themeData => _themeData;

  bool get isDark => themeData == dark_mode;

  //set the new theme
  set themeData(ThemeData themeDate) {
    _themeData = themeDate;

    //update UI
    notifyListeners();
  }

  //change the theme function
  toggleTheme() {
    isDark ? themeData = lightMode : themeData = dark_mode;
  }
}
