import 'package:flutter/material.dart';
import 'package:mehad/navigation/route_generator.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
 State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;

  double strength = 0.0;

  void checkStrength(String value) {
    if (value.length < 4) {
      strength = 0.2;
    } else if (value.length < 6) {
      strength = 0.4;
    } else if (value.length < 8) {
      strength = 0.7;
    } else {
      strength = 1.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFFFF80AB);
    const lightPurple = Color(0xFFFCE4EC);
    const bgColor = Color(0xFFFCE4EC);
    const textGrey = Color(0xFF6F6A75);
    const darkText = Color(0xFF3E3A42);
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
                    onPressed: () => Navigator.pop(context),
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
                    "New Password",
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
                  "Reset Password",
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
                    "Enter your new password twice below to reset a new password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Enter new password",
                style: TextStyle(
                  color: textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              _buildPasswordField(
                controller: passwordController,
                obscure: obscure1,
                onToggle: () {
                  setState(() => obscure1 = !obscure1);
                },
                onChanged: checkStrength,
              ),

              const SizedBox(height: 20),

              const Text(
                "Confirm password",
                style: TextStyle(
                  color: textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              _buildPasswordField(
                controller: confirmController,
                obscure: obscure2,
                onToggle: () {
                  setState(() => obscure2 = !obscure2);
                },
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: strength,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "STRONG",
                    style: TextStyle(
                      color: primaryPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [primaryPurple, lightPurple],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    Function(String)? onChanged,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFE),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          hintText: "••••••••",
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFFA28BB8),
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}