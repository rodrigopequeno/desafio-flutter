import 'package:flutter/material.dart';

class ThemeDark {
  static final ThemeDark _singleton = ThemeDark._internal();

  factory ThemeDark() {
    return _singleton;
  }

  ThemeDark._internal();

  static const _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: Colors.white, width: 1),
  );

  static ThemeData get themeData {
    return ThemeData.dark().copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: _outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        enabledBorder: _outlineInputBorder,
        focusedBorder: _outlineInputBorder.copyWith(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
