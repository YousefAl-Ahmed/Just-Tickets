import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:just_tickets/classes/user.dart';

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);



class AuthStateNotifier extends StateNotifier<UserClass?> {
  final firebase_auth.FirebaseAuth _auth;

  AuthStateNotifier(this._auth) : super(null) {
    _auth.authStateChanges().listen((firebaseUser) {
      state = firebaseUser != null
          ? UserClass.fromMap({
              'uid': firebaseUser.uid,
              'phoneNumber': firebaseUser.phoneNumber,
              'displayName': firebaseUser.displayName,
            })
          : null;
    });
  }

  Future<void> signInWithPhoneNumber(String phoneNumber, Function(String) codeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
     verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      
      },      verificationFailed: (e) => print('Verification failed: ${e.message}'),
      codeSent: (verificationId, _) => codeSent(verificationId),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<void> signInWithOTP(String verificationId, String smsCode) async {
    await _auth.signInWithCredential(firebase_auth.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    ));
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = null;
  }
}


final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, UserClass?>((ref) {
  final auth = ref.watch(authProvider);
  return AuthStateNotifier(auth);
});


final verificationIdProvider = StateProvider<String?>((ref) => null);
final errorMessageProvider = StateProvider<String?>((ref) => null);
final phoneControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
