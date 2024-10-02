// services/event_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_tickets/classes/event.dart';
import 'package:just_tickets/classes/ticket.dart';
import 'package:uuid/uuid.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all events from Firestore
  Future<List<Event>> fetchEvents() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('events').get();
      print('Fetched ${snapshot.docs.length} events');
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
        title: 'ليلة موسيقية مع فرقة الروك المفضلة لديك',
        description: 'كونوا جزءًا من أمسية موسيقية رائعة مع فرقة الروك المفضلة لديك',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 2)),
        locationName: 'الرياض',
        location: GeoPoint(24.7136, 46.6753), // Example geo coordinates
        imagesUrl: ['https://picsum.photos/200'],
        type: 'Concert',
        availabeByTicketClass: {
          'VIP': 20,
          'Regular': 80,
          'Economy': 30,
        },
        listOfTickets: [],

        price: 150.0,
      );

      //get document id
      final docRef = await _firestore.collection('events').add(newEvent.toMap());
      // map docRef to newEvent
      final event = Event.fromMap({
        ...newEvent.toMap(),
        'id': docRef.id,
      });
      generateTicketsForEvent(event);
      
      
      

      print('Event added successfully');
    } catch (e) {
      print('Failed to add event: $e');
    }
  }

  // Fetch event by ID from Firestore
 // Fetch event by ID from Firestore
  Future<Event?> getEventById(String eventId) async {
    try {
      final doc = await _firestore.collection('events').doc(eventId).get();
      if (doc.exists && doc.data() != null) {
    final data = doc.data() as Map<String, dynamic>;
        return Event.fromMap({
          ...data,
          'id': doc.id, // Use the document ID from Firestore
        });      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching event: $e');
      return null;
    }
  }
   final Uuid _uuid = Uuid(); // Use Uuid to generate unique ticket IDs

  // Function to generate unique tickets based on availableByTicketClass map
  Future<void> generateTicketsForEvent(Event event) async {
    try {
      print('Generating tickets for event ${event.id}');
      WriteBatch batch = _firestore.batch(); // Use Firestore batch write for efficiency

      event.availabeByTicketClass.forEach((ticketClass, availableCount) {
        for (int i = 0; i < availableCount; i++) {
          // Generate a unique ticket ID
          String ticketId = _uuid.v4();

          // Create a new ticket
          Ticket ticket = Ticket(
            ticketId: ticketId,
            state: 'available', // Initial state is 'available'
            ticketOwner: null,  // No owner yet
            ticketClass: ticketClass,
            eventId: event.id,
          );

          // Add ticket to Firestore using batch
          DocumentReference ticketRef = _firestore.collection('events').doc(event.id).collection('tickets').doc(ticketId);
          //update ticket list of event with generated class of tickets 
          // batch.update(_firestore.collection('events').doc(event.id), {
          //   'listOfTickets': FieldValue.arrayUnion([ticket.toMap()]),
          // });
          

          batch.set(ticketRef, ticket.toMap());
        }
      });

      // Commit the batch write to Firestore
      await batch.commit();
      print('Tickets generated successfully for event ${event.id}');
    } catch (e) {
      print('Error generating tickets: $e');
    }
  }
}
