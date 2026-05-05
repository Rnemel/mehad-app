import 'package:flutter/material.dart';
import 'package:mehad/navigation/route_generator.dart';
import 'package:mehad/theme/app_colors.dart';
import 'package:mehad/widgets/map_pin_widget.dart';

class ErrorPage extends StatelessWidget {
  final String variant; // 'invalid', 'no-result'

  const ErrorPage({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    bool isInvalid = variant == 'invalid';

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.navy, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isInvalid ? "Invalid Input" : "No Result",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 40),
              
              MapPinWidget(variant: isInvalid ? 'warning' : 'error'),
              
              const SizedBox(height: 40),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).round()),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      isInvalid ? "Smartwatch not connected" : "Not enough data available",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isInvalid ? "Please retry." : "Please ensure your smartwatch is connected.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: AppColors.greyText),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 60),
              
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
                  child: Text(
                    isInvalid ? "Retry Connection" : "Start Prediction",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
