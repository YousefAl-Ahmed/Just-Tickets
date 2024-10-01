import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_tickets/classes/event.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create or update an event
  Future<void> createOrUpdateEvent(Event event) async {
    await _firestore.collection('events').doc(event.id).set(event.toMap());
  }

  // Get a specific event
  Future<Event?> getEvent(String id) async {
    final doc = await _firestore.collection('events').doc(id).get();
    if (doc.exists) {
      return Event.fromMap(doc.data()!);
    }
    return null;
  }

  // Get all events
  Future<List<Event>> getEvents() async {
    final snapshot = await _firestore.collection('events').get();
    return snapshot.docs.map((doc) => Event.fromMap(doc.data())).toList();
  }

  // Delete an event
  Future<void> deleteEvent(String id) async {
    await _firestore.collection('events').doc(id).delete();
  }
}
