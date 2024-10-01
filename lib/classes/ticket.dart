class Ticket {
  final String ticketId;        // Unique identifier for the ticket
  final String eventId;         // Reference to the event the ticket is for
  final String eventName;       // Name of the event
  final double price;           // Price of the ticket
  final bool isResellable;      // Whether the ticket is resellable or not
  final bool isScanned;         // Whether the ticket has been scanned at the event
  final bool? isValid;          // Whether the ticket is valid or not

  Ticket({
    required this.ticketId,
    required this.eventId,
    required this.eventName,
    required this.price,
    this.isResellable = false,
    this.isScanned = false,
    this.isValid =true,
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
      price: data['price'] as double,
      isResellable: data['isResellable'] as bool? ?? false,
      isScanned: data['isScanned'] as bool? ?? false,
      isValid: data['isValid'] as bool? ?? true,

    );
  }

  // Converts a Ticket object into a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'ticketId': ticketId,
      'eventId': eventId,
      'eventName': eventName,
      'price': price,
      'isResellable': isResellable,
      'isScanned': isScanned,
      'isValid': isValid,
    };
  }
}
