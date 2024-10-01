

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/event.dart';

import '../../features/dashboard/backend/event_service.dart';

final eventServiceProvider = Provider<EventService>((ref) {
  return EventService();
});

// Event provider to fetch and store events
final eventProvider = FutureProvider<List<Event>>((ref) async {
  final eventService = ref.watch(eventServiceProvider);
  return await eventService.fetchEvents();
});
