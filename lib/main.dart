import 'package:flutter/material.dart';

import 'theme/wave_clipper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zomato Theme Switcher',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Color.fromRGBO(246, 247, 252, 1),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          surface: Color.fromRGBO(24, 23, 29, 1),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool isAnimating = false;
  bool currentTheme = false; // false for light, true for dark
  bool targetTheme = false; // Add this to track the target theme

  static const lightBg = Color.fromRGBO(246, 247, 252, 1);
  static const darkBg = Color.fromRGBO(24, 23, 29, 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        isAnimating = false;
        currentTheme = targetTheme;
      });
      _controller.reset();
    }
  }

  void _toggleTheme() {
    if (isAnimating) return;

    setState(() {
      isAnimating = true;
      targetTheme = !currentTheme;
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme ? darkBg : lightBg,
      body: Stack(
        children: [
          // Base layer with current theme
          _buildContent(currentTheme),

          // Animated layer with target theme
          if (isAnimating)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ClipPath(
                  clipper: WaveClipper(
                    progress: _animation.value,
                    waveHeight: 200,
                  ),
                  child: Container(
                    color: targetTheme ? darkBg : lightBg,
                    child: _buildContent(targetTheme),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();
    super.dispose();
  }

  Widget _buildContent(bool isDarkTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Current Theme: ${isDarkTheme ? "Dark" : "Light"}',
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkTheme ? Colors.white : Colors.black,
              foregroundColor: isDarkTheme ? Colors.black : Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _toggleTheme,
            child: Text(
              'Toggle Theme',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
