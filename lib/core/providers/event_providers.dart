import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/event.dart';
import 'package:just_tickets/features/dashboard/backend/event_repository.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository();
});

// Provider to fetch all events
final eventsProvider = FutureProvider<List<Event>>((ref) async {
  final eventRepository = ref.read(eventRepositoryProvider);
  return eventRepository.getEvents();
});

// Provider for creating or updating an event
final createOrUpdateEventProvider = Provider((ref) {
  final eventRepository = ref.read(eventRepositoryProvider);
  return (Event event) => eventRepository.createOrUpdateEvent(event);
});

// Provider for fetching a single event by ID
final eventByIdProvider =
    FutureProvider.family<Event?, String>((ref, id) async {
  final eventRepository = ref.read(eventRepositoryProvider);
  return eventRepository.getEvent(id);
});
