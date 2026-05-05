import 'package:flutter/material.dart';
import 'package:mehad/navigation/route_generator.dart';
import 'package:mehad/theme/app_colors.dart';

class PredictConnectPage extends StatefulWidget {
  const PredictConnectPage({super.key});

  @override
  State<PredictConnectPage> createState() => _PredictConnectPageState();
}

class _PredictConnectPageState extends State<PredictConnectPage> {
  final TextEditingController _controller = TextEditingController();

  void _handleStart() {
    if (_controller.text.trim().isEmpty) {
      Navigator.pushNamed(context, AppRoutes.error, arguments: 'invalid');
      return;
    }
    
    Navigator.pushNamed(context, AppRoutes.analyzing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryPurple, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "AI Health Monitor",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Stay ahead with smart health prediction",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 50),
              
              const Text(
                "Connect Smartwatch",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).round()),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Enter watch data...",
                    hintStyle: TextStyle(color: AppColors.subGreyText),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Ensure smartwatch is connected",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.subGreyText,
                ),
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Start Prediction",
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
}
