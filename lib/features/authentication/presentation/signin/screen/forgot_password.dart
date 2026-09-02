import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/validators/app_validators.dart';
import 'package:pulseboard_frontend/core/widgets/app_otp_input.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';
import 'package:pulseboard_frontend/core/widgets/app_toast.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/signin/controller/forgot_password_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/providers/auth_repository_provider.dart';
import 'package:pulseboard_frontend/core/utils/api_error_handler.dart';
import 'package:pulseboard_frontend/models/data/auth_request.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _forgotPasswordController = ForgotPasswordController();
  final _formKey = GlobalKey<FormState>();
  bool showOtpWidget = false;
  bool isLoading = false;
  String? emailError;

  @override
  void dispose() {
    _forgotPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleForgotPassword() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _forgotPasswordController.email.text.trim();

    setState(() {
      isLoading = true;
    });

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final responseMessage = await authRepository.sendVerification(
        email,
        VerificationType.forgotPassword,
        VerificationMethod.otp,
      );
      if (mounted) {
        setState(() {
          showOtpWidget = true;
        });
        AppToast.showSuccess(message: responseMessage as String);
      }
    } catch (e) {
      final errorMessage = ApiErrorHandler.getMessage(e);
      AppToast.showError(message: errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 450),
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 32,
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_reset_rounded,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Forgot Password?",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Enter the email address associated with your account and we'll send you a link to reset your password.",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: AppTextField(
                              label: "Email",
                              hintText: "Enter your email",
                              controller: _forgotPasswordController.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: AppValidators.email,
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (showOtpWidget)
                            AppOtpInput(
                              value: "",
                              autofocus: true,
                              onChanged: (v) {},
                            ),
                          if (showOtpWidget) const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: isLoading
                                  ? null
                                  : _handleForgotPassword,
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      showOtpWidget ? "Verify OTP" : "Send OTP",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextButton.icon(
                            onPressed: () => context.pop(),
                            icon: const Icon(Icons.arrow_back, size: 18),
                            label: const Text("Back to Sign in"),
                          ),
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
}
