import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mehad/models/health_models.dart';
import 'package:mehad/theme/app_colors.dart';
import 'package:mehad/providers/health_service.dart';

class HealthProvider with ChangeNotifier {
  final HealthService _healthService = HealthService();
  
  // Watch State
  bool _isWatchConnected = true;
  int _watchBattery = 85;
  DateTime _lastSyncTime = DateTime.now().subtract(const Duration(minutes: 2));
  WatchSettings _settings = WatchSettings();
  
  // Vitals
  int _currentHeartRate = 72;
  double _sleepQuality = 8.2;
  double _glucoseLevel = 95.0;
  String _riskLevel = "Low Risk";
  
  // Simulation Timers
  Timer? _vitalsTimer;
  
  HealthProvider() {
    _loadFromPrefs();
    _startSimulation();
  }

  // Getters
  bool get isWatchConnected => _isWatchConnected;
  int get watchBattery => _watchBattery;
  DateTime get lastSyncTime => _lastSyncTime;
  WatchSettings get settings => _settings;
  int get currentHeartRate => _currentHeartRate;
  double get sleepQuality => _sleepQuality;
  double get glucoseLevel => _glucoseLevel;
  String get riskLevel => _riskLevel;

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isWatchConnected = prefs.getBool('isWatchConnected') ?? true;
    
    // Load individual settings
    _settings.heartRateMonitoring = prefs.getBool('hrMonitoring') ?? true;
    _settings.motionDetection = prefs.getBool('motionDetection') ?? true;
    _settings.sleepTracking = prefs.getBool('sleepTracking') ?? true;
    _settings.fallDetection = prefs.getBool('fallDetection') ?? true;
    _settings.irregularHeartRhythm = prefs.getBool('irregularHeart') ?? false;
    
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isWatchConnected', _isWatchConnected);
    await prefs.setBool('hrMonitoring', _settings.heartRateMonitoring);
    await prefs.setBool('motionDetection', _settings.motionDetection);
    await prefs.setBool('sleepTracking', _settings.sleepTracking);
    await prefs.setBool('fallDetection', _settings.fallDetection);
    await prefs.setBool('irregularHeart', _settings.irregularHeartRhythm);
  }

  void _startSimulation() {
    _vitalsTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_isWatchConnected) {
        // Simulate heart rate fluctuation
        _currentHeartRate = 68 + math.Random().nextInt(15);
        
        // Slightly drain battery
        if (math.Random().nextDouble() > 0.8 && _watchBattery > 0) {
          _watchBattery--;
        }
        
        notifyListeners();
      }
    });
  }

  // Actions
  void toggleWatchConnection() {
    _isWatchConnected = !_isWatchConnected;
    _saveToPrefs();
    notifyListeners();
  }

  void updateSettings(WatchSettings newSettings) {
    _settings = newSettings;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> syncNow() async {
    await Future.delayed(const Duration(seconds: 2));
    _lastSyncTime = DateTime.now();
    notifyListeners();
  }

  Future<void> sendCurrentVitalsToBackend(int patientId) async {
    // Generate some mock signal data for the AI model (15360 points as required by backend)
    List<double> mockSignal = List.generate(15360, (index) => math.Random().nextDouble());
    
    bool success = await _healthService.sendHealthData(
      patientId: patientId,
      signalData: mockSignal,
    );
    
    if (success) {
      print("Vitals sent and processed by AI backend");
    }
  }

  void triggerEmergency() {
    print("EMERGENCY TRIGGERED");
  }

  @override
  void dispose() {
    _vitalsTimer?.cancel();
    super.dispose();
  }
}
