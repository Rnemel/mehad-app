import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.lightPurple.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 80, color: AppColors.primaryPurple),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "This feature is coming soon!",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});
  @override
  Widget build(BuildContext context) => const PlaceholderScreen(title: "Alerts", icon: Icons.warning_amber_rounded);
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});
  @override
  Widget build(BuildContext context) => const PlaceholderScreen(title: "Reports", icon: Icons.bar_chart_rounded);
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) => const PlaceholderScreen(title: "History", icon: Icons.history);
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => const PlaceholderScreen(title: "Settings", icon: Icons.settings);
}
