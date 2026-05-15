import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mehad/navigation/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:mehad/providers/auth_provider.dart';
import 'package:mehad/Screens/auth/verify.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _patientEmailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _userRole = "Patient"; // "Patient" or "Caregiver"
  bool _agreedToTerms = false;


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
                  // Role Selection Toggle
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFDFE),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [BoxShadow(color: fieldShadow, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _userRole = "Patient"),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _userRole == "Patient" ? primaryPurple : Colors.transparent,
                                borderRadius: BorderRadius.circular(21),
                              ),
                              child: Text(
                                "Patient",
                                style: TextStyle(
                                  color: _userRole == "Patient" ? Colors.white : textGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _userRole = "Caregiver"),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _userRole == "Caregiver" ? primaryPurple : Colors.transparent,
                                borderRadius: BorderRadius.circular(21),
                              ),
                              child: Text(
                                "Caregiver",
                                style: TextStyle(
                                  color: _userRole == "Caregiver" ? Colors.white : textGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildLabel("Full Name"),
                  const SizedBox(height: 10),
                  _buildInputField(
                    hint: "",
                    icon: Icons.person_outline,
                    hintGrey: hintGrey,
                    shadowColor: fieldShadow,
                    controller: _nameController,
                    validator: (value) => (value == null || value.isEmpty) ? "Please enter your name" : null,
                  ),
                  const SizedBox(height: 24),
                  _buildLabel(_userRole == "Patient" ? "Email Address" : "Caregiver Email Address"),
                  const SizedBox(height: 10),
                  _buildInputField(
                    hint: "",
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
                  if (_userRole == "Caregiver") ...[
                    const SizedBox(height: 24),
                    _buildLabel("Patient's Email Address"),
                    const SizedBox(height: 10),
                    _buildInputField(
                      hint: "",
                      icon: Icons.contact_mail_outlined,
                      hintGrey: hintGrey,
                      shadowColor: fieldShadow,
                      controller: _patientEmailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter the patient\'s email';
                        if (!_isValidEmail(value)) return 'Please enter a valid email address';
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 24),
                  _buildLabel("Phone Number"),
                  const SizedBox(height: 10),
                  _buildInputField(
                    hint: "",
                    icon: Icons.phone_outlined,
                    hintGrey: hintGrey,
                    shadowColor: fieldShadow,
                    controller: _phoneController,
                    validator: (value) => (value == null || value.isEmpty) ? "Please enter your phone number" : null,
                  ),
                  const SizedBox(height: 24),
                  _buildLabel("Password"),
                  const SizedBox(height: 10),
                  _buildInputField(
                    hint: "",
                    icon: Icons.lock_outline,
                    hintGrey: hintGrey,
                    shadowColor: fieldShadow,
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) => (value == null || value.length < 6) ? "Password must be at least 6 characters" : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreedToTerms,
                          onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                          activeColor: primaryPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          side: const BorderSide(color: Color(0xFFA28BB8), width: 1.5),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "I acknowledge that this app does not monitor all pulses with absolute accuracy and should not be relied upon for medical decisions.",
                          style: TextStyle(color: textGrey, fontSize: 13, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: Consumer<AuthProvider>(
                      builder: (context, auth, child) {
                        return ElevatedButton(
                          onPressed: auth.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (!_agreedToTerms) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Please acknowledge the disclaimer to continue"),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                      return;
                                    }
                                    String? error = await auth.register(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      phoneNumber: _phoneController.text,
                                      role: _userRole,
                                    );

                                    if (error == null) {
                                      if (mounted) {
                                        Navigator.pushNamed(context, AppRoutes.verify);
                                      }
                                    } else {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                      }
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: const Color(0x33000000),
                            backgroundColor: primaryPurple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: auth.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        );
                      },
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
          errorStyle: const TextStyle(height: 0, color: Colors.transparent), // Hidden but validation works
        ),
      ),
    );
  }
}