import 'package:flutter/material.dart';
import 'package:just_tickets/features/dashboard/screens/event_details_page.dart';
import 'package:just_tickets/features/dashboard/widgets/custom_app_bar.dart';
import 'package:just_tickets/features/dashboard/widgets/filter_row.dart';
import '../widgets/circle_filter.dart'; // Import the reusable CircleFilter widget
import 'package:just_tickets/constants/assets.dart'; // Assuming icons are stored in Assets class

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/core/providers/event_providers.dart'; // Import event providers

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsyncValue =
        ref.watch(eventsProvider); // Watch the events provider

    return Scaffold(
      appBar: CustomAppBar(), // Your custom AppBar

      body: Padding(
        padding: const EdgeInsets.only(top: 20.0), // 20px below the AppBar
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleFilter(
                  iconAsset: Assets.concerts, // Path to your icon
                  label: 'الحفلات',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventDetailsPage(), // The page to navigate to
                      ),
                    );
                  }, // Empty callback for now
                ),
                CircleFilter(
                  iconAsset: Assets.concerts, // Path to your icon
                  label: 'الحفلات',
                  onTap: () {}, // Empty callback for now
                ),
                CircleFilter(
                  iconAsset: Assets.sports, // Path to your icon
                  label: 'الرياضة',
                  onTap: () {}, // Empty callback for now
                ),
                CircleFilter(
                  iconAsset: Assets.featuredEvents, // Path to your icon
                  label: 'الفعاليات المميزة',
                  onTap: () {}, // Empty callback for now
                ),
              ],
            ),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the right (RTL)
              children: [
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

                // Filter row (three filter buttons)
                const FilterRow(),

                // Add space before event list
                const SizedBox(height: 20),

                // Event List
              ],
            ),
          ],
        ),
      ),
    );
  }
}
