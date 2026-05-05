import 'package:flutter/material.dart';
import '../Screens/auth/login_page.dart';
import '../Screens/auth/signup_page.dart';
import '../Screens/auth/forpassword.dart';
import '../Screens/auth/otp.dart';
import '../Screens/auth/resetpass.dart';
import '../Screens/auth/verify.dart';
import '../Screens/main_wrapper.dart';
import '../Screens/smartwatch.dart';
import '../Screens/predict/predict_connect_page.dart';
import '../Screens/predict/analyzing_page.dart';
import '../Screens/predict/result_page.dart';
import '../Screens/predict/error_pages.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String resetPassword = '/reset-password';
  static const String verify = '/verify';
  
  static const String dashboard = '/dashboard';
  static const String smartwatch = '/smartwatch';
  
  static const String predictConnect = '/predict-connect';
  static const String analyzing = '/analyzing';
  static const String result = '/result';
  static const String error = '/error';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _buildRoute(const LoginPage());
      case signup:
        return _buildRoute(const SignupPage());
      case forgotPassword:
        return _buildRoute(const ForgotPasswordPage());
      case otp:
        return _buildRoute(const OtpPage());
      case resetPassword:
        return _buildRoute(const ResetPasswordPage());
      case verify:
        return _buildRoute(const VerifyPage());
      
      case dashboard:
        return _buildRoute(const MainWrapper());
      case smartwatch:
        return _buildRoute(const SmartwatchPage());
      
      case predictConnect:
        return _buildRoute(const PredictConnectPage());
      case analyzing:
        return _buildRoute(const AnalyzingPage());
      case result:
        final risk = settings.arguments as String? ?? 'low';
        return _buildRoute(ResultPage(riskLevel: risk));
      case error:
        final variant = settings.arguments as String? ?? 'invalid';
        return _buildRoute(ErrorPage(variant: variant));
        
      default:
        return _buildRoute(const LoginPage());
    }
  }

  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
