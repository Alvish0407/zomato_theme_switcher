import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double progress;

  WaveClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final path = Path();
    // Center Bottom of the screen
    final center = Offset(size.width / 2, size.height);
    // Pythagorean theorem (a² + b² = c²)
    // This ensures the circle will be large enough to cover the screen diagonally
    final maxRadius = math.sqrt(size.width * size.width + size.height * size.height);
    final currentRadius = maxRadius * progress;

    path.addOval(
      Rect.fromCenter(
        center: center,
        width: currentRadius * 2,
        height: currentRadius * 2,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}
