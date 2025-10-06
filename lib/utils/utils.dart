// utils/payment_utils.dart
import 'dart:async';
import 'package:e_commerce_app/presentation/cart/providers/cart_providers.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_sdk/razorpay_options.dart';
import 'package:razorpay_sdk/razorpay_payment_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> startRazorpayPayment({
  required BuildContext context,
  required WidgetRef ref,
  required int amount,
  required VoidCallback onSuccess,
  VoidCallback? onError,
  int? itemId, // Optional: Pass itemId if needed
}) async {
  final razorpayService = RazorpayPaymentService();
  await razorpayService.initialize();

  late StreamSubscription successSub;
  late StreamSubscription errorSub;

  successSub = razorpayService.onPaymentSuccess.listen((_) {
    // Payment successful
    if (itemId != null) {
      ref.read(cartNotifierProvider.notifier).removeFromCart(itemId);
    } else {
      ref.read(cartNotifierProvider.notifier).clearCart();
    }

    onSuccess();

    // Clean up
    successSub.cancel();
    errorSub.cancel();
    razorpayService.dispose();
  });

  errorSub = razorpayService.onPaymentError.listen((_) {
    // Payment failed
    if (onError != null) onError();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment failed. Please try again.')),
    );

    // Clean up
    successSub.cancel();
    errorSub.cancel();
    razorpayService.dispose();
  });

  razorpayService.openCheckout(
    RazorpayOptions(
      key: "rzp_test_RKdy0tcPyKrcTE",
      amount: amount,
      name: "Demo Store",
      description: "Test Payment",
      contact: "9876543210",
      email: "test@email.com",
    ),
  );
}
