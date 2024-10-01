// services/event_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_tickets/classes/event.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all events from Firestore
  Future<List<Event>> fetchEvents() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('events').get();
      final events = snapshot.docs.map((doc) {
        // Assign the Firestore document ID to the Event's id field
        final data = doc.data() as Map<String, dynamic>;
        return Event.fromMap({
          ...data,
          'id': doc.id, // Use the document ID from Firestore
        });
      }).toList();
      return events;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }

   // Function to add a dummy event to Firestore
  Future<void> addDummyEvent() async {
    try {
      final newEvent = Event(
        id: '', // Firestore will automatically generate this ID
        title: 'ليلة موسيقية رائعة',
        description: 'استمتع بأداء الفرقة الموسيقية المفضلة لديك',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 2)),
        locationName: 'الرياض',
        location: GeoPoint(24.7136, 46.6753), // Example geo coordinates
        imageUrl: 'https://picsum.photos/200',
        type: 'Concert',
        ticketClasses: ['Regular', 'VIP'],
        availableTickets: 100,
        price: 150.0,
      );

      await _firestore.collection('events').add(newEvent.toMap());
      print('Event added successfully');
    } catch (e) {
      print('Failed to add event: $e');
    }
  }
}
