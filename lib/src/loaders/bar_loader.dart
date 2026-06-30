import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A premium animated Bar Loader with multiple vertical bars that animate
/// with wave-like motion, height variation, and smooth opacity transitions.
///
/// Perfect for modern UIs. Built with [CustomPainter] for maximum performance.
class BarLoader extends StatefulWidget {
  /// The width of the entire loader.
  final double width;

  /// The height of the entire loader.
  final double height;

  /// The primary color of the bars.
  final Color color;

  /// Duration of one complete animation cycle.
  final Duration duration;

  /// Number of bars.
  final int barCount;

  /// Minimum height of bars (as fraction of total height).
  final double minHeightFactor;

  /// Maximum height of bars (as fraction of total height).
  final double maxHeightFactor;

  /// Space between bars.
  final double spacing;

  /// Padding around the loader.
  final EdgeInsetsGeometry padding;

  const BarLoader({
    super.key,
    this.width = 56.0,
    this.height = 48.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 900),
    this.barCount = 5,
    this.minHeightFactor = 0.3,
    this.maxHeightFactor = 1.0,
    this.spacing = 6.0,
    this.padding = const EdgeInsets.all(8.0),
  }) : assert(barCount >= 3 && barCount <= 12);

  @override
  State<BarLoader> createState() => _BarLoaderState();
}

class _BarLoaderState extends State<BarLoader> with SingleTickerProviderStateMixin {
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
    return Padding(
      padding: widget.padding,
      child: RepaintBoundary(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: BarLoaderPainter(
                  progress: _controller.value,
                  color: widget.color,
                  barCount: widget.barCount,
                  minHeightFactor: widget.minHeightFactor,
                  maxHeightFactor: widget.maxHeightFactor,
                  spacing: widget.spacing,
                ),
                size: Size(widget.width, widget.height),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Custom painter for [BarLoader]
class BarLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int barCount;
  final double minHeightFactor;
  final double maxHeightFactor;
  final double spacing;

  BarLoaderPainter({
    required this.progress,
    required this.color,
    required this.barCount,
    required this.minHeightFactor,
    required this.maxHeightFactor,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = (size.width - (spacing * (barCount - 1))) / barCount;
    final centerY = size.height / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (int i = 0; i < barCount; i++) {
      // Create wave effect with phase offset
      final phase = (i * 0.6) + (progress * 2 * math.pi);
      final heightFactor = minHeightFactor +
          (maxHeightFactor - minHeightFactor) *
              (math.sin(phase) * 0.5 + 0.5);

      final barHeight = size.height * heightFactor;

      final x = i * (barWidth + spacing);

      // Rounded rectangle for each bar
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(x + barWidth / 2, centerY),
          width: barWidth,
          height: barHeight,
        ),
        const Radius.circular(4.0),
      );

      // Dynamic opacity - bars at peak are brighter
      final opacity = 0.4 + (heightFactor * 0.6);
      paint.color = color.withOpacity(opacity.clamp(0.0, 1.0));

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(BarLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.barCount != barCount ||
        oldDelegate.minHeightFactor != minHeightFactor ||
        oldDelegate.maxHeightFactor != maxHeightFactor ||
        oldDelegate.spacing != spacing;
  }
}