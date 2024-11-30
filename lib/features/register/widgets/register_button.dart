import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/features/register/providers/register_provider.dart';
import 'package:just_tickets/home_base.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accessing the text controllers from Riverpod providers
    final firstNameController = ref.read(firstNameControllerProvider);
    final lastNameController = ref.read(lastNameControllerProvider);
    final dateTextController = ref.read(dateTextControllerProvider);
    final emailController = ref.read(emailControllerProvider);
    final passwordController = ref.read(passwordControllerProvider);
    final confirmPasswordController =
        ref.read(confirmPasswordControllerProvider);

    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return GestureDetector(
      onTap: () async {
        // Get the current values from the text controllers
        final firstName = firstNameController.text.trim();
        final lastName = lastNameController.text.trim();
        final dateOfBirth = dateTextController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final confirmPassword = confirmPasswordController.text.trim();

        // Validation
        if (firstName.isEmpty ||
            lastName.isEmpty ||
            dateOfBirth.isEmpty ||
            email.isEmpty ||
            password.isEmpty ||
            confirmPassword.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill out all fields')),
          );
          return;
        }

        if (password != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
          return;
        }

        if (password.length < 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Password must be at least 6 characters')),
          );
          return;
        }

        try {
          // Use the updated register method with email and password
          await ref
              .read(authStateNotifierProvider.notifier)
              .registerUserWithEmailAndPassword(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                dateOfBirth: dateOfBirth,
              );

          // Navigate to HomeBase on successful registration
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeBase()),
          );
        } catch (e) {
          // Handle registration errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: $e')),
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
