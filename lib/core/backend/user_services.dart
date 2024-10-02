
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_tickets/classes/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Get an instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Check if user document exists in Firestore
  Future<bool> doesUserExist(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    return userDoc.exists;
  }

  // Create user document in Firestore
  Future<void> createUserDocument(UserClass user) async {
    final usersCollection = _firestore.collection('users');
    await usersCollection.doc(user.uid).set(user.toMap(), SetOptions(merge: true));
  }

  // Get current authenticated user (from Firebase Auth)
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
