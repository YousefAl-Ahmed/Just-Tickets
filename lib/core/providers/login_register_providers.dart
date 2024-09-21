import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_tickets/classes/user.dart';

// Firestore provider
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// FirebaseAuth provider
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// AuthStateNotifier
class AuthStateNotifier extends StateNotifier<UserClass?> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthStateNotifier(this._auth, this._firestore) : super(null) {
    // If there's a current user, check if the user exists in Firestore
    if (_auth.currentUser != null) {
      _checkAndSetUser(_auth.currentUser!.uid);
    }

    // Listen to authentication state changes
    _auth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser != null) {
        _checkAndSetUser(firebaseUser.uid);
      } else {
        state = null; // No user is signed in
      }
    });
  }

  // Check if user exists in Firestore and set the state accordingly
  Future<void> _checkAndSetUser(String uid) async {
    if (await isUserExists(uid)) {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      state = UserClass.fromMap(userDoc.data()!);
    } else {
      state = null;
      print('User does not exist in Firestore.');
    }
  }

  // Function to check if a user exists in Firestore
  Future<bool> isUserExists(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    return userDoc.exists;
  }

  // Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
    state = null;
  }

  // Method to sign in with phone number and send OTP
  Future<void> signInWithPhoneNumber(
      String phoneNumber, Function(String) codeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        // After sign-in, check if user exists in Firestore
        await _checkAndSetUser(_auth.currentUser!.uid);
      },
      verificationFailed: (e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (verificationId, _) => codeSent(verificationId),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  // Sign in with OTP and verification ID
  Future<void> signInWithOTP(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential);

    // After sign-in, check if user exists in Firestore
    await _checkAndSetUser(_auth.currentUser!.uid);
  }

  // Register a new user and update the state
  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String dateOfBirth,
  }) async {
    final uid = _auth.currentUser!.uid;

    final userData = {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
    };

    await _firestore.collection('users').doc(uid).set(userData);

    // Update the state with the registered user
    state = UserClass.fromMap(userData);
  }
}

// AuthStateNotifier provider
final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, UserClass?>((ref) {
  final auth = ref.watch(authProvider);
  final firestore = ref.watch(firestoreProvider);
  return AuthStateNotifier(auth, firestore);
});

// State provider for verification ID and error message
final verificationIdProvider = StateProvider<String?>((ref) => null);
final errorMessageProvider = StateProvider<String?>((ref) => null);

// State provider for phone controller
final phoneControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
