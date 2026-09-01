import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/widgets/app_toast.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signup/controller/signup_form_controller.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final signupForm = SignupFormController();

  Future<void> _submitForm(bool isWeb) async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref
            .read(authNotifierProvider.notifier)
            .register(
              signupForm.firstName.text,
              signupForm.lastName.text,
              signupForm.email.text,
              signupForm.password.text,
            );

        final authState = ref.read(authNotifierProvider);

        if (authState.isAuthenticated && mounted) {
          AppToast.showSuccess(message: "Registration Successful");
          context.go(AppRoutes.emailSent);
        } else if (authState.error != null) {
          AppToast.showError(
            message:
                authState.error ?? "Registration failed. Please try again.",
          );
        }
      } catch (e) {
        AppToast.showError(message: "An unexpected error occurred.");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    signupForm.dispose();
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
                    child: ZoSegmentBorder(
                      segmentLength: 0.2,
                      glowOpacity: 1.0,
                      glowRadius: 10,
                      colors: const [
                        Colors.transparent,
                        Colors.cyanAccent,
                        Colors.cyanAccent,
                        Colors.transparent,
                      ],
                      borderRadius: 20,
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Create an Account",
                                textAlign: TextAlign.center,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Join PulseBoard today",
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
                                            _obscurePassword =
                                                !_obscurePassword;
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
                                    const SizedBox(height: 20),
                                    AppButton(
                                      title: "Sign Up",
                                      backgroundColor: AppColors.primary,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _submitForm(kIsWeb),
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
                              // const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.go(AppRoutes.signin);
                                    },
                                    style: const ButtonStyle(
                                      overlayColor: WidgetStatePropertyAll(
                                        Colors.transparent,
                                      ),
                                    ),
                                    child: const Text("Sign in"),
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
            ),
          );
        },
      ),
    );
  }
}
