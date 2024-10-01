

// Create a StateProvider to hold the selected Event
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/event.dart';

final selectedEventProvider = StateProvider<Event?>((ref) {
  return null; // Initially, no event is selected
});
