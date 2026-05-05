import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mehad/navigation/route_generator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 55),
                  const Text("MEHAD", style: TextStyle(color: primaryPurple, fontSize: 34, fontWeight: FontWeight.w800, letterSpacing: -1)),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 280,
                    child: Text(
                      "Create your account to start your wellness\njourney",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textGrey, fontSize: 15, height: 1.5, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 38),
                  _buildLabel("Full Name"),
                  const SizedBox(height: 10),
                  _buildInputField(hint: "Majd S..", icon: Icons.person_outline, hintGrey: hintGrey, shadowColor: fieldShadow),
                  const SizedBox(height: 24),
                  _buildLabel("Email Address"),
                  const SizedBox(height: 10),
                  _buildInputField(
                    hint: "example@email.com",
                    icon: Icons.mail_outline,
                    hintGrey: hintGrey,
                    shadowColor: fieldShadow,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter an email';
                      if (!_isValidEmail(value)) return 'Please enter a valid email address';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildLabel("Phone Number"),
                  const SizedBox(height: 10),
                  _buildInputField(hint: "+966 50 000 0000", icon: Icons.phone_outlined, hintGrey: hintGrey, shadowColor: fieldShadow),
                  const SizedBox(height: 24),
                  _buildLabel("Password"),
                  const SizedBox(height: 10),
                  _buildInputField(hint: "••••••••", icon: Icons.lock_outline, hintGrey: hintGrey, shadowColor: fieldShadow, obscureText: true),
                  const SizedBox(height: 42),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, AppRoutes.verify);
                        }
                      },
                      style: ElevatedButton.styleFrom(elevation: 4, shadowColor: const Color(0x33000000), backgroundColor: primaryPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 58),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 15, color: textGrey, fontWeight: FontWeight.w400),
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Sign In",
                          style: const TextStyle(color: primaryPurple, fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(alignment: Alignment.centerLeft, child: Text(text, style: const TextStyle(color: Color(0xFF6F6A75), fontSize: 16, fontWeight: FontWeight.w500)));
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required Color hintGrey,
    required Color shadowColor,
    bool obscureText = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFE),
        borderRadius: BorderRadius.circular(27),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 16, color: Color(0xFF5E5864)),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          hintText: hint,
          hintStyle: TextStyle(color: hintGrey, fontSize: 16, fontWeight: FontWeight.w400),
          prefixIcon: Icon(icon, color: const Color(0xFFA28BB8), size: 22),
          errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        ),
      ),
    );
  }
}
