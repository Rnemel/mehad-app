import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mehad/theme/constants.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  int? _userId;
  String? _role;
  bool _isLoading = false;

  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  String? get token => _token;
  int? get userId => _userId;
  String? get role => _role;

  AuthProvider() {
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    _userId = prefs.getInt('user_id');
    _role = prefs.getString('user_role');
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _token = null;
    _userId = null;
    _role = null;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'Email': email,
          'Password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        
        // Handle both possible response formats from different backend files
        _userId = data['User_ID'] ?? data['user_id'];
        _role = data['Role'] ?? data['role'];
        _token = data['access_token'] ?? "session_${_userId}"; 

        if (_userId != null && _role != null) {
          await prefs.setInt('user_id', int.parse(_userId.toString()));
          await prefs.setString('user_role', _role.toString());
          await prefs.setString('access_token', _token.toString());
          return null; // Success
        } else {
          return "Format error. Keys received: ${data.keys.join(', ')}";
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          return errorData['detail'] ?? "Login failed";
        } catch (_) {
          return "Login failed (${response.statusCode})";
        }
      }
    } catch (e) {
      return "Connection error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Name': name,
          'name': name,
          'Email': email,
          'email': email,
          'Password': password,
          'password': password,
          'Phone_Number': phoneNumber,
          'Role': role.toUpperCase(),
          'Is_Active': true,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return null; // Success
      } else {
        try {
          final errorData = jsonDecode(response.body);
          return errorData['detail'] ?? "Registration failed (${response.statusCode})";
        } catch (_) {
          return "Server error (${response.statusCode})";
        }
      }
    } catch (e) {
      return "Connection error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
