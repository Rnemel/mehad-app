import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mehad/navigation/route_generator.dart';
import 'package:mehad/providers/health_provider.dart';
import 'package:mehad/theme/app_colors.dart';
import 'package:mehad/models/health_models.dart';

class HealthSettingsScreen extends StatefulWidget {
  const HealthSettingsScreen({super.key});

  @override
  State<HealthSettingsScreen> createState() => _HealthSettingsScreenState();
}

class _HealthSettingsScreenState extends State<HealthSettingsScreen> {
  bool _isScanning = false;

  void _startScan() async {
    setState(() => _isScanning = true);
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) setState(() => _isScanning = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SettingsHeader()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: -0.1, end: 0),
                  const SizedBox(height: 20),
                  const _CurrentDeviceCard()
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 600.ms)
                      .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack),
                  const SizedBox(height: 24),
                  const _MonitoringSettingsSection()
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 24),
                  _AvailableDevicesSection(isScanning: _isScanning, onScan: _startScan)
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms),
                  const SizedBox(height: 24),
                  const _DataSyncSection()
                      .animate()
                      .fadeIn(delay: 800.ms, duration: 600.ms),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFF80AB), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(color: Color(0xFFFF80AB), fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ).animate().fadeIn(delay: 1.seconds),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Smartwatch",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.navy,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F9EE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Color(0xFF3DBB6C), shape: BoxShape.circle),
              ).animate(onPlay: (c) => c.repeat()).scale(duration: 800.ms, end: const Offset(1.5, 1.5)).fadeOut(),
              const SizedBox(width: 6),
              const Text(
                "LIVE",
                style: TextStyle(
                  color: Color(0xFF3DBB6C),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CurrentDeviceCard extends StatelessWidget {
  const _CurrentDeviceCard();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF06292), Color(0xFFEC407A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC407A).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(Icons.watch_outlined, size: 140, color: Colors.white.withOpacity(0.1)),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CURRENT DEVICE",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Fitbit Sense 2",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _Tag(
                          label: provider.isWatchConnected ? "Connected" : "Disconnected",
                          icon: provider.isWatchConnected ? Icons.circle : Icons.circle_outlined,
                          iconColor: provider.isWatchConnected ? const Color(0xFFB8F1C9) : Colors.white54,
                        ),
                        const SizedBox(width: 8),
                        _Tag(
                          label: "${provider.watchBattery}%",
                          icon: Icons.battery_charging_full,
                          iconColor: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Synced ${DateFormat('h:mm a').format(provider.lastSyncTime)}",
                      style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;

  const _Tag({required this.label, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _MonitoringSettingsSection extends StatelessWidget {
  const _MonitoringSettingsSection();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthProvider>(context);
    final settings = provider.settings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "MONITORING SETTINGS",
          style: TextStyle(
            color: AppColors.greyText,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 18),
        _PremiumToggleTile(
          icon: Icons.favorite_rounded,
          title: "Heart Rate Monitoring",
          value: settings.heartRateMonitoring,
          onChanged: (val) {
            settings.heartRateMonitoring = val;
            provider.updateSettings(settings);
          },
          iconColor: const Color(0xFF9C77CA),
        ),
        const SizedBox(height: 12),
        _PremiumToggleTile(
          icon: Icons.directions_run_rounded,
          title: "Motion Detection",
          value: settings.motionDetection,
          onChanged: (val) {
            settings.motionDetection = val;
            provider.updateSettings(settings);
          },
          iconColor: const Color(0xFF699C7E),
        ),
        const SizedBox(height: 12),
        _PremiumToggleTile(
          icon: Icons.nightlight_round_rounded,
          title: "Sleep Tracking",
          value: settings.sleepTracking,
          onChanged: (val) {
            settings.sleepTracking = val;
            provider.updateSettings(settings);
          },
          iconColor: const Color(0xFF6D9C7C),
        ),
      ],
    );
  }
}

class _PremiumToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color iconColor;

  const _PremiumToggleTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.navy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryPurple,
            activeTrackColor: AppColors.primaryPurple.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class _AvailableDevicesSection extends StatelessWidget {
  final bool isScanning;
  final VoidCallback onScan;

  const _AvailableDevicesSection({required this.isScanning, required this.onScan});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "AVAILABLE DEVICES",
              style: TextStyle(
                color: AppColors.greyText,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            TextButton(
              onPressed: isScanning ? null : onScan,
              child: Row(
                children: [
                  Icon(isScanning ? Icons.hourglass_empty : Icons.refresh, size: 14, color: AppColors.primaryPurple),
                  const SizedBox(width: 6),
                  Text(isScanning ? "Scanning..." : "Scan", style: const TextStyle(color: AppColors.primaryPurple, fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (isScanning)
           Center(
             child: Column(
               children: [
                 const SizedBox(height: 20),
                 Stack(
                   alignment: Alignment.center,
                   children: [
                      Container(width: 60, height: 60, decoration: BoxDecoration(color: AppColors.primaryPurple.withOpacity(0.1), shape: BoxShape.circle)).animate(onPlay: (c) => c.repeat()).scale(duration: 2.seconds, end: const Offset(3, 3)).fadeOut(),
                      Container(width: 60, height: 60, decoration: BoxDecoration(color: AppColors.primaryPurple.withOpacity(0.15), shape: BoxShape.circle)).animate(onPlay: (c) => c.repeat()).scale(delay: 500.ms, duration: 2.seconds, end: const Offset(3, 3)).fadeOut(),
                      const Icon(Icons.bluetooth_searching, color: AppColors.primaryPurple, size: 30),
                   ],
                 ),
                 const SizedBox(height: 40),
               ],
             ),
           )
        else
          const Column(
            children: [
              _PremiumDeviceTile(name: "Fitbit Sense 2", status: "Available to connect"),
              SizedBox(height: 12),
              _PremiumDeviceTile(name: "Fitbit Versa 4", status: "Available to connect"),
            ],
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
      ],
    );
  }
}

class _PremiumDeviceTile extends StatelessWidget {
  final String name;
  final String status;

  const _PremiumDeviceTile({required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.watch_outlined, size: 22, color: AppColors.greyText),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.navy)),
                const SizedBox(height: 4),
                Text(status, style: const TextStyle(fontSize: 12, color: AppColors.greyText, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF1F8F1),
              foregroundColor: const Color(0xFF2E7D32),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text("Connect", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

class _DataSyncSection extends StatelessWidget {
  const _DataSyncSection();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "DATA SYNC",
          style: TextStyle(
            color: AppColors.greyText,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              _SyncRow(label: "Health Data", value: DateFormat('h:mm a').format(provider.lastSyncTime)),
              const SizedBox(height: 14),
              _SyncRow(label: "Activity Data", value: DateFormat('h:mm a').format(provider.lastSyncTime.subtract(const Duration(minutes: 5)))),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => provider.syncNow(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E66C9),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    "Sync Now",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 3.seconds, color: Colors.white24),
            ],
          ),
        ),
      ],
    );
  }
}

class _SyncRow extends StatelessWidget {
  final String label;
  final String value;

  const _SyncRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: AppColors.greyText, fontWeight: FontWeight.w500)),
        Text("Synced $value", style: const TextStyle(fontSize: 14, color: AppColors.navy, fontWeight: FontWeight.w900)),
      ],
    );
  }
}
