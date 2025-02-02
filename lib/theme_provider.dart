import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider({
    ThemeData? initialTheme,
  }) : _themeData = initialTheme ?? lightTheme;

  ThemeData get themeData => _themeData;

  bool get isLightTheme => _themeData.brightness == Brightness.light;

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Color.fromRGBO(246, 247, 252, 1),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      surface: Color.fromRGBO(24, 23, 29, 1),
    ),
  );

  void toggleTheme() {
    _themeData = _themeData == lightTheme
        ? darkTheme //
        : lightTheme;
    notifyListeners();
  }
}
