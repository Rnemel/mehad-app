import 'package:flutter/material.dart';
import 'package:mehad/navigation/route_generator.dart';
import 'package:mehad/theme/app_colors.dart';
import 'package:mehad/widgets/donut_chart_widget.dart';

class ResultPage extends StatelessWidget {
  final String riskLevel;

  const ResultPage({super.key, required this.riskLevel});

  @override
  Widget build(BuildContext context) {
    final info = _getRiskInfo(riskLevel);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName(AppRoutes.dashboard)),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.navy, size: 16),
          label: const Text("Back", style: TextStyle(color: AppColors.navy, fontSize: 16)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              DonutChartWidget(riskLevel: riskLevel),
              
              const SizedBox(height: 50),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  info,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: AppColors.navy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.predictConnect);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Retry Prediction",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  String _getRiskInfo(String level) {
    switch (level.toLowerCase()) {
      case 'medium':
        return "There are some signs that warrant attention. It's best to monitor your condition and avoid excessive stress.";
      case 'high':
        return "A seizure is possible soon. Please take necessary precautions and contact a trusted person if needed.";
      case 'low':
      default:
        return "There are no strong indications of a seizure at this time. Continue your normal daily activities.";
    }
  }
}
