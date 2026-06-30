import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Orbit Loader - A central dot with multiple orbiting particles (Premium feel).
class OrbitLoader extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final int orbitCount;

  const OrbitLoader({
    super.key,
    this.size = 56.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1300),
    this.orbitCount = 4,
  });

  @override
  State<OrbitLoader> createState() => _OrbitLoaderState();
}

class _OrbitLoaderState extends State<OrbitLoader> with SingleTickerProviderStateMixin {
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
              painter: OrbitLoaderPainter(
                progress: _controller.value,
                color: widget.color,
                orbitCount: widget.orbitCount,
              ),
              size: Size(widget.size, widget.size),
            );
          },
        ),
      ),
    );
  }
}

class OrbitLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int orbitCount;

  OrbitLoaderPainter({
    required this.progress,
    required this.color,
    required this.orbitCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.35;

    final centerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Central glowing dot
    canvas.drawCircle(center, 4.5, centerPaint);

    final orbitPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < orbitCount; i++) {
      final radius = baseRadius + (i * 6);
      final speedMultiplier = 1.0 + (i * 0.4);
      final angle = progress * 2 * math.pi * speedMultiplier + (i * math.pi / 2);

      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      final opacity = 0.6 - (i * 0.12);

      orbitPaint.color = color.withOpacity(opacity.clamp(0.3, 1.0));
      canvas.drawCircle(Offset(x, y), 3.2 - (i * 0.4), orbitPaint);
    }
  }

  @override
  bool shouldRepaint(OrbitLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.orbitCount != orbitCount;
  }
}