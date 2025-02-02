import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider({
    ThemeData? initialTheme,
  }) : _themeData = initialTheme ?? lightTheme;

  ThemeData get themeData => _themeData;

  bool get isLightTheme => _themeData.brightness == Brightness.light;

  static final lightTheme = ThemeData(
    primaryColor: Color.fromRGBO(58, 127, 74, 1),
    textTheme: TextTheme().merge(GoogleFonts.poppinsTextTheme()),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(244, 246, 250, 1),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(244, 246, 250, 1),
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      outline: Color.fromRGBO(231, 233, 239, 1),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Color.fromRGBO(58, 127, 74, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(24, 23, 29, 1),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(24, 23, 29, 1),
    colorScheme: ColorScheme.dark(
      outline: Color.fromRGBO(231, 233, 239, 1),
      surface: Color.fromRGBO(31, 32, 39, 1),
    ),
  );

  void toggleTheme() {
    _themeData = _themeData == lightTheme
        ? darkTheme //
        : lightTheme;
    notifyListeners();
  }
}
