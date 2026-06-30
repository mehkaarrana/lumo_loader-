import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium Pulse Loader - Expanding and contracting rings with glowing effect.
class PulseLoader extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;

  const PulseLoader({
    super.key,
    this.size = 72.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1400),
  });

  @override
  State<PulseLoader> createState() => _PulseLoaderState();
}

class _PulseLoaderState extends State<PulseLoader> with SingleTickerProviderStateMixin {
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
              painter: PulseLoaderPainter(
                progress: _controller.value,
                color: widget.color,
              ),
              size: Size(widget.size, widget.size),
            );
          },
        ),
      ),
    );
  }
}

class PulseLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;

  PulseLoaderPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width * 0.45;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..isAntiAlias = true;

    for (int i = 0; i < 3; i++) {
      final phase = progress + (i * 0.33);
      final normalized = math.sin(phase * math.pi * 2) * 0.5 + 0.5;

      final radius = 12 + (maxRadius - 12) * normalized;
      final opacity = (1.0 - normalized * 0.7).clamp(0.1, 1.0);
      final strokeWidth = 6.0 - (i * 1.5);

      paint.color = color.withOpacity(opacity);
      paint.strokeWidth = strokeWidth;

      canvas.drawCircle(center, radius, paint);
    }

    // Central glowing core
    final corePaint = Paint()
      ..color = color.withOpacity(0.95)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 7, corePaint);
  }

  @override
  bool shouldRepaint(PulseLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}