import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_theme_switcher/theme_provider.dart';

import 'theme/wave_clipper.dart';

/// Call the callback to trigger the theme change animation.
///
/// ```dart
/// ThemeSwitcher(
///   builder: (context, notifyThemeChange) => ElevatedButton(
///     onPressed: () {
///       // call the method to change theme
///       notifyThemeChange();
///     },
///     child: const Text('Toggle Theme'),
///   ),
/// );
/// ```
typedef ThemeSwitcherBuilder = Widget Function(
  BuildContext context,
);

/// A widget that allows you to transition between the previous and current theme.
class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    super.key,
    required this.builder,
    this.curve = Curves.easeInOutCubic,
    this.duration = Durations.extralong2,
  });

  final Curve curve;
  final Duration duration;
  final ThemeSwitcherBuilder builder;

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> with SingleTickerProviderStateMixin {
  late final ThemeProvider themeProvider;

  late final Animation<double> _animation;
  late final AnimationController _controller;

  late ThemeData previousTheme;

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.addListener(_toggleTheme);

    previousTheme = themeProvider.themeData;

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _controller.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status.isCompleted) {
      setState(() {
        previousTheme = Theme.of(context);
      });
      _controller.reset();
    }
  }

  void _toggleTheme() {
    if (_controller.isAnimating) return;

    setState(() {
      previousTheme = Theme.of(context);
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
          data: previousTheme,
          child: Builder(builder: (ctx) {
            return widget.builder(ctx);
          }),
        ),
        //
        if (_controller.isAnimating)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipPath(
                clipper: WaveClipper(progress: _animation.value),
                child: widget.builder(context),
              );
            },
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    themeProvider.removeListener(_toggleTheme);
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();
  }
}
