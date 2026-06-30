import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A premium 3D-like Cube Loader with rotating cube effect using multiple faces.
/// Creates an illusion of a rotating cube with glowing edges and smooth animation.
class CubeLoader extends StatefulWidget {
  /// Size of the loader
  final double size;

  /// Primary color of the cube
  final Color color;

  /// Duration of one full rotation
  final Duration duration;

  /// Number of visible cube faces (recommended: 3 or 4)
  final int visibleFaces;

  /// Padding around the loader
  final EdgeInsetsGeometry padding;

  const CubeLoader({
    super.key,
    this.size = 56.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1400),
    this.visibleFaces = 3,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  State<CubeLoader> createState() => _CubeLoaderState();
}

class _CubeLoaderState extends State<CubeLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationX;
  late Animation<double> _rotationY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _rotationX = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _rotationY = Tween<double>(begin: 0, end: 2 * math.pi * 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
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
                painter: CubeLoaderPainter(
                  rotationX: _rotationX.value,
                  rotationY: _rotationY.value,
                  color: widget.color,
                  visibleFaces: widget.visibleFaces,
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

/// CustomPainter for Cube Loader
class CubeLoaderPainter extends CustomPainter {
  final double rotationX;
  final double rotationY;
  final Color color;
  final int visibleFaces;

  CubeLoaderPainter({
    required this.rotationX,
    required this.rotationY,
    required this.color,
    required this.visibleFaces,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final cubeSize = size.width * 0.55;
    final half = cubeSize / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    // Draw multiple cube faces with perspective simulation
    for (int i = 0; i < visibleFaces; i++) {
      final phase = i * 0.6;
      final opacity = (0.6 - (i * 0.15)).clamp(0.25, 1.0);

      final xOffset = math.sin(rotationY + phase) * 8;
      final yOffset = math.cos(rotationX + phase) * 6;

      final path = Path();

      // Front face
      path.moveTo(center.dx - half + xOffset, center.dy - half + yOffset);
      path.lineTo(center.dx + half + xOffset, center.dy - half + yOffset);
      path.lineTo(center.dx + half + xOffset * 0.7, center.dy + half + yOffset * 0.8);
      path.lineTo(center.dx - half + xOffset * 0.7, center.dy + half + yOffset * 0.8);
      path.close();

      paint.color = color.withOpacity(opacity);
      fillPaint.color = color.withOpacity(opacity * 0.12);

      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, paint);
    }

    // Draw glowing center dot
    final centerPaint = Paint()
      ..color = color.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 4.5, centerPaint);
  }

  @override
  bool shouldRepaint(CubeLoaderPainter oldDelegate) {
    return oldDelegate.rotationX != rotationX ||
        oldDelegate.rotationY != rotationY ||
        oldDelegate.color != color ||
        oldDelegate.visibleFaces != visibleFaces;
  }
}