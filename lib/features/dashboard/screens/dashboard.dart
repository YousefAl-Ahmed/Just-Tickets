import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateNotifierProvider);

    return Scaffold(
      body: Center(
        child: user != null
            ? Text('${user.firstName} | ${user.dateOfBirth} | ${user.phoneNumber}')
            : const CircularProgressIndicator(), // Show a loading indicator until user data is fetched
      ),
    );
  }
}
