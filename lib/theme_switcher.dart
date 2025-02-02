import 'package:flutter/material.dart';

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
  VoidCallback notifyThemeChange,
);

/// A widget that allows you to transition between the previous and current theme.
class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    super.key,
    required this.builder,
    required this.themeData,
    this.curve = Curves.easeInOutCubic,
    this.duration = Durations.extralong2,
  });

  final Curve curve;
  final Duration duration;
  final ThemeData themeData;
  final ThemeSwitcherBuilder builder;

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> with SingleTickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _controller;

  late ThemeData previousTheme;

  @override
  void initState() {
    super.initState();
    previousTheme = widget.themeData;

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
        previousTheme = widget.themeData;
      });
      _controller.reset();
    }
  }

  void _toggleTheme() {
    if (_controller.isAnimating) return;

    setState(() {
      previousTheme = widget.themeData;
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
            return widget.builder(ctx, _toggleTheme);
          }),
        ),
        //
        if (_controller.isAnimating)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipPath(
                clipper: WaveClipper(progress: _animation.value),
                child: widget.builder(context, _toggleTheme),
              );
            },
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();
  }
}
