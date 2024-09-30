
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/home_base.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedIndex = ref.watch(gnavIndexProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: GNav(
        gap: 8,
        color: CustomColors.grey,
        activeColor: CustomColors.purple,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        duration: const Duration(milliseconds: 400),
        tabs: const [
          GButton(icon: Icons.home, text: 'الرئيسية'),
          GButton(icon: Icons.wallet, text: 'المحفظة'),
          GButton(icon: Icons.store, text: 'المتجر'),
          GButton(icon: Icons.settings, text: 'الاعدادات'),
        ],
        selectedIndex: selectedIndex,
        onTabChange: (index) {
          ref.read(gnavIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
