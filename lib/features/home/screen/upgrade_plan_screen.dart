import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/core/widgets/app_button.dart';
import 'package:pulseboard_frontend/core/constants/subscription_plan.dart';
import 'package:pulseboard_frontend/features/home/presentation/providers/payment_repository_provider.dart';
import 'package:pulseboard_frontend/core/utils/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

final activeSubscriptionProvider =
    FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
      final repository = ref.watch(paymentRepositoryProvider);
      return repository.getActiveSubscription();
    });

class UpgradePlanScreen extends ConsumerStatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  ConsumerState<UpgradePlanScreen> createState() => _UpgradePlanScreenState();
}

class _UpgradePlanScreenState extends ConsumerState<UpgradePlanScreen> {
  String? _loadingPlanId;
  late Razorpay _razorpay;

  Future<void> _handleUpgrade(String planId) async {
    setState(() => _loadingPlanId = planId);
    try {
      final repository = ref.read(paymentRepositoryProvider);

      final payment = await repository.upgradePlan(planId, 'RAZORPAY');
      debugPrint("Payment ${payment.toString()}");

      final orderId = payment.razorpayOrderId ?? payment.id;
      if (orderId.isNotEmpty) {
        _openCheckout(orderId, payment.amount.toDouble(), planId);
      } else {
        throw Exception(
          'Did not receive a valid order ID from the server. (id: "${payment.id}", rzp: "${payment.razorpayOrderId}")',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create payment order: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loadingPlanId = null);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _handleSuccess(PaymentSuccessResponse response) async {
    Log.info('SUCCESS — payment_id: ${response.paymentId}');
    Log.info(response.toString());

    try {
      final repository = ref.read(paymentRepositoryProvider);

      await repository.completePaymentOrder(
        response.orderId ?? '',
        response.paymentId ?? '',
        response.signature ?? '',
        'SUCCEEDED',
      );

      _showDialog('Payment Success', 'Plan upgraded successfully!');
    } catch (e) {
      Log.error('Failed to complete payment order on backend: $e');
      _showDialog('Error', 'Payment succeeded but failed to sync: $e');
    }
  }

  void _handleError(PaymentFailureResponse response) {
    Log.error(
      'ERROR — code: ${response.code}, msg: ${response.message}, error: ${response.error}',
    );
    _showDialog(
      'Payment Failed',
      'Code: ${response.code}\nMessage: ${response.message}\nError: ${response.error}',
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Log.info('EXTERNAL WALLET — ${response.walletName}');
    _showDialog('External Wallet', '${response.walletName}');
  }

  void _openCheckout(String orderId, double amount, String planName) {
    const key = 'rzp_test_TO1JKZagX42mRu'; // Razorpay Test Key matching backend

    Log.debug(
      'Opening checkout with key: ${key.substring(0, key.length.clamp(0, 12))}...',
    );
    var options = {
      'key': key,
      'amount': amount.toInt(), // amount is already in paise from backend
      'name': 'PulseBoard',
      'order_id': orderId,
      'description': 'Upgrade to $planName',
      'send_sms_hash': true,
      'prefill': {'contact': '', 'email': ''},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      Log.error('EXCEPTION: $e');
      _showDialog('Error', 'Failed to open Razorpay: $e');
    } finally {
      _razorpay.clear();
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(message)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeSubAsync = ref.watch(activeSubscriptionProvider);

    return activeSubAsync.when(
      data: (activeSub) {
        // if (activeSub != null && activeSub['status'] == 'ACTIVE') {
        //   return _buildActivePlanUI(context, activeSub);
        // }
        return _buildUpgradeUI(context);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildActivePlanUI(
    BuildContext context,
    Map<String, dynamic> activeSub,
  ) {
    final theme = Theme.of(context);
    final plan = activeSub['plan'] ?? 'Unknown';

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.03)
                : Colors.black.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                "You have an active plan!",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Current Plan: $plan",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AppButton(
                  title: "Create Organization",
                  onPressed: () {
                    _showDialog(
                      'Coming Soon',
                      'Organization creation flow will be implemented here.',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpgradeUI(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.03)
                : Colors.black.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Custom Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                      color: theme.colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Unlock Your Potential",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Choose the plan that fits your team's needs.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      ...SubscriptionPlan.plans.map(
                        (plan) => _buildPlanCard(context, plan, isDark),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    Map<String, Object> plan,
    bool isDark,
  ) {
    final theme = Theme.of(context);
    final planId = plan["id"] as String;
    final isPro = planId == "PRO";
    final features = (plan["features"] as List<String>);
    final currencySymbol = plan["currency"] == "INR" ? "₹" : "\$";

    // Convert amount from paise to rupees/dollars if necessary,
    // assuming amount is stored in standard units based on earlier code
    final amountText = plan["amount"].toString();

    final isLoading = _loadingPlanId == planId;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: isPro
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withValues(
                    alpha: isDark ? 0.25 : 0.1,
                  ),
                  theme.colorScheme.surface.withValues(
                    alpha: isDark ? 0.4 : 1.0,
                  ),
                ],
              )
            : null,
        color: isPro
            ? null
            : theme.colorScheme.surface.withValues(alpha: isDark ? 0.2 : 0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isPro
              ? theme.colorScheme.primary.withValues(alpha: 0.5)
              : theme.colorScheme.outline.withValues(alpha: 0.25),
          width: isPro ? 1.5 : 1,
        ),
        boxShadow: isPro
            ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  blurRadius: 40,
                  offset: const Offset(0, 15),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (plan["name"] as String).toUpperCase(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isPro
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  letterSpacing: 1.5,
                ),
              ),
              if (isPro)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "POPULAR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$currencySymbol$amountText",
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  letterSpacing: -1,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 6),
                child: Text(
                  "/ user / ${plan["interval"]}",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ...features.map(
            (feature) => _buildFeatureItem(context, feature, isPro),
          ),
          const SizedBox(height: 40),
          AppButton(
            title: isLoading ? "Processing..." : "Upgrade to ${plan["name"]}",
            backgroundColor: isPro
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.1),
            borderSide: BorderSide.none,
            textStyle: TextStyle(
              color: isPro
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            onPressed: isLoading ? () {} : () => _handleUpgrade(planId),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text, bool isPro) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isPro
                  ? theme.colorScheme.primary.withValues(alpha: 0.2)
                  : theme.colorScheme.onSurface.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: isPro
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              size: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
