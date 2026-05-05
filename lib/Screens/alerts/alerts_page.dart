import 'package:flutter/material.dart';
import 'package:mehad/theme/app_colors.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Recent Alerts", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: 5,
        itemBuilder: (context, index) {
          final types = ["Emergency", "Warning", "Info", "Warning", "Info"];
          final titles = ["Seizure Risk Detected", "Irregular Heart Rhythm", "Sync Completed", "Low Battery", "Weekly Report Ready"];
          final times = ["2m ago", "1h ago", "5h ago", "1d ago", "2d ago"];
          final colors = [Colors.red, Colors.orange, Colors.green, Colors.orange, Colors.blue];
          final icons = [Icons.warning_rounded, Icons.monitor_heart, Icons.check_circle, Icons.battery_alert, Icons.description];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha((0.02 * 255).round()), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: colors[index].withAlpha((0.1 * 255).round()), shape: BoxShape.circle),
                  child: Icon(icons[index], color: colors[index], size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(types[index].toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors[index], letterSpacing: 1)),
                          Text(times[index], style: const TextStyle(fontSize: 10, color: AppColors.greyText)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(titles[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy)),
                      const SizedBox(height: 4),
                      const Text("Detailed analysis is available in your reports.", style: TextStyle(fontSize: 12, color: AppColors.greyText)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
