import 'dart:math' as math;
import 'package:flutter/material.dart';

class DonutChartWidget extends StatefulWidget {
  final String riskLevel;

  const DonutChartWidget({super.key, this.riskLevel = 'low'});

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _getRiskConfig(widget.riskLevel);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(220, 220),
              painter: _DonutChartPainter(
                segments: config.segments,
                animationValue: _controller.value,
              ),
            );
          },
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              config.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6F6A75),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${config.percentage}%",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: config.textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _RiskConfig _getRiskConfig(String level) {
    switch (level.toLowerCase()) {
      case 'medium':
        return _RiskConfig(
          label: 'Medium Risk',
          percentage: 54,
          textColor: const Color(0xFFFF9800),
          segments: [
            _SegConfig(color: const Color(0xFF4CAF50), pct: 0.25),
            _SegConfig(color: const Color(0xFF8BC34A), pct: 0.20),
            _SegConfig(color: const Color(0xFFFF9800), pct: 0.30),
            _SegConfig(color: const Color(0xFFFB8C00), pct: 0.25),
          ],
        );
      case 'high':
        return _RiskConfig(
          label: 'High Risk',
          percentage: 85,
          textColor: const Color(0xFFD4000F),
          segments: [
            _SegConfig(color: const Color(0xFF4CAF50), pct: 0.15),
            _SegConfig(color: const Color(0xFF8BC34A), pct: 0.15),
            _SegConfig(color: const Color(0xFFFF9800), pct: 0.25),
            _SegConfig(color: const Color(0xFFEF5350), pct: 0.20),
            _SegConfig(color: const Color(0xFFD4000F), pct: 0.25),
          ],
        );
      case 'low':
      default:
        return _RiskConfig(
          label: 'Low Risk',
          percentage: 15,
          textColor: const Color(0xFF4CAF50),
          segments: [
            _SegConfig(color: const Color(0xFF4CAF50), pct: 0.35),
            _SegConfig(color: const Color(0xFF81C784), pct: 0.30),
            _SegConfig(color: const Color(0xFFA5D6A7), pct: 0.20),
            _SegConfig(color: const Color(0xFFC8E6C9), pct: 0.15),
          ],
        );
    }
  }
}

class _RiskConfig {
  final String label;
  final int percentage;
  final Color textColor;
  final List<_SegConfig> segments;
  _RiskConfig({required this.label, required this.percentage, required this.textColor, required this.segments});
}

class _SegConfig {
  final Color color;
  final double pct;
  _SegConfig({required this.color, required this.pct});
}

class _DonutChartPainter extends CustomPainter {
  final List<_SegConfig> segments;
  final double animationValue;

  _DonutChartPainter({required this.segments, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 82.0;
    const strokeWidth = 22.0;
    const gap = 3.0; // degrees
    const totalAngle = 320.0;
    const startAngleBase = -160.0;

    final bgPaint = Paint()
      ..color = const Color(0xFFF0F0F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);

    double cumulativeAngle = 0;
    for (int i = 0; i < segments.length; i++) {
        final seg = segments[i];
        final segAngle = seg.pct * totalAngle * animationValue;
        
        final paint = Paint()
          ..color = seg.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

        final start = (startAngleBase + cumulativeAngle + (i == 0 ? 0 : gap / 2)) * math.pi / 180;
        final sweep = (segAngle - (i == segments.length - 1 ? 0 : gap)) * math.pi / 180;
        
        if (sweep > 0) {
          canvas.drawArc(
            Rect.fromCircle(center: center, radius: radius),
            start,
            sweep,
            false,
            paint,
          );
        }
        cumulativeAngle += seg.pct * totalAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) => oldDelegate.animationValue != animationValue;
}
