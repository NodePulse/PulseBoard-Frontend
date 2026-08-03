import 'package:flutter/material.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';
import 'package:pulseboard_frontend/features/authentication/signup/controller/signup_form_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  final signupForm = SignupFormController();

  void _submitForm() {
    print(signupForm.firstName.text);
  }

  @override
  void dispose() {
    super.dispose();
    signupForm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: Card(
          color: Colors.transparent,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Create an Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Join PulseBoard today",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  label: "First Name",
                  hintText: "First Name",
                  controller: signupForm.firstName,
                  // prefixIcon: Icon(Icons.person_outline),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: "Last Name",
                  hintText: "Last Name",
                  controller: signupForm.lastName,
                  // prefixIcon: Icon(Icons.person_outline),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: "Email",
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: signupForm.email,
                  // prefixIcon: Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: "Password",
                  hintText: "Password",
                  controller: signupForm.password,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  // prefixIcon: Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 16),
                AppButton(
                  title: "Sign Up",
                  backgroundColor: Color.fromARGB(255, 123, 118, 255),
                  textStyle: TextStyle(color: Colors.white),
                  onPressed: () {
                    _submitForm();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
