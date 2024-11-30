import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/features/register/providers/register_provider.dart';
import 'package:just_tickets/home_base.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    return GestureDetector(
      onTap: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all fields')),
          );
          return;
        }

        try {
          // Use the sign-in method
          await ref
              .read(authStateNotifierProvider.notifier)
              .signInWithEmailAndPassword(
                email,
                password,
              );

          // Navigate to the dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeBase()),
          );
        } catch (e) {
          // Handle sign-in errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: $e')),
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: CustomColors.purple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'تسجيل الدخول',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
