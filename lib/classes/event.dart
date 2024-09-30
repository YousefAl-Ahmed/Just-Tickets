class Event {
  final String eventId;         // Unique identifier for the event
  final String eventName;       // Name of the event
  final String organizer;       // Organizer or host of the event
  final String venue;           // Location of the event
  final DateTime eventDate;     // Date and time of the event
  final String description;     // Detailed description of the event
  final int availableTickets;   // Number of available tickets
  final double ticketPrice;     // Price per ticket
  final bool isResellable;      // Whether tickets for this event can be resold
  final List<String>? tags;     // Optional tags or categories for the event
  final List<String>? images;   // Optional images for the event

  Event({
    required this.eventId,
    required this.eventName,
    required this.organizer,
    required this.venue,
    required this.eventDate,
    required this.description,
    required this.availableTickets,
    required this.ticketPrice,
    required this.images,
    this.isResellable = false,
    this.tags,
  });

  // Factory constructor to create an Event from a Map<String, dynamic>
  factory Event.fromMap(Map<String, dynamic> data) {
    if (data['eventId'] == null || data['eventName'] == null) {
      throw ArgumentError('Missing required fields for Event');
    }

    return Event(
      eventId: data['eventId'] as String,
      eventName: data['eventName'] as String,
      organizer: data['organizer'] as String,
      venue: data['venue'] as String,
      eventDate: DateTime.parse(data['eventDate'] as String),
      description: data['description'] as String,
      availableTickets: data['availableTickets'] as int,
      ticketPrice: data['ticketPrice'] as double,
      isResellable: data['isResellable'] as bool? ?? false,
      tags: (data['tags'] as List?)?.map((tag) => tag as String).toList(),
      images: (data['images'] as List?)?.map((image) => image as String).toList(),
    );
  }

  // Converts an Event object into a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'organizer': organizer,
      'venue': venue,
      'eventDate': eventDate.toIso8601String(),
      'description': description,
      'availableTickets': availableTickets,
      'ticketPrice': ticketPrice,
      'isResellable': isResellable,
      'tags': tags,
      'images': images,
    };
  }
}
