
class UserClass {
  final String uid;
  final String phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;

  UserClass({
    required this.uid,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
  });

  // Factory constructor to create a User from a Map, with validation
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

    );
  }

  // Converts a User object into a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
    };
  }
}
