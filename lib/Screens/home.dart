import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mehad/navigation/route_generator.dart';
import 'package:mehad/providers/health_provider.dart';
import 'package:mehad/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HomeTopBar()
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: -0.2, end: 0, curve: Curves.easeOutQuad),
                    const SizedBox(height: 20),
                    const _WelcomeHeader()
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideX(begin: -0.1, end: 0, curve: Curves.easeOutQuad),
                    const SizedBox(height: 24),
                    const _SeizureRiskCard()
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 600.ms)
                        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), curve: Curves.easeOutBack),
                    const SizedBox(height: 20),
                    const _SmartwatchConnectivityCard()
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 600.ms)
                        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
                    const SizedBox(height: 20),
                    const _QuickActionsRow()
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 600.ms)
                        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
                    const SizedBox(height: 24),
                    const _SummaryHeader()
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 400.ms),
                    const SizedBox(height: 18),
                    const _VitalsSummaryGrid()
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 600.ms)
                        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu_rounded, color: AppColors.primaryPurple, size: 28),
        const Text(
          "MEHAD",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.primaryPurple,
            letterSpacing: 3,
          ),
        ),
        Stack(
          children: [
            const Icon(Icons.notifications_none_rounded, color: AppColors.primaryPurple, size: 28),
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How are you feeling today?",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.navy.withAlpha((0.9 * 255).round())),
        ),
        const SizedBox(height: 6),
        const Text(
          "MEHAD Health and Wellness Companion",
          style: TextStyle(fontSize: 14, color: AppColors.greyText, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _SeizureRiskCard extends StatelessWidget {
  const _SeizureRiskCard();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withAlpha((0.06 * 255).round()),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CURRENT SEIZURE RISK",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.greyText,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(radius: 4, backgroundColor: Color(0xFF2E7D32)).animate(onPlay: (controller) => controller.repeat()).scale(duration: 1.seconds, curve: Curves.easeInOut).then().scale(end: const Offset(0.7,0.7)),
                      const SizedBox(width: 10),
                      Text(
                        provider.riskLevel,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const _RiskGaugeIndicator(value: 0.15),
        ],
      ),
    );
  }
}

class _RiskGaugeIndicator extends StatelessWidget {
  final double value;
  const _RiskGaugeIndicator({required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      height: 95,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 9,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation(Colors.grey.shade100),
          ),
          CircularProgressIndicator(
            value: value,
            strokeWidth: 9,
            strokeCap: StrokeCap.round,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation(Color(0xFF2E7D32)),
          ).animate().rotate(duration: 1.seconds, begin: -0.1, end: 0, curve: Curves.easeOutBack),
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
            child: const Icon(Icons.shield_outlined, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class _SmartwatchConnectivityCard extends StatelessWidget {
  const _SmartwatchConnectivityCard();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthProvider>(context);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.smartwatch),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.primaryPurple.withAlpha((0.05 * 255).round())),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha((0.02 * 255).round()),
                blurRadius: 15,
                offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.lightPurple.withAlpha((0.4 * 255).round()), borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.watch_outlined, color: AppColors.primaryPurple, size: 24),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(duration: 2.seconds, color: Colors.white38),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.isWatchConnected ? "Smartwatch Active" : "Watch Disconnected",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(width: 6, height: 6, decoration: BoxDecoration(color: provider.isWatchConnected ? Colors.green : Colors.red, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text(
                        provider.isWatchConnected ? "Syncing data in real-time" : "Pair your device in settings",
                        style: const TextStyle(fontSize: 11, color: AppColors.greyText, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              provider.isWatchConnected ? Icons.signal_cellular_alt_rounded : Icons.signal_cellular_connected_no_internet_4_bar_rounded,
              color: provider.isWatchConnected ? const Color(0xFF2E7D32) : Colors.redAccent,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _ActionTile(
            label: "Emergency",
            icon: Icons.warning_amber_rounded,
            color: Color(0xFFB43752),
            isPrimary: true,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.predictConnect),
            child: const _ActionTile(
              label: "AI Prediction",
              icon: Icons.auto_awesome_rounded,
              color: AppColors.primaryPurple,
              isPrimary: false,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isPrimary;

  const _ActionTile({required this.label, required this.icon, required this.color, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      decoration: BoxDecoration(
        color: isPrimary ? color : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: isPrimary 
            ? [BoxShadow(color: color.withAlpha((0.3 * 255).round()), blurRadius: 16, offset: const Offset(0, 8))]
            : [BoxShadow(color: Colors.black.withAlpha((0.03 * 255).round()), blurRadius: 10, offset: const Offset(0, 4))],
        border: isPrimary ? null : Border.all(color: Colors.black.withAlpha((0.04 * 255).round())),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isPrimary ? Colors.white : color, size: 28).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(begin: -2, end: 2, duration: 1500.ms, curve: Curves.easeInOut),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(color: isPrimary ? Colors.white : color, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Today's Summary", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.navy)),
        Text("Detailed Insights", style: TextStyle(fontSize: 13, color: AppColors.primaryPurple, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _VitalsSummaryGrid extends StatelessWidget {
  const _VitalsSummaryGrid();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthProvider>(context);
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: "Heart Rate",
            value: "${provider.currentHeartRate}",
            unit: "bpm",
            icon: Icons.favorite_rounded,
            color: const Color(0xFFFDEDEB),
            iconColor: Colors.redAccent,
            hasPulse: true,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _SummaryCard(
            label: "Sleep",
            value: "${provider.sleepQuality}",
            unit: "hrs",
            icon: Icons.nightlight_round_rounded,
            color: const Color(0xFFF0F4FE),
            iconColor: Colors.blueAccent,
            hasPulse: false,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final bool hasPulse;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.iconColor,
    this.hasPulse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(28), 
          border: Border.all(color: Colors.black.withAlpha((0.04 * 255).round())),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.01 * 255).round()), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(8), 
              decoration: BoxDecoration(color: color, shape: BoxShape.circle), 
              child: Icon(icon, color: iconColor, size: 18).animate(onPlay: (c) => c.repeat()).scale(duration: 800.ms, begin: const Offset(1,1), end: const Offset(1.2,1.2), curve: Curves.easeInOut).then().scale(duration: 800.ms, end: const Offset(1,1))),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(width: 4),
              Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(unit, style: const TextStyle(fontSize: 12, color: AppColors.greyText, fontWeight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14, color: AppColors.greyText, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
