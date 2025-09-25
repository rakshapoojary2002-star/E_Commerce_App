import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveBackground extends StatelessWidget {
  final AnimationController animation;
  const WaveBackground({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(animation.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 =
        Paint()
          ..color = const Color(0xff2c6a46).withOpacity(0.1)
          ..style = PaintingStyle.fill;

    final paint2 =
        Paint()
          ..color = const Color(0xff31628d).withOpacity(0.05)
          ..style = PaintingStyle.fill;

    final path1 = Path();
    final path2 = Path();

    double waveHeight1 = size.height * 0.04;
    double waveHeight2 = size.height * 0.03;

    path1.moveTo(0, size.height * 0.3);
    for (double x = 0; x <= size.width; x++) {
      double y =
          size.height * 0.3 +
          waveHeight1 *
              math.sin(
                (x / size.width * 2 * math.pi) + (animationValue * 2 * math.pi),
              );
      path1.lineTo(x, y);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    path2.moveTo(0, size.height * 0.7);
    for (double x = 0; x <= size.width; x++) {
      double y =
          size.height * 0.7 +
          waveHeight2 *
              math.sin(
                (x / size.width * 3 * math.pi) + (animationValue * 3 * math.pi),
              );
      path2.lineTo(x, y);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
