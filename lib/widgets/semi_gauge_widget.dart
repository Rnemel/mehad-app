import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SemiGaugeWidget extends StatefulWidget {
  final double needleAngle; // in degrees, center is 0

  const SemiGaugeWidget({super.key, this.needleAngle = -10});

  @override
  State<SemiGaugeWidget> createState() => _SemiGaugeWidgetState();
}

class _SemiGaugeWidgetState extends State<SemiGaugeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -150, end: widget.needleAngle).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(SemiGaugeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.needleAngle != widget.needleAngle) {
       _animation = Tween<double>(begin: oldWidget.needleAngle, end: widget.needleAngle).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(310, 175),
          painter: SemiGaugePainter(needleAngle: _animation.value),
        );
      },
    );
  }
}

class SemiGaugePainter extends CustomPainter {
  final double needleAngle;

  SemiGaugePainter({required this.needleAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 20);
    const radius = 120.0;
    const strokeWidth = 55.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Segments: orange, yellow, olive/sage, green, purple
    final segments = [
      {'color': AppColors.gaugeRed, 'start': -150.0, 'end': -90.0},
      {'color': AppColors.gaugeOrange, 'start': -90.0, 'end': -30.0},
      {'color': AppColors.gaugeOlive, 'start': -30.0, 'end': 30.0},
      {'color': AppColors.gaugeGreen, 'start': 30.0, 'end': 90.0},
      {'color': AppColors.gaugePurple, 'start': 90.0, 'end': 150.0},
    ];

    for (var seg in segments) {
      paint.color = seg['color'] as Color;
      final startDegrees = seg['start'] as double;
      final endDegrees = seg['end'] as double;
      final startAngle = (startDegrees - 90) * math.pi / 180;
      final endAngle = (endDegrees - 90) * math.pi / 180;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }

    // Bottom cap (ellipse-like)
    final capPaint = Paint()..color = const Color(0xFF7338B2);
    canvas.drawOval(
      Rect.fromCenter(center: center.translate(0, 28), width: 260, height: 80),
      capPaint,
    );

    // Emoji faces (simulated)
    _drawFace(canvas, center, radius, -115, Colors.brown.withAlpha((0.5 * 255).round())); // Sad
    _drawFace(canvas, center, radius, 0, Colors.brown.withAlpha((0.5 * 255).round())); // Neutral
    _drawFace(canvas, center, radius, 115, Colors.green.withAlpha((0.5 * 255).round())); // Happy

    // Needle
    final needlePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final nRad = (needleAngle - 90) * math.pi / 180;
    const nLength = 90.0;
    final nTarget = center + Offset(math.cos(nRad) * nLength, math.sin(nRad) * nLength);
    canvas.drawLine(center, nTarget, needlePaint);

    // Center circle
    canvas.drawCircle(center, 8, capPaint);
    canvas.drawCircle(center, 8, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 2);
  }

  void _drawFace(Canvas canvas, Offset center, double radius, double angle, Color color) {
    final rad = (angle - 90) * math.pi / 180;
    final pos = center + Offset(math.cos(rad) * radius, math.sin(rad) * radius);
    
    final paint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2;
    
    // Simple face drawing
    canvas.drawCircle(pos + const Offset(-5, -4), 2, Paint()..color = color);
    canvas.drawCircle(pos + const Offset(5, -4), 2, Paint()..color = color);
    
    if (angle < 0) {
      // frown
      canvas.drawArc(Rect.fromCenter(center: pos + const Offset(0, 5), width: 10, height: 6), math.pi, math.pi, false, paint);
    } else if (angle > 0) {
      // smile
      canvas.drawArc(Rect.fromCenter(center: pos + const Offset(0, 2), width: 10, height: 6), 0, math.pi, false, paint);
    } else {
      // straight line
      canvas.drawLine(pos + const Offset(-5, 4), pos + const Offset(5, 4), paint);
    }
  }

  @override
  bool shouldRepaint(covariant SemiGaugePainter oldDelegate) => oldDelegate.needleAngle != needleAngle;
}
