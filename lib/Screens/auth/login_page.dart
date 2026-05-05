import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mehad/navigation/route_generator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFFFF80AB);
    const bgColor = Color(0xFFFCE4EC);
    const textGrey = Color(0xFF6F6A75);
    const hintGrey = Color(0xFF8E8897);
    const fieldShadow = Color(0x14000000);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Form(
                    key: _formKey,
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const Spacer(),

                          const Text(
                            "MEHAD",
                            style: TextStyle(
                              color: primaryPurple,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Sign in to continue your wellness journey",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 38),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email Address",
                              style: TextStyle(
                                color: textGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          _buildInputField(
                            hint: "name@example.com",
                            icon: Icons.mail_outline,
                            hintGrey: hintGrey,
                            shadowColor: fieldShadow,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter an email';
                              if (!_isValidEmail(value)) return 'Please enter a valid email';
                              return null;
                            },
                          ),

                          const SizedBox(height: 22),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                color: textGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          _buildInputField(
                            hint: "••••••••",
                            icon: Icons.lock_outline,
                            hintGrey: hintGrey,
                            shadowColor: fieldShadow,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.forgotPassword);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: primaryPurple,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 26),

                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                shadowColor: const Color(0x33000000),
                                backgroundColor: primaryPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 48),

                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 15,
                                color: textGrey,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                const TextSpan(text: "Don’t have an account? "),
                                TextSpan(
                                  text: "Sign Up",
                                  style: const TextStyle(
                                    color: primaryPurple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, AppRoutes.signup);
                                    },
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required Color hintGrey,
    required Color shadowColor,
    required TextInputType keyboardType,
    bool obscureText = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFE),
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF5E5864),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: hintGrey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFA28BB8),
            size: 22,
          ),
          errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        ),
      ),
    );
  }
}