import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pulseboard_frontend/core/router/app_routes.dart';
import 'package:pulseboard_frontend/core/utils/api_error_handler.dart';
import 'package:pulseboard_frontend/core/validators/app_validators.dart';
import 'package:pulseboard_frontend/core/widgets/app_otp_input.dart';
import 'package:pulseboard_frontend/core/widgets/app_scaffold.dart';
import 'package:pulseboard_frontend/core/widgets/app_text_field.dart';
import 'package:pulseboard_frontend/core/widgets/app_toast.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/providers/auth_repository_provider.dart';
import 'package:pulseboard_frontend/models/data/auth_request.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  int _currentStep = 0; // 0: Email, 1: OTP, 2: Reset Password

  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _otpCode = "";
  String _verifiedCode = "";
  bool _isLoading = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  int _resendCooldown = 0;
  Timer? _resendTimer;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer([int seconds = 60]) {
    _resendTimer?.cancel();
    setState(() {
      _resendCooldown = seconds;
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 1) {
        if (mounted) {
          setState(() {
            _resendCooldown--;
          });
        }
      } else {
        timer.cancel();
        if (mounted) {
          setState(() {
            _resendCooldown = 0;
          });
        }
      }
    });
  }

  // STEP 1: Send Reset Code API
  Future<void> _handleSendResetCode() async {
    FocusScope.of(context).unfocus();
    if (!(_emailFormKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final response = await authRepository.sendVerification(
        email,
        VerificationType.forgotPassword,
        VerificationMethod.otp,
      );

      if (mounted) {
        AppToast.showSuccess(message: response.toString());
        setState(() {
          _currentStep = 1;
        });
        _startResendTimer(60);
      }
    } catch (e) {
      final errorMessage = ApiErrorHandler.getMessage(e);
      AppToast.showError(message: errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // STEP 2: Resend Code Action
  Future<void> _handleResendCode() async {
    if (_resendCooldown > 0 || _isLoading) return;
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final response = await authRepository.sendVerification(
        email,
        VerificationType.forgotPassword,
        VerificationMethod.otp,
      );

      if (mounted) {
        AppToast.showSuccess(message: response.toString());
        _startResendTimer(60);
      }
    } catch (e) {
      final errorMessage = ApiErrorHandler.getMessage(e);
      AppToast.showError(message: errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // STEP 2: Verify OTP Code API
  Future<void> _handleVerifyOtp() async {
    FocusScope.of(context).unfocus();
    if (_otpCode.trim().length < 6) {
      AppToast.showError(message: "Please enter a valid 6-digit OTP code");
      return;
    }

    final email = _emailController.text.trim();
    final code = _otpCode.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final responseMessage = await authRepository.verify(
        email,
        code,
        VerificationType.forgotPassword,
        VerificationMethod.otp,
      );

      if (mounted) {
        AppToast.showSuccess(message: responseMessage.toString());
        setState(() {
          _verifiedCode = code;
          _currentStep = 2;
        });
      }
    } catch (e) {
      final errorMessage = ApiErrorHandler.getMessage(e);
      AppToast.showError(message: errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // STEP 3: Reset Password API
  Future<void> _handleResetPassword() async {
    FocusScope.of(context).unfocus();
    if (!(_passwordFormKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailController.text.trim();
    final newPassword = _newPasswordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final message = await authRepository.resetPassword(
        email,
        _verifiedCode,
        newPassword,
      );

      if (mounted) {
        AppToast.showSuccess(message: message.toString());
        context.go(AppRoutes.signin);
      }
    } catch (e) {
      final errorMessage = ApiErrorHandler.getMessage(e);
      AppToast.showError(message: errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Step Progress Indicator
                    _buildStepIndicator(),
                    const SizedBox(height: 32),

                    // Wizard Content based on current step
                    if (_currentStep == 0)
                      _buildStep1Email(context)
                    else if (_currentStep == 1)
                      _buildStep2Otp(context)
                    else
                      _buildStep3NewPassword(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == _currentStep;
        final isCompleted = index < _currentStep;

        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isActive ? 36 : 28,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? theme.colorScheme.primary
                    : isCompleted
                        ? theme.colorScheme.primary.withValues(alpha: 0.3)
                        : theme.colorScheme.onSurface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
              ),
            ),
            if (index < 2)
              Container(
                width: 32,
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                color: index < _currentStep
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.1),
              ),
          ],
        );
      }),
    );
  }

  // UI - STEP 1: Enter Email
  Widget _buildStep1Email(BuildContext context) {
    return Form(
      key: _emailFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Icon(
            Icons.lock_reset_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            "Forgot Password?",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Enter your email address and we'll send you a 6-digit verification code to reset your password.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: AppTextField(
              label: "Email Address",
              hintText: "Enter your registered email",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.email,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isLoading ? null : _handleSendResetCode,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Send Reset Code",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: () => context.go(AppRoutes.signin),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text("Back to Sign in"),
          ),
        ],
      ),
    );
  }

  // UI - STEP 2: Enter 6-Digit OTP Code
  Widget _buildStep2Otp(BuildContext context) {
    final theme = Theme.of(context);
    final email = _emailController.text.trim();

    return Column(
      children: [
        Icon(
          Icons.mark_email_read_rounded,
          size: 64,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          "Enter Verification Code",
          style: theme.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "We sent a 6-digit code to:",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                email,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 16),
              tooltip: "Change Email",
              onPressed: () {
                setState(() {
                  _currentStep = 0;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 28),

        // 6-digit Pin Input
        AppOtpInput(
          value: _otpCode,
          length: 6,
          autofocus: true,
          onChanged: (val) {
            setState(() {
              _otpCode = val;
            });
            // Auto-submit when all 6 digits are typed
            if (val.trim().length == 6 && !_isLoading) {
              _handleVerifyOtp();
            }
          },
        ),

        const SizedBox(height: 28),

        // Resend Timer Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive code? ",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            TextButton(
              onPressed:
                  (_resendCooldown > 0 || _isLoading) ? null : _handleResendCode,
              child: Text(
                _resendCooldown > 0
                    ? "Resend Code (${_resendCooldown}s)"
                    : "Resend Code",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _resendCooldown > 0
                      ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                      : theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Verify Code Button
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed:
                (_isLoading || _otpCode.trim().length < 6) ? null : _handleVerifyOtp,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    "Verify Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _currentStep = 0;
            });
          },
          icon: const Icon(Icons.arrow_back, size: 18),
          label: const Text("Back to Email Input"),
        ),
      ],
    );
  }

  // UI - STEP 3: Set New Password
  Widget _buildStep3NewPassword(BuildContext context) {
    return Form(
      key: _passwordFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            "Set New Password",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Your identity is verified! Enter your new password below.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // New Password Field
          SizedBox(
            width: double.infinity,
            child: AppTextField(
              label: "New Password",
              hintText: "Enter at least 8 characters",
              controller: _newPasswordController,
              obscureText: _obscureNewPassword,
              validator: AppValidators.password,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureNewPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Confirm Password Field
          SizedBox(
            width: double.infinity,
            child: AppTextField(
              label: "Confirm New Password",
              hintText: "Re-enter your new password",
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please confirm your new password";
                }
                if (val != _newPasswordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Reset Password Button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isLoading ? null : _handleResetPassword,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
