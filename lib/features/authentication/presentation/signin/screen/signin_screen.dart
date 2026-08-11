import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';
import 'package:pulseboard_frontend/core/validators/app_validators.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';
import 'package:pulseboard_frontend/core/constants/app_colors.dart';
import 'package:pulseboard_frontend/core/widgets/app_toast.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signin/controller/signin_form_controller.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final signinForm = SigninFormController();

  Future<void> _submitForm() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref
            .read(authNotifierProvider.notifier)
            .login(signinForm.email.text, signinForm.password.text);

        final authState = ref.read(authNotifierProvider);

        if (authState.isAuthenticated && mounted) {
          AppToast.showSuccess(message: "Login Successful");
          context.go('/dashboard');
        } else if (authState.error != null) {
          AppToast.showError(
            message:
                authState.error ??
                "Login failed. Please check your credentials.",
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
                                "Welcome Back",
                                textAlign: TextAlign.center,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
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
                              // const SizedBox(height: 20),
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
            ),
          );
        },
      ),
    );
  }
}
