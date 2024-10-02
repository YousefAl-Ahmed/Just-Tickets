

// Create a StateProvider to hold the selected Event
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/event.dart';
import 'package:just_tickets/core/providers/event_providers.dart';

final selectedEventProvider = StateProvider<Event?>((ref) {
  return null; // Initially, no event is selected
});
// Provider to fetch event details using eventId
final eventByIdProvider = FutureProvider.family<Event?, String>((ref, eventId) async {
  if (eventId.isEmpty) {
    throw Exception('Invalid eventId'); // Handle empty eventId
  }
  final eventService = ref.read(eventServiceProvider);
  return await eventService.getEventById(eventId);
});