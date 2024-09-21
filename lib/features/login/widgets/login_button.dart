import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/features/login/widgets/otp_modal.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = ref.watch(phoneControllerProvider); // Get the TextEditingController from the provider
    ThemeData theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

       return GestureDetector(
      onTap: () {
        final phoneNumber = phoneController.text.trim();
        if (phoneNumber.isNotEmpty) {
          ref.read(authStateNotifierProvider.notifier).signInWithPhoneNumber(
            phoneNumber,
            (String verificationId) {
              // Store verificationId in the provider
              ref.read(verificationIdProvider.notifier).state = verificationId;
              // Hide the keyboard
              FocusScope.of(context).unfocus();

              // Show OTP verification modal sheet
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                builder: (BuildContext context) {
                  return const OtpVerificationModal();
                },
              );
            },
          );
        } else {
          // Show error message if phone number is empty
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter your mobile number')),
          );
        }
      },
      child: Container(
        width: width,
        height: 50,
      
        decoration: BoxDecoration(
          color: CustomColors.purple,
          borderRadius: BorderRadius.circular(12),
        ),  
        child:  Center(
          child: Text(
            'تسجيل الدخول',
            style: theme.textTheme.labelMedium
            ),
          ),
        ),
      );
  }
}
