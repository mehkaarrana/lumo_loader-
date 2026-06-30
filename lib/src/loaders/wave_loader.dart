import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Beautiful Wave Loader - Flowing wave animation with multiple bars.
class WaveLoader extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final int barCount;

  const WaveLoader({
    super.key,
    this.size = 64.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1000),
    this.barCount = 6,
  });

  @override
  State<WaveLoader> createState() => _WaveLoaderState();
}

class _WaveLoaderState extends State<WaveLoader> with SingleTickerProviderStateMixin {
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
              painter: WaveLoaderPainter(
                progress: _controller.value,
                color: widget.color,
                barCount: widget.barCount,
              ),
              size: Size(widget.size, widget.size),
            );
          },
        ),
      ),
    );
  }
}

class WaveLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int barCount;

  WaveLoaderPainter({
    required this.progress,
    required this.color,
    required this.barCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (barCount * 2.2);
    final spacing = barWidth * 0.8;
    final maxHeight = size.height * 0.65;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (int i = 0; i < barCount; i++) {
      final delay = i * 0.15;
      final wave = math.sin((progress * math.pi * 2) + delay) * 0.5 + 0.5;

      final height = maxHeight * (0.4 + wave * 0.6);
      final x = (i * (barWidth + spacing)) + (size.width - (barCount * (barWidth + spacing))) / 2;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          x,
          (size.height - height) / 2,
          barWidth,
          height,
        ),
        const Radius.circular(8),
      );

      final opacity = 0.5 + (wave * 0.5);
      paint.color = color.withOpacity(opacity.clamp(0.4, 1.0));

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(WaveLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.barCount != barCount;
  }
}