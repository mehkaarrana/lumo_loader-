import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium Spinner Loader - Elegant rotating arc with smooth trailing effect.
class SpinnerLoader extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final double strokeWidth;

  const SpinnerLoader({
    super.key,
    this.size = 56.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 900),
    this.strokeWidth = 5.5,
  });

  @override
  State<SpinnerLoader> createState() => _SpinnerLoaderState();
}

class _SpinnerLoaderState extends State<SpinnerLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: SpinnerLoaderPainter(
                progress: _controller.value,
                color: widget.color,
                strokeWidth: widget.strokeWidth,
              ),
              size: Size(widget.size, widget.size),
            );
          },
        ),
      ),
    );
  }
}

class SpinnerLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  SpinnerLoaderPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    // Main spinning arc
    paint.color = color.withOpacity(0.9);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      progress * math.pi * 2,
      math.pi * 1.7,
      false,
      paint,
    );

    // Secondary lighter arc for depth
    paint.color = color.withOpacity(0.3);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      (progress * math.pi * 2) + math.pi * 0.8,
      math.pi * 1.2,
      false,
      paint,
    );

    // Center dot
    final centerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 3.5, centerPaint);
  }

  @override
  bool shouldRepaint(SpinnerLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}