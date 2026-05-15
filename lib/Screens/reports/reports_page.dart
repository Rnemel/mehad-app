import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:mehad/theme/app_colors.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Health Insights", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ChartCard(title: "Heart Rate Trends", subtitle: "Avg 74 bpm"),
            const SizedBox(height: 20),
            const _StatGrid(),
            const SizedBox(height: 20),
            const _ChartCard(title: "Sleep Consistency", subtitle: "8.2h avg sleep", isBarChart: true),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isBarChart;

  const _ChartCard({required this.title, required this.subtitle, this.isBarChart = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.primaryPurple, fontWeight: FontWeight.w600)),
                ],
              ),
              const Icon(Icons.more_horiz, color: AppColors.greyText),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: CustomPaint(
              painter: isBarChart ? _BarChartPainter() : _LineChartPainter(),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text("Mon", style: TextStyle(fontSize: 10, color: AppColors.greyText)),
                Text("Tue", style: TextStyle(fontSize: 10, color: AppColors.greyText)),
                Text("Wed", style: TextStyle(fontSize: 10, color: AppColors.greyText)),
                Text("Thu", style: TextStyle(fontSize: 10, color: AppColors.greyText)),
                Text("Fri", style: TextStyle(fontSize: 10, color: AppColors.greyText)),
                Text("Sat", style: TextStyle(fontSize: 10, color: AppColors.greyText)),
                Text("Sun", style: TextStyle(fontSize: 10, color: AppColors.greyText)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryPurple
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
       ..shader = LinearGradient(
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
         colors: [AppColors.primaryPurple.withOpacity(0.2), Colors.transparent],
       ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    final path = Path();
    final fillPath = Path();

    final points = [0.6, 0.4, 0.7, 0.5, 0.8, 0.6, 0.75];
    final dx = size.width / (points.length - 1);

    path.moveTo(0, size.height * (1 - points[0]));
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, size.height * (1 - points[0]));

    for (var i = 1; i < points.length; i++) {
      path.lineTo(dx * i, size.height * (1 - points[i]));
      fillPath.lineTo(dx * i, size.height * (1 - points[i]));
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw points
    final dotPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final dotOuterPaint = Paint()..color = AppColors.primaryPurple..style = PaintingStyle.stroke..strokeWidth = 2;
    for (var i = 0; i < points.length; i++) {
        final pos = Offset(dx * i, size.height * (1 - points[i]));
        canvas.drawCircle(pos, 4, dotPaint);
        canvas.drawCircle(pos, 4, dotOuterPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.primaryPurple.withOpacity(0.15)..style = PaintingStyle.fill;
    final activePaint = Paint()..color = AppColors.primaryPurple..style = PaintingStyle.fill;

    final values = [0.7, 0.8, 0.6, 0.9, 0.75, 0.5, 0.85];
    final spacing = size.width / 14;
    final barWidth = size.width / 10;

    for (var i = 0; i < values.length; i++) {
      final left = (barWidth + spacing) * i + spacing;
      final top = size.height * (1 - values[i]);
      final rect = RRect.fromRectAndRadius(Rect.fromLTRB(left, top, left + barWidth, size.height), const Radius.circular(6));
      canvas.drawRRect(rect, i == 3 ? activePaint : paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _StatGrid extends StatelessWidget {
  const _StatGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: const [
        _StatTile(label: "Deep Sleep", value: "3.2h", color: Colors.indigo),
        _StatTile(label: "Calories", value: "1,240", color: Colors.orange),
        _StatTile(label: "Steps", value: "8,432", color: Colors.teal),
        _StatTile(label: "Water", value: "1.8L", color: Colors.blue),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatTile({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.black.withOpacity(0.02))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.greyText)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
