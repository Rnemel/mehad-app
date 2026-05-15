import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mehad/theme/constants.dart';

class HealthService {
  final String baseUrl = AppConstants.baseUrl;

  Future<bool> sendHealthData({
    required int patientId,
    required List<double> signalData,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/process-data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'patient_id': patientId,
          'data': signalData,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Health data sent successfully');
        return true;
      } else {
        print('Failed to send health data: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending health data: $e');
      return false;
    }
  }

  Future<List<dynamic>> getSeizureEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/seizure-events'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching seizure events: $e');
      return [];
    }
  }
}
