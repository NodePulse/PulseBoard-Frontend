import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/validators/app_validators.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/features/authentication/signin/controller/signin_form_controller.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final signinForm = SigninFormController();

  void _submitForm() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      print(signinForm.email);
    }
  }

  @override
  void dispose() {
    super.dispose();
    signinForm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Welcome Back",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Sign in to your account",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                            ),
                            const SizedBox(height: 32),
                            Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              child: Column(
                                children: [
                                  AppTextField(
                                    label: "Email",
                                    hintText: "Email",
                                    keyboardType: TextInputType.emailAddress,
                                    controller: signinForm.email,
                                    validator: AppValidators.email,
                                    // prefixIcon: Icon(Icons.email_outlined),
                                  ),
                                  const SizedBox(height: 16),
                                  AppTextField(
                                    label: "Password",
                                    hintText: "Password",
                                    controller: signinForm.password,
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
                                    validator: AppValidators.password,
                                    // prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                  const SizedBox(height: 20),
                                  AppButton(
                                    title: "Sign In",
                                    backgroundColor: AppColors.primary,
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    onPressed: _submitForm,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Divider(
                              color: Theme.of(context).colorScheme.outline,
                              height: 1,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.push(AppRoutes.signup);
                                  },
                                  style: const ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                  ),
                                  child: const Text("Sign up"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
