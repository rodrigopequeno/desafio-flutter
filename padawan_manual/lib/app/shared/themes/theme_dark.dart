import 'package:flutter/material.dart';

class ThemeDark {
  static final ThemeDark _singleton = ThemeDark._internal();

  factory ThemeDark() {
    return _singleton;
  }

  ThemeDark._internal();

  static ThemeData get themeData {
    return ThemeData.dark();
  }
}
