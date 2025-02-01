import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double progress;
  final double waveHeight;
  final bool isReversed;

  WaveClipper({
    required this.progress,
    this.waveHeight = 200,
    this.isReversed = false,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height);
    final maxRadius = math.sqrt(size.width * size.width + size.height * size.height);
    final currentRadius = maxRadius * progress;

    if (isReversed) {
      // For dark to light (top to bottom)
      path.addOval(
        Rect.fromCenter(
          center: Offset(size.width / 2, 0),
          width: currentRadius * 2,
          height: currentRadius * 2,
        ),
      );
    } else {
      // For light to dark (bottom to top)
      path.addOval(
        Rect.fromCenter(
          center: center,
          width: currentRadius * 2,
          height: currentRadius * 2,
        ),
      );
    }

    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}
