import 'package:flutter/material.dart';

class SmartwatchPage extends StatefulWidget {
  const SmartwatchPage({super.key});

  @override
  State<SmartwatchPage> createState() => _SmartwatchPageState();
}

class _SmartwatchPageState extends State<SmartwatchPage> {
  bool heartRateMonitoring = true;
  bool motionDetection = true;
  bool sleepTracking = true;
  bool fallDetection = true;
  bool irregularHeartRhythm = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF8E6CCB);
    const Color lightPurple = Color(0xFFD8B8F7);
    const Color scaffoldBg = Color(0xFFF6F4F8);
    const Color titleColor = Color(0xFF4A4A4A);
    const Color switchPurple = Color(0xFF7F62A9);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TopBar(),
              const SizedBox(height: 16),

              // Current device card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFAF8FDF), Color(0xFFCCB3EF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600,
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha((0.20 * 255).round()),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Color(0xFFB8F1C9),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Connected",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha((0.20 * 255).round()),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.battery_6_bar,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "85%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Synced 2m ago",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.15 * 255).round()),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: const Icon(
                        Icons.watch_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                "MONITORING SETTINGS",
                style: TextStyle(
                  color: titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              _SettingTile(
                icon: Icons.favorite_border,
                iconBg: const Color(0xFFF0E4FA),
                iconColor: const Color(0xFF9C77CA),
                title: "Heart Rate Monitoring",
                value: heartRateMonitoring,
                activeColor: switchPurple,
                onChanged: (val) {
                  setState(() {
                    heartRateMonitoring = val;
                  });
                },
              ),
              const SizedBox(height: 10),

              _SettingTile(
                icon: Icons.directions_run,
                iconBg: const Color(0xFFE3F3E9),
                iconColor: const Color(0xFF699C7E),
                title: "Motion Detection",
                value: motionDetection,
                activeColor: switchPurple,
                onChanged: (val) {
                  setState(() {
                    motionDetection = val;
                  });
                },
              ),
              const SizedBox(height: 10),

              _SettingTile(
                icon: Icons.nightlight_round,
                iconBg: const Color(0xFFEAF7EF),
                iconColor: const Color(0xFF6D9C7C),
                title: "Sleep Tracking",
                value: sleepTracking,
                activeColor: switchPurple,
                onChanged: (val) {
                  setState(() {
                    sleepTracking = val;
                  });
                },
              ),
              const SizedBox(height: 10),

              _SettingTile(
                icon: Icons.personal_injury_outlined,
                iconBg: const Color(0xFFFFE6EA),
                iconColor: const Color(0xFFD27788),
                title: "Fall Detection",
                value: fallDetection,
                activeColor: switchPurple,
                onChanged: (val) {
                  setState(() {
                    fallDetection = val;
                  });
                },
              ),
              const SizedBox(height: 10),

              _SettingTile(
                icon: Icons.monitor_heart_outlined,
                iconBg: const Color(0xFFEDEEF2),
                iconColor: const Color(0xFFA0A3AC),
                title: "Irregular Heart Rhythm",
                value: irregularHeartRhythm,
                activeColor: switchPurple,
                onChanged: (val) {
                  setState(() {
                    irregularHeartRhythm = val;
                  });
                },
              ),

              const SizedBox(height: 22),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "AVAILABLE DEVICES",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1E8FB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.refresh,
                          size: 12,
                          color: primaryPurple,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Scan",
                          style: TextStyle(
                            color: primaryPurple,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              const _DeviceTile(
                name: "Fitbit Sense 2",
                subtitle: "Available to connect",
              ),
              const SizedBox(height: 10),
              const _DeviceTile(
                name: "Fitbit Versa 4",
                subtitle: "Available to connect",
              ),
              const SizedBox(height: 10),
              const _DeviceTile(
                name: "Fitbit Charge 6",
                subtitle: "Available to connect",
              ),

              const SizedBox(height: 22),

              const Text(
                "DATA SYNC",
                style: TextStyle(
                  color: titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.9 * 255).round()),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const _SyncRow(
                      title: "Health Data",
                      value: "Synced 2 min ago",
                    ),
                    const SizedBox(height: 12),
                    const _SyncRow(
                      title: "Activity Data",
                      value: "Synced 5 min ago",
                    ),
                    const SizedBox(height: 12),
                    const _SyncRow(
                      title: "Sleep Data",
                      value: "Synced 1 hr ago",
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightPurple,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Sync Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF8E6CCB);
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: primaryPurple,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            "Smartwatch",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F9EE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "LIVE",
            style: TextStyle(
              color: Color(0xFF3DBB6C),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final bool value;
  final Color activeColor;
  final ValueChanged<bool> onChanged;

  const _SettingTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.activeColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.92 * 255).round()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4A4A4A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Transform.scale(
            scale: .85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: activeColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFE2E2E7),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final String name;
  final String subtitle;

  const _DeviceTile({
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const Color green = Color(0xFFA8DEC0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.92 * 255).round()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.watch_outlined,
              size: 18,
              color: Color(0xFF7E7E89),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF4A4A4A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9A9A9A),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              "Connect",
              style: TextStyle(
                color: Color(0xFF2E6E48),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SyncRow extends StatelessWidget {
  final String title;
  final String value;

  const _SyncRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF8C8C8C),
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF4A4A4A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
