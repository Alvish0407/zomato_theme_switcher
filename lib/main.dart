import 'package:flutter/material.dart';

import 'theme_switcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Color.fromRGBO(246, 247, 252, 1),
    ),
  );

  final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      surface: Color.fromRGBO(24, 23, 29, 1),
    ),
  );

  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    themeData = lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zomato Theme Switcher',
      theme: themeData,
      home: MyHomePage(
        themeData: themeData,
        onThemeChanged: () {
          setState(() {
            if (themeData == darkTheme) {
              themeData = lightTheme;
            } else {
              themeData = darkTheme;
            }
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.themeData,
    required this.onThemeChanged,
  });

  final ThemeData themeData;
  final VoidCallback onThemeChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      themeData: widget.themeData,
      builder: (context, changeTheme) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Theme: ${isDark ? "Dark" : "Light"}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    widget.onThemeChanged();
                    changeTheme();
                  },
                  child: Text(
                    'Toggle Theme',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
