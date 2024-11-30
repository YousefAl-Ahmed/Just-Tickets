import 'package:just_tickets/classes/ticket.dart';

class UserClass {
  final String uid;
  final String? phoneNumber; // Made nullable for email/password users
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? email; // Email remains for authentication
  final List<Ticket>? bookedTickets; // To store the user's booked tickets
  final String? nfcTagId; // For NFC-based scanning
  final double? walletBalance; // Wallet balance for the user

  UserClass({
    required this.uid,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.email,
    this.bookedTickets,
    this.nfcTagId,
    this.walletBalance = 0.0, // Default wallet balance to 0.0
  });

  // Factory constructor to create a UserClass object from a Map
  factory UserClass.fromMap(Map<String, dynamic> data) {
    if (data['uid'] == null) {
      throw ArgumentError('Missing required field: uid');
    }

    return UserClass(
      uid: data['uid'] as String,
      phoneNumber: data['phoneNumber'] as String?, // Nullable
      firstName: data['firstName'] as String?,
      lastName: data['lastName'] as String?,
      dateOfBirth: data['dateOfBirth'] as String?,
      email: data['email'] as String?,
      bookedTickets:
          (data['ticketList'] as List?)?.map((e) => Ticket.fromMap(e)).toList(),
      nfcTagId: data['nfcTagId'] as String?,
      walletBalance: (data['walletBalance'] as num?)?.toDouble(),
    );
  }

  // Converts a UserClass object to a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'ticketList': bookedTickets?.map((e) => e.toMap()).toList(),
      'nfcTagId': nfcTagId,
      'walletBalance': walletBalance,
    };
  }
}
