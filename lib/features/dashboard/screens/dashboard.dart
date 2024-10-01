import 'package:flutter/material.dart';
import 'package:just_tickets/core/providers/event_providers.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/core/widgets/event_card.dart';
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
    final user = ref.watch(authStateNotifierProvider);
    final eventsAsyncValue = ref.watch(eventProvider); // Fetch the events
    final eventService = ref.watch(eventServiceProvider);

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
                ElevatedButton(
                  onPressed: () async {
                    await eventService.addDummyEvent();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Dummy event added to Firestore!')),
                    );
                  },
                  child: const Text('+Event'),
                ),
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
                const SizedBox(
                    height: 20), // Space between filter row and events

                // Dynamically fetching and displaying events
                eventsAsyncValue.when(
                  data: (events) => ListView.builder(
                    shrinkWrap:
                        true, // To prevent it from taking full screen height
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return EventCard(
                        event: event,
                      );
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text('Error: $error')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
