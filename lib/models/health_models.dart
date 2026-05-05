import 'package:flutter/material.dart';

class VitalMetric {
  final String id;
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  VitalMetric({
    required this.id,
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });
}

class WatchSettings {
  bool heartRateMonitoring;
  bool motionDetection;
  bool sleepTracking;
  bool fallDetection;
  bool irregularHeartRhythm;

  WatchSettings({
    this.heartRateMonitoring = true,
    this.motionDetection = true,
    this.sleepTracking = true,
    this.fallDetection = true,
    this.irregularHeartRhythm = false,
  });
}

class AlertEntry {
  final DateTime timestamp;
  final String title;
  final String description;
  final String type; // 'emergency', 'warning', 'info'

  AlertEntry({
    required this.timestamp,
    required this.title,
    required this.description,
    required this.type,
  });
}
