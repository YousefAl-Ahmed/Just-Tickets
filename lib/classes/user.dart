class UserClass {
  final String uid;
  final String phoneNumber;
  final String? displayName;

  UserClass({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
  });

  // Factory constructor to create a User from a Map, with validation
  factory UserClass.fromMap(Map<String, dynamic> data) {
    if (data['uid'] == null || data['phoneNumber'] == null) {
      throw ArgumentError('Missing required fields for User');
    }

    return UserClass(
      uid: data['uid'] as String,
      phoneNumber: data['phoneNumber'] as String,
      displayName: data['displayName'] as String?,  // Nullable handling
    );
  }

  // Converts a User object into a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
    };
  }
}
