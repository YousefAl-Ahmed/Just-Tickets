import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/features/login/providers/login_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final user = ref.watch(authStateNotifierProvider);

    
    return  Scaffold(
      body: Center(
        child: Text('${user?.phoneNumber}'),
      ),
    );
  }
}
