import 'package:flutter/material.dart';
import 'package:mehad/navigation/route_generator.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController code1Controller = TextEditingController();
  final TextEditingController code2Controller = TextEditingController();
  final TextEditingController code3Controller = TextEditingController();
  final TextEditingController code4Controller = TextEditingController();

  final FocusNode code1Focus = FocusNode();
  final FocusNode code2Focus = FocusNode();
  final FocusNode code3Focus = FocusNode();
  final FocusNode code4Focus = FocusNode();

  @override
  void dispose() {
    code1Controller.dispose();
    code2Controller.dispose();
    code3Controller.dispose();
    code4Controller.dispose();

    code1Focus.dispose();
    code2Focus.dispose();
    code3Focus.dispose();
    code4Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFFFF80AB);
    const lightPurple = Color(0xFFC7A7F2);
    const bgColor = Color(0xFFFCE4EC);
    const textGrey = Color(0xFF6F6A75);
    const darkText = Color(0xFF3E3A42);

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
                    "Verification",
                    style: TextStyle(
                      color: primaryPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 75),

              const Center(
                child: Text(
                  "Verify Code",
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
                    "Enter the 4-digit code sent to\nyour email address",
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

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _OtpInput(
                    controller: code1Controller,
                    focusNode: code1Focus,
                    nextFocus: code2Focus,
                    autoFocus: true,
                  ),
                  const SizedBox(width: 10),
                  _OtpInput(
                    controller: code2Controller,
                    focusNode: code2Focus,
                    previousFocus: code1Focus,
                    nextFocus: code3Focus,
                  ),
                  const SizedBox(width: 10),
                  _OtpInput(
                    controller: code3Controller,
                    focusNode: code3Focus,
                    previousFocus: code2Focus,
                    nextFocus: code4Focus,
                  ),
                  const SizedBox(width: 10),
                  _OtpInput(
                    controller: code4Controller,
                    focusNode: code4Focus,
                    previousFocus: code3Focus,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: textGrey,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Resend Code in ",
                      style: TextStyle(
                        color: textGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "00:45",
                      style: TextStyle(
                        color: primaryPurple,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

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
                    "send",
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
}

class _OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? previousFocus;
  final FocusNode? nextFocus;
  final bool autoFocus;

  const _OtpInput({
    required this.controller,
    required this.focusNode,
    this.previousFocus,
    this.nextFocus,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          color: Color(0xFF3E3A42),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xFFFDFDFE),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFC7F0D1),
              width: 1.5,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            nextFocus?.requestFocus();
          } else {
            previousFocus?.requestFocus();
          }
        },
      ),
    );
  }
}