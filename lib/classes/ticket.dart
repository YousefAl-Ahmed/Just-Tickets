class Ticket {
  final String ticketId;        // Unique identifier for the ticket
  final String eventId;         // Reference to the event the ticket is for
  final String eventName;       // Name of the event
  final String venue;           // Location of the event
  final DateTime eventDate;     // Date and time of the event
  final double price;           // Price of the ticket
  final bool isResellable;      // Whether the ticket is resellable or not
  final bool isScanned;         // Whether the ticket has been scanned at the event

  Ticket({
    required this.ticketId,
    required this.eventId,
    required this.eventName,
    required this.venue,
    required this.eventDate,
    required this.price,
    this.isResellable = false,
    this.isScanned = false,
  });

  // Factory constructor to create a Ticket from a Map<String, dynamic>
  factory Ticket.fromMap(Map<String, dynamic> data) {
    if (data['ticketId'] == null || data['eventId'] == null || data['eventName'] == null) {
      throw ArgumentError('Missing required fields for Ticket');
    }

    return Ticket(
      ticketId: data['ticketId'] as String,
      eventId: data['eventId'] as String,
      eventName: data['eventName'] as String,
      venue: data['venue'] as String,
      eventDate: DateTime.parse(data['eventDate'] as String),
      price: data['price'] as double,
      isResellable: data['isResellable'] as bool? ?? false,
      isScanned: data['isScanned'] as bool? ?? false,
    );
  }

  // Converts a Ticket object into a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'ticketId': ticketId,
      'eventId': eventId,
      'eventName': eventName,
      'venue': venue,
      'eventDate': eventDate.toIso8601String(),
      'price': price,
      'isResellable': isResellable,
      'isScanned': isScanned,
    };
  }
}
