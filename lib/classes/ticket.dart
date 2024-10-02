class Ticket {
  final String ticketId;        // Unique identifier for the ticket
  final String state;         // Whether the ticket has been scanned at the event
  final String? ticketOwner; // The user who owns the ticket
  final String ticketClass; // The class of the ticket (e.g., VIP, Regular)
  final String eventId; // The event ID for the ticket

  Ticket({
    required this.ticketId,
    required this.state,
    this.ticketOwner,
    required this.ticketClass,
    required this.eventId,
  });

  // Factory constructor to create a Ticket from a Map<String, dynamic>
  factory Ticket.fromMap(Map<String, dynamic> data) {
    if (data['ticketId'] == null || data['eventId'] == null) {
      throw ArgumentError('Missing required fields for Ticket');
    }

    return Ticket(
      ticketId: data['ticketId'] as String,
      state: data['state'] as String,
      ticketOwner: data['ticketOwner'] as String?,
      ticketClass: data['ticketClass'] as String,
      eventId: data['eventId'] as String,


    );
  }

  // Converts a Ticket object into a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'ticketId': ticketId,
      'state': state,
      'ticketOwner': ticketOwner,
      'ticketClass': ticketClass,
      'eventId': eventId,
    };
  }
}
