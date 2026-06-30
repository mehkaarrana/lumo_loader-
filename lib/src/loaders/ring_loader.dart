import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Beautiful Ring Loader with rotating gradient ring and inner pulse.
class RingLoader extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final double strokeWidth;

  const RingLoader({
    super.key,
    this.size = 64.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1200),
    this.strokeWidth = 6.0,
  });

  @override
  State<RingLoader> createState() => _RingLoaderState();
}

class _RingLoaderState extends State<RingLoader> with SingleTickerProviderStateMixin {
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
              painter: RingLoaderPainter(
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

class RingLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  RingLoaderPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;

    // Outer rotating ring
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final gradient = SweepGradient(
      center: Alignment.center,
      startAngle: progress * math.pi * 2,
      endAngle: progress * math.pi * 2 + math.pi * 1.8,
      colors: [
        Colors.transparent,
        color.withOpacity(0.2),
        color.withOpacity(0.9),
        color.withOpacity(1.0),
        color.withOpacity(0.6),
      ],
      stops: const [0.0, 0.2, 0.5, 0.75, 1.0],
    );

    paint.shader = gradient.createShader(
      Rect.fromCircle(center: center, radius: radius),
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      math.pi * 2,
      false,
      paint,
    );

    // Inner subtle ring
    final innerPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.6;

    canvas.drawCircle(center, radius * 0.75, innerPaint);

    // Center dot
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 5.5, dotPaint);
  }

  @override
  bool shouldRepaint(RingLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}