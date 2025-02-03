import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_theme_switcher/settings_screen.dart';

import 'theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final theme = themeProvider.themeData;

          return MaterialApp(
            title: 'Zomato Theme Switcher',
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: const SettingsScreen(),
          );
        },
      ),
    );
  }
}
