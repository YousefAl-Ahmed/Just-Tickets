import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/features/dashboard/provider/events_provider.dart';

class EventDetailsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the selected event from the provider
    final event = ref.watch(selectedEventProvider);

    // Check if event is null (in case of an error)
    if (event == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Event Details')),
        body: const Center(child: Text('No event selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(event.imageUrl),
            Text(event.title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8.0),
            Text('Description: ${event.description}'),
            Text('Location: ${event.locationName}'),
            Text('Start Time: ${event.startTime}'),
            Text('End Time: ${event.endTime}'),
            Text('Price: ${event.price != null ? '\$${event.price}' : 'Free'}'),
            Text('Available Tickets: ${event.availableTickets}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
