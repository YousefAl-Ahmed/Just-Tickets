import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_tickets/classes/event.dart';
import 'package:just_tickets/classes/user.dart';

import '../../classes/ticket.dart';

class TicketService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to simulate buying a ticket
  Future<void> buyTicket(UserClass user, Event event, String ticketClass) async {
    try {
      //get a ticket based on the tickets collection inside the event collection in firestore such that ticket class is equal to the ticket class passed in the function and state is equal to available
      final QuerySnapshot snapshot = await _firestore
          .collection('events')
          .doc(event.id)
          .collection('tickets')
          .where('ticketClass', isEqualTo: ticketClass)
          .where('state', isEqualTo: 'available')
          .limit(1)
          .get();
        final ticketId = snapshot.docs.first.id;

      // Create a new Ticket object
      final newTicket = Ticket(
        ticketId: ticketId,
        ticketOwner: user.uid,
        ticketClass: ticketClass,
        state: "owned",
        eventId: event.id,
      );

      // Update the user's ticket list
      final updatedTicketList = user.bookedTickets ?? [];
      updatedTicketList.add(newTicket);

      // Upload the ticket to Firestore under the user's collection
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tickets')
          .doc(ticketId)
          .set(newTicket.toMap());
          
    await updateTicketState(event.id, ticketId, user.uid, ticketClass);

      print("Ticket purchased successfully and added to Firebase!");

    } catch (e) {
      print("Error buying ticket: $e");
      throw Exception("Failed to purchase ticket");
    }

  }

   // Fetch tickets from Firebase for a specific user
  Future<List<Ticket>> fetchUserTickets(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('tickets')
          .get();

      return snapshot.docs.map((doc) {
        return Ticket.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching tickets: $e");
      throw Exception('Failed to load tickets');
    }
  }

  // Function to update the state of a ticket inside an event collection in firestore (set owner ticketOwner to the user id) and state to owned
  Future<void> updateTicketState(String eventId, String ticketId, String userId, String ticketClass ) async {
    try {
      await _firestore
          .collection('events')
          .doc(eventId)
          .collection('tickets')
          .doc(ticketId)
          .update({
        'ticketOwner': userId,
        'state': 'owned',
      });

      //Update the number of tickets available for the specific ticket class where the ticket class is equal to the key of the map in the event collection
      await _firestore
          .collection('events')
          .doc(eventId)
          .update({
        'availabeByTicketClass.$ticketClass': FieldValue.increment(-1),
      });
      
    

    } catch (e) {
      print("Error updating ticket state: $e");
      throw Exception('Failed to update ticket state');
    }
  }
}
