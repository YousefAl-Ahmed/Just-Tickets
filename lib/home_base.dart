import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:just_tickets/features/settings/screens/settings.dart';
import 'package:just_tickets/features/store/screens/store.dart';
import 'package:just_tickets/features/wallet/screens/wallet.dart';

import 'features/dashboard/screens/dashboard.dart';

final gnavIndexProvider = StateProvider<int>((ref) => 0);

class HomeBase extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = ref.watch(gnavIndexProvider);

    void onItemTapped(int index) {
      ref.read(gnavIndexProvider.notifier).state = index;
    }

    return Scaffold(
      body: IndexedStack(
        index: ref.watch(gnavIndexProvider.notifier).state,
        children: const <Widget>[
          DashboardPage(),
          WalletPage(),
          StorePage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: GNav(
          gap: 8,
          color: Colors.white,
          activeColor: Colors.white,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.blue.withOpacity(0.5),
          tabs: const [
            GButton(icon: Icons.home, text: 'الرئيسية'),
            GButton(icon: Icons.account_balance_wallet, text: 'المحفظة'),
            GButton(icon: Icons.store, text: 'المتجر'),
            GButton(icon: Icons.settings, text: 'الاعدادات'),
          ],
          selectedIndex: selectedIndex,
          onTabChange: onItemTapped,
        ),
      ),
    );
  }
}
