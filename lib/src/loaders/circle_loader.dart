import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A premium animated circle loader inspired by high-quality designs like Apple's Activity Indicator.
/// 
/// Built from scratch using [CustomPainter], [AnimationController], and [Canvas] for optimal performance
/// and smooth 60 FPS animations. Features 10 animated dots with a leading larger dot, smooth scaling,
/// opacity transitions, and circular motion.
class CircleLoader extends StatefulWidget {
  /// The size of the loader.
  final double size;

  /// The primary color of the dots.
  final Color color;

  /// The duration of one complete animation cycle.
  final Duration duration;

  /// The number of dots in the circle.
  final int dotCount;

  /// The minimum radius for the smallest dots.
  final double minDotRadius;

  /// The maximum radius for the largest dot (the "head").
  final double maxDotRadius;

  /// Padding around the loader.
  final EdgeInsetsGeometry padding;

  /// Creates a new [CircleLoader].
  const CircleLoader({
    super.key,
    this.size = 56.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1200),
    this.dotCount = 10,
    this.minDotRadius = 2.0,
    this.maxDotRadius = 5.5,
    this.padding = const EdgeInsets.all(8.0),
  }) : assert(dotCount >= 4 && dotCount <= 16);

  @override
  State<CircleLoader> createState() => _CircleLoaderState();
}

class _CircleLoaderState extends State<CircleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
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
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: CircleLoaderPainter(
                  progress: _rotationAnimation.value,
                  scale: _scaleAnimation.value,
                  color: widget.color,
                  dotCount: widget.dotCount,
                  minDotRadius: widget.minDotRadius,
                  maxDotRadius: widget.maxDotRadius,
                ),
                size: Size(widget.size, widget.size),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the [CircleLoader] that draws animated dots in a circular pattern.
class CircleLoaderPainter extends CustomPainter {
  final double progress;
  final double scale;
  final Color color;
  final int dotCount;
  final double minDotRadius;
  final double maxDotRadius;

  CircleLoaderPainter({
    required this.progress,
    required this.scale,
    required this.color,
    required this.dotCount,
    required this.minDotRadius,
    required this.maxDotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.75;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * math.pi * i / dotCount) + (progress * 2 * math.pi);
      
      // The "head" dot is the brightest and largest, moving ahead
      final dotIndex = (i + (progress * dotCount).floor()) % dotCount;
      final positionFactor = dotIndex / dotCount;
      
      // Smooth scaling: larger at the "head"
      final baseScale = math.sin(positionFactor * math.pi * 2) * 0.5 + 0.5;
      final dotScale = 0.6 + baseScale * 0.4 * scale;
      
      final dotRadius = minDotRadius + 
          (maxDotRadius - minDotRadius) * dotScale;
      
      // Opacity: head is fully opaque, tail fades
      final opacity = 0.3 + (dotScale * 0.7);
      
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      paint.color = color.withOpacity(opacity.clamp(0.0, 1.0));
      
      canvas.drawCircle(
        Offset(x, y),
        dotRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CircleLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.scale != scale ||
           oldDelegate.color != color ||
           oldDelegate.dotCount != dotCount ||
           oldDelegate.minDotRadius != minDotRadius ||
           oldDelegate.maxDotRadius != maxDotRadius;
  }
}