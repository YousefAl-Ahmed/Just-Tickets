
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/features/login/providers/login_providers.dart';
import 'package:just_tickets/home_base.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationModal extends ConsumerWidget {
  const OtpVerificationModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationId = ref.watch(verificationIdProvider.notifier).state;
    final errorMessage = ref.watch(errorMessageProvider); // Watch for error message updates
    final pinputController = TextEditingController(); // Controller for Pinput to reset fields
    final focusNode = FocusNode(); // Focus node to handle focus explicitly

    return FractionallySizedBox(
      heightFactor: 0.5, // Makes the modal cover half the screen
      widthFactor: 1.0, // Makes the modal cover the full width
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Verification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Pinput widget for OTP entry
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 6, // Set the length to 6 for OTP
                controller: pinputController, // Use controller to clear fields
                focusNode: focusNode, // Attach the focus node to control focus
                keyboardType: TextInputType.number, // Ensure numeric input
                onCompleted: (String otp) {
                  // When the user finishes entering the OTP, automatically verify it
                  if (otp.length == 6 && verificationId != null) {
                    FocusScope.of(context).unfocus(); // Close the keyboard

                    // Trigger OTP verification
                    ref.read(authStateNotifierProvider.notifier).signInWithOTP(
                      verificationId,
                      otp,
                    ).then((_) {
                      // Success: Navigate to the next page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeBase()));
                    }).catchError((e) {
                      // OTP verification failed, show an error and clear fields
                      ref.read(errorMessageProvider.notifier).state =
                          'OTP verification failed. Please try again.';
                      pinputController.clear(); // Clear the fields

                      // After clearing, request focus back to the first input box
                      FocusScope.of(context).requestFocus(focusNode);
                    });
                  }
                },
                // Optional: Add a validator if needed to check input validation
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Please enter the full OTP';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 20),

            // Show error message if available
            if (errorMessage != null) ...[
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}