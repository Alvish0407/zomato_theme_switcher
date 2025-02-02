import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme_provider.dart';
import 'theme_switcher.dart';

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
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Theme: ${isDarkMode ? "Dark" : "Light"}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: themeProvider.toggleTheme,
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
