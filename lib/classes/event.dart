import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final double? price;
  final DateTime startTime;
  final DateTime endTime;
  final String locationName; // Optional, human-readable name
  final GeoPoint location; // Use GeoPoint for latitude and longitude
  final String imageUrl;
  final String type; // Type of event (e.g., Concert, Sports)
  final List<String> ticketClasses;
  final int availableTickets;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.locationName,
    required this.location, // Updated to use GeoPoint
    required this.imageUrl,
    required this.type,
    required this.ticketClasses,
    required this.availableTickets,
    this.price = 0.0, // Default price is 0.0
  });

  // Convert Event to a Map (for Firebase)
  // Convert Event to a Map (for Firebase), using Timestamp for startTime and endTime
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'startTime':
          Timestamp.fromDate(startTime), // Convert DateTime to Timestamp
      'endTime': Timestamp.fromDate(endTime), // Convert DateTime to Timestamp
      'locationName': locationName,
      'location': location, // Use GeoPoint here
      'imageUrl': imageUrl,
      'type': type,
      'ticketClasses': ticketClasses,
      'availableTickets': availableTickets,
    };
  }

  // Create an Event object from a Map (from Firebase)
// Create an Event object from a Map (from Firebase)
  factory Event.fromMap(Map<String, dynamic> data) {
    return Event(
      id: data['id'] as String,
      title: data['title'] as String,
      description: data['description'] as String,
      price: (data['price'] as num).toDouble(),
      startTime: (data['startTime'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
      endTime: (data['endTime'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
      locationName: data['locationName'] as String,
      location: data['location'] as GeoPoint, // Cast to GeoPoint
      imageUrl: data['imageUrl'] as String,
      type: data['type'] as String,
      ticketClasses: List<String>.from(data['ticketClasses']),
      availableTickets: data['availableTickets'] as int,
    );
  }
}
