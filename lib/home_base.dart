import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/features/settings/screens/settings.dart';
import 'package:just_tickets/features/store/screens/store.dart';
import 'package:just_tickets/features/wallet/screens/wallet.dart';
import 'core/widgets/bottom_navbar.dart';
import 'features/dashboard/screens/dashboard.dart';

// Riverpod State Provider for the selected index
final gnavIndexProvider = StateProvider<int>((ref) => 0);

class HomeBase extends ConsumerWidget {
  const HomeBase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = ref.watch(gnavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const <Widget>[
          DashboardPage(),
          WalletPage(),
          StorePage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
