
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/features/register/screens/register_page.dart';
import 'package:just_tickets/home_base.dart';
import 'package:pinput/pinput.dart';
class OtpVerificationModal extends ConsumerWidget {
  const OtpVerificationModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationId = ref.watch(verificationIdProvider.notifier).state;
    final errorMessage = ref.watch(errorMessageProvider);
    final pinputController = TextEditingController();
    final focusNode = FocusNode();

    return FractionallySizedBox(
      heightFactor: 0.5,
      widthFactor: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Verification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 6,
                controller: pinputController,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                onCompleted: (String otp) {
                  if (otp.length == 6 && verificationId != null) {
                    FocusScope.of(context).unfocus(); // Close keyboard

                    // Trigger OTP verification
                    ref
                        .read(authStateNotifierProvider.notifier)
                        .signInWithOTP(verificationId, otp)
                        .then((_) async {
         
                      final user = ref.read(authStateNotifierProvider);
                   
                      if (user != null) {
                        // If user exists, navigate to the dashboard
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomeBase(),
                          ),
                        );
                      } else {
                        // If user doesn't exist, navigate to the registration page
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      }
                    }).catchError((e) {
                      // Handle error during OTP verification
                      ref.read(errorMessageProvider.notifier).state = '$e';
                      pinputController.clear();
                      FocusScope.of(context).requestFocus(focusNode);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Please enter the full OTP';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            if (errorMessage != null)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}