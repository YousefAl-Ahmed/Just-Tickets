import 'package:just_tickets/classes/event.dart';
import 'package:just_tickets/core/backend/event_service.dart';

class EventRepository {
  final EventService _eventService = EventService();

  // Create or update an event
  Future<void> createOrUpdateEvent(Event event) {
    return _eventService.createOrUpdateEvent(event);
  }

  // Get a specific event
  Future<Event?> getEvent(String id) {
    return _eventService.getEvent(id);
  }

  // Get all events
  Future<List<Event>> getEvents() {
    return _eventService.getEvents();
  }

  // Delete an event
  Future<void> deleteEvent(String id) {
    return _eventService.deleteEvent(id);
  }
}
