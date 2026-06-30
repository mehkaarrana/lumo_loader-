import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium Dots Loader - Multiple dots moving in a circular path with trailing effect.
class DotsLoader extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final int dotCount;
  final double dotRadius;

  const DotsLoader({
    super.key,
    this.size = 56.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1100),
    this.dotCount = 8,
    this.dotRadius = 3.5,
  });

  @override
  State<DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<DotsLoader> with SingleTickerProviderStateMixin {
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
              painter: DotsLoaderPainter(
                progress: _controller.value,
                color: widget.color,
                dotCount: widget.dotCount,
                dotRadius: widget.dotRadius,
              ),
              size: Size(widget.size, widget.size),
            );
          },
        ),
      ),
    );
  }
}

class DotsLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int dotCount;
  final double dotRadius;

  DotsLoaderPainter({
    required this.progress,
    required this.color,
    required this.dotCount,
    required this.dotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.38;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * math.pi * i / dotCount) + (progress * 2 * math.pi * 1.5);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      final opacity = 0.3 + (0.7 * ((i + (progress * dotCount).floor()) % dotCount) / dotCount);

      paint.color = color.withOpacity(opacity.clamp(0.2, 1.0));

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(DotsLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.dotCount != dotCount;
  }
}