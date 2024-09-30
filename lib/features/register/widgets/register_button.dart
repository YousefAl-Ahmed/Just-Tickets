import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/features/register/providers/register_provider.dart';
import 'package:just_tickets/home_base.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/services/date_format.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accessing the text controllers from Riverpod providers
    final firstNameController = ref.read(firstNameControllerProvider);
    final lastNameController = ref.read(lastNameControllerProvider);
    final dateTextController = ref.read(dateTextControllerProvider); 
    final phoneController = ref.read(phoneControllerProvider);
    final emailController = ref.read(emailControllerProvider);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return GestureDetector(
      onTap: () {
        // Get the current values from the text controllers
        final firstName = firstNameController.text.trim();
        final lastName = lastNameController.text.trim();
        final dateOfBirth = dateTextController.text.trim(); // Read from the date controller

        if (firstName.isNotEmpty && lastName.isNotEmpty && dateOfBirth.isNotEmpty) {
          final phoneNumber = phoneController.text.trim();

          // Use the current values from providers to register the user
          ref.read(authStateNotifierProvider.notifier).registerUser(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            dateOfBirth: dateOfBirth,
            email: emailController.text.trim(),
          );

          // Navigate to HomeBase
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeBase()));
        } else {
          // Handle validation error, e.g., show a snackbar or alert
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill out all fields')),
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
        child: Center(
          child: Text(
            'انشاء حساب',
            style: theme.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
