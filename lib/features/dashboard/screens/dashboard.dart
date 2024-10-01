import 'package:flutter/material.dart';

import 'package:just_tickets/features/dashboard/widgets/custom_app_bar.dart';
import 'package:just_tickets/features/dashboard/widgets/filter_row.dart';
import '../widgets/circle_filter.dart'; // Import the reusable CircleFilter widget
import 'package:just_tickets/constants/assets.dart'; // Assuming icons are stored in Assets class

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateNotifierProvider);

    return Scaffold(
      appBar: CustomAppBar(), // Your custom AppBar

      body: Padding(
        padding: const EdgeInsets.only(top: 20.0), // 20px below the AppBar
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleFilter(
                  iconAsset: Assets.theater, // Path to your icon
                  label: 'المسرحيات',
                ),
                CircleFilter(
                  iconAsset: Assets.concerts, // Path to your icon
                  label: 'الحفلات',
                ),
                CircleFilter(
                  iconAsset: Assets.sports, // Path to your icon
                  label: 'الرياضة',
                ),
                CircleFilter(
                  iconAsset: Assets.featuredEvents, // Path to your icon
                  label: 'الفعاليات المميزة',
                ),
              ],
            ),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the right (RTL)
              children: [
                // const SizedBox(height: 20), // Add padding before title
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    'الفعاليات',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                const SizedBox(
                    height: 20), // Space between title and filter row

                // Now we move to the filter row (three filter buttons)
                const FilterRow(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
