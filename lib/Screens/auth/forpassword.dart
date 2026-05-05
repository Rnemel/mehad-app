import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mehad/navigation/route_generator.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFFFF80AB);
    const lightPurple = Color(0xFFC7A7F2);
    const bgColor = Color(0xFFFCE4EC);
    const textGrey = Color(0xFF6F6A75);
    const darkText = Color(0xFF3E3A42);
    const hintGrey = Color(0xFFB5AFBC);
    const fieldShadow = Color(0x14000000);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: primaryPurple,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: primaryPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              const Center(
                child: Text(
                  "Enter Email Address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: SizedBox(
                  width: 260,
                  child: Text(
                    "We will send you a 4-digit verification code to your email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 42),

              const Text(
                "Email Address",
                style: TextStyle(
                  color: textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              _buildInputField(
                hint: "example@email.com",
                icon: Icons.mail_outline,
                hintGrey: hintGrey,
                shadowColor: fieldShadow,
              ),

              const SizedBox(height: 22),

              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [primaryPurple, lightPurple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.otp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    "Send Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: textGrey,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Sign in",
                        style: const TextStyle(
                          color: primaryPurple,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInputField({
    required String hint,
    required IconData icon,
    required Color hintGrey,
    required Color shadowColor,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFE),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF5E5864),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: hintGrey,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            icon,
            color: Color(0xFFA28BB8),
            size: 20,
          ),
        ),
      ),
    );
  }
}
