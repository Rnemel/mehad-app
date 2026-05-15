import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mehad/navigation/route_generator.dart';
import 'package:mehad/theme/app_colors.dart';
import 'package:mehad/widgets/semi_gauge_widget.dart';

class AnalyzingPage extends StatefulWidget {
  const AnalyzingPage({super.key});

  @override
  State<AnalyzingPage> createState() => _AnalyzingPageState();
}

class _AnalyzingPageState extends State<AnalyzingPage> {
  int _activeDot = 0;
  late Timer _dotTimer;
  late Timer _navTimer;

  @override
  void initState() {
    super.initState();
    
    // Dot animation
    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _activeDot = (_activeDot + 1) % 3;
        });
      }
    });

    // Navigation logic after 3.5 seconds
    _navTimer = Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        final results = ['low', 'medium', 'high'];
        final pick = results[math.Random().nextInt(results.length)];
        
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.result,
          arguments: pick,
        );
      }
    });
  }

  @override
  void dispose() {
    _dotTimer.cancel();
    _navTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Analyzing data...",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 40),
              
              const SemiGaugeWidget(needleAngle: 45), // Static angle during analysis
              
              const SizedBox(height: 40),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => _buildDot(index)),
              ),
              
              const SizedBox(height: 16),
              
              const Text(
                "Loading Prediction...",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    bool active = _activeDot == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: active ? AppColors.navy : AppColors.subGreyText.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      transform: active ? Matrix4.diagonal3Values(1.2, 1.2, 1.0) : Matrix4.identity(),
    );
  }
}
