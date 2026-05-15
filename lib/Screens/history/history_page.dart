import 'package:flutter/material.dart';
import 'package:mehad/theme/app_colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Analysis History", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: 8,
        itemBuilder: (context, index) {
          final dates = ["Today", "Yesterday", "Oct 12, 2026", "Oct 11, 2026", "Oct 10, 2026", "Oct 09, 2026", "Oct 08, 2026", "Oct 07, 2026"];
          final results = ["Normal", "Low Risk", "Normal", "Normal", "Follow-up", "Normal", "Low Risk", "Normal"];
          final bms = ["72 bpm", "78 bpm", "68 bpm", "70 bpm", "85 bpm", "72 bpm", "80 bpm", "71 bpm"];
          final colors = [Colors.green, Colors.teal, Colors.green, Colors.green, Colors.orange, Colors.green, Colors.teal, Colors.green];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.black.withOpacity(0.03)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dates[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 4),
                    const Text("AI Health Analysis", style: TextStyle(fontSize: 11, color: AppColors.greyText)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: colors[index].withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: Text(results[index], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: colors[index])),
                    ),
                    const SizedBox(height: 6),
                    Text(bms[index], style: const TextStyle(fontSize: 12, color: AppColors.greyText, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.subGreyText),
              ],
            ),
          );
        },
      ),
    );
  }
}
