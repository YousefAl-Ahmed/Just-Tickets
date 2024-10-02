import 'package:just_tickets/classes/ticket.dart';

class UserClass {
  final String uid;
  final String phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? email;
  final List<Ticket>? bookedTickets;  // To store the user's tickets
  final String? nfcTagId;  // For NFC-based scanning
  final double? walletBalance;  // For tracking wallet balance

  UserClass({
    required this.uid,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.email,
    this.bookedTickets,
    this.nfcTagId,
    this.walletBalance = 0.0,
  });

  factory UserClass.fromMap(Map<String, dynamic> data) {
    if (data['uid'] == null || data['phoneNumber'] == null) {
      throw ArgumentError('Missing required fields for User');
    }

    return UserClass(
      uid: data['uid'] as String,
      phoneNumber: data['phoneNumber'] as String,
      firstName: data['firstName'] as String?,
      lastName: data['lastName'] as String?,
      dateOfBirth: data['dateOfBirth'] as String?,
      email: data['email'] as String?,
      bookedTickets: (data['ticketList'] as List?)?.map((e) => Ticket.fromMap(e)).toList(),  // Assuming Ticket is a class
      nfcTagId: data['nfcTagId'] as String?,
      walletBalance: data['walletBalance'] as double?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'ticketList': bookedTickets?.map((e) => e.toMap()).toList(),  // Assuming Ticket has a toMap method
      'nfcTagId': nfcTagId,
      'walletBalance': walletBalance,
    };
  }
}
